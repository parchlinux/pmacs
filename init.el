;;; init.el --- pmacs initialization -*- lexical-binding: t; -*-

(require 'pmacs)
(require 'pmacs-lib)
(require 'pmacs-packages)
(require 'pmacs-ui)
(require 'pmacs-editor)
(require 'pmacs-keybinds)
(require 'pmacs-parch)

(defun pmacs-init-modules ()
  (interactive)
  (let ((loaded 0))
    (dolist (dir (directory-files pmacs-module-dir t "\\`[a-z-]+\\'" t))
      (when (file-directory-p dir)
        (let ((pkg-file (expand-file-name "packages.el" dir)))
          (when (file-exists-p pkg-file)
            (condition-case nil (load pkg-file nil t) (error nil))))
        (let ((cfg-file (expand-file-name "config.el" dir)))
          (when (file-exists-p cfg-file)
            (condition-case nil
                (progn (load cfg-file nil t) (cl-incf loaded))
              (error nil))))))
    (message "pmacs: loaded %d modules" loaded)))

(defun pmacs-init-user-config ()
  (let ((config-file (expand-file-name "config.el" pmacs-user-dir)))
    (if (file-exists-p config-file)
        (load config-file nil t)
      (with-temp-file config-file
        (insert ";;; config.el --- pmacs user configuration -*- lexical-binding: t; -*-\n"
                "\n;;; Code:\n\n;; (setq pmacs-theme 'doom-one)\n\n;;; config.el ends\n")))))

(pmacs-init-keybinds)
(pmacs-init-modules)
(pmacs-init-user-config)
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
            (pmacs-load-theme)
            (message "pmacs %s loaded" pmacs-version)))

(provide 'init)
;;; init.el ends here
