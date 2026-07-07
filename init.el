;;; init.el --- pmacs initialization -*- lexical-binding: t; -*-
;;; Commentary:
;; pmacs - An Emacs distribution for Parch Gnu/Linux.
;;
;; Startup sequence:
;;   1. early-init.el    - Performance optimizations
;;   2. init.el          - This file
;;   3. pmacs.el         - Core definitions
;;   4. pmacs-lib.el     - Utility macros
;;   5. pmacs-packages.el - Package management
;;   6. pmacs-ui.el      - UI defaults
;;   7. pmacs-editor.el  - Editor defaults
;;   8. pmacs-keybinds.el - Keybinding layer
;;   9. pmacs-parch.el   - Parch integration
;;  10. Module configs
;;  11. User config      - ~/.config/pmacs/config.el
;;; Code:

(require 'pmacs)
(require 'pmacs-lib)
(require 'pmacs-packages)
(require 'pmacs-ui)
(require 'pmacs-editor)
(require 'pmacs-keybinds)
(require 'pmacs-parch)
(require 'pmacs-dashboard)

(defun pmacs-init-modules ()
  "Initialize all pmacs modules."
  (interactive)
  (let ((loaded 0))
    (dolist (dir (directory-files pmacs-module-dir t "\\`[a-z-]+\\'" t))
      (when (file-directory-p dir)
        (let ((pkg-file (expand-file-name "packages.el" dir)))
          (when (file-exists-p pkg-file)
            (condition-case nil (load pkg-file nil t)
              (error nil))))
        (let ((cfg-file (expand-file-name "config.el" dir)))
          (when (file-exists-p cfg-file)
            (condition-case nil
                (progn (load cfg-file nil t) (cl-incf loaded))
              (error nil))))))
    (message "pmacs: loaded %d modules" loaded)))

(defun pmacs-init-user-config ()
  "Load the user's configuration file."
  (let ((config-file (expand-file-name "config.el" pmacs-user-dir)))
    (if (file-exists-p config-file)
        (load config-file nil t)
      (with-temp-file config-file
        (insert ";;; config.el --- pmacs user configuration -*- lexical-binding: t; -*-\n"
                "\n"
                ";;; Code:\n"
                "\n"
                ";; (setq pmacs-theme 'doom-one)\n"
                ";; (setq pmacs-font \"JetBrains Mono-14\")\n"
                "\n"
                ";;; config.el ends\n")))))

(pmacs-init-modules)
(pmacs-init-user-config)
(pmacs-init-keybinds)
(pmacs-init-parch-keybinds)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 8 1024 1024)
                  gc-cons-percentage 0.1)
            (when pmacs--file-name-handler-alist
              (setq file-name-handler-alist
                    (append pmacs--file-name-handler-alist
                            file-name-handler-alist)))
            (pmacs-init-fonts)
            (pmacs--check-nerd-icons-fonts)
            (pmacs-load-theme)
            (recentf-mode 1)
            (setq recentf-max-saved-items 100)
            (message "pmacs %s loaded in %.2f seconds"
                     pmacs-version
                     (float-time
                      (time-subtract after-init-time before-init-time)))))

(add-hook 'window-setup-hook #'pmacs-dashboard--schedule)

(provide 'init)
;;; init.el ends here
