;;; pmacs.el --- pmacs core definitions -*- lexical-binding: t; -*-

(require 'cl-lib)

(defconst pmacs-version "0.1.0")

(defconst IS-MAC   (eq system-type 'darwin))
(defconst IS-LINUX (eq system-type 'gnu/linux))
(defconst IS-WIN   (eq system-type 'windows-nt))
(defconst IS-BSD   (or IS-MAC (eq system-type 'berkeley-unix)))

(defconst EMACS28+ (>= emacs-major-version 28))
(defconst EMACS29+ (>= emacs-major-version 29))
(defconst EMACS30+ (>= emacs-major-version 30))

(defconst pmacs-dir
  (cond
   (load-in-progress
    (file-name-directory
     (directory-file-name
      (file-name-directory
       (directory-file-name load-file-name)))))
   ((boundp 'user-emacs-directory)
    (expand-file-name user-emacs-directory))
   (t
    (expand-file-name default-directory))))

(defconst pmacs-core-dir (concat pmacs-dir "lisp/"))
(defconst pmacs-module-dir (concat pmacs-dir "modules/"))
(defconst pmacs-theme-dir (concat pmacs-dir "themes/"))
(defconst pmacs-snippets-dir (concat pmacs-dir "snippets/"))

(defconst pmacs-user-dir
  (expand-file-name
   (or (getenv "PMACSDIR")
       (getenv "DOOMDIR")
       (concat (or (getenv "XDG_CONFIG_HOME")
                   (concat (getenv "HOME") "/.config"))
               "/pmacs"))))

(defconst pmacs-data-dir
  (expand-file-name
   (or (getenv "PMACSDATA")
       (concat (or (getenv "XDG_DATA_HOME")
                   (concat (getenv "HOME") "/.local/share"))
               "/pmacs"))))

(defconst pmacs-cache-dir
  (expand-file-name
   (or (getenv "PMACSCACHE")
       (concat (or (getenv "XDG_CACHE_HOME")
                   (concat (getenv "HOME") "/.local/cache"))
               "/pmacs"))))

(defconst pmacs-state-dir
  (expand-file-name
   (or (getenv "PMACSSTATE")
       (concat (or (getenv "XDG_STATE_HOME")
                   (concat (getenv "HOME") "/.local/state"))
               "/pmacs"))))

(dolist (dir (list pmacs-user-dir pmacs-data-dir pmacs-cache-dir pmacs-state-dir))
  (unless (file-directory-p dir)
    (make-directory dir t)))

(push pmacs-core-dir load-path)
(push (concat pmacs-core-dir "lib") load-path)

(dolist (dir (directory-files pmacs-module-dir t "\\`[a-z-]+\\'" t))
  (when (file-directory-p dir)
    (add-to-list 'load-path dir)))

(setq custom-theme-load-path
      (append (list pmacs-theme-dir (expand-file-name "themes" pmacs-data-dir))
              custom-theme-load-path))

(setq undo-tree-history-directory-alist
      `(("." . ,(expand-file-name "undo" pmacs-state-dir)))
      recentf-save-file (expand-file-name "recentf" pmacs-cache-dir)
      save-place-file (expand-file-name "saveplace" pmacs-cache-dir)
      eshell-history-file (expand-file-name "history"
                                            (expand-file-name "eshell" pmacs-state-dir))
      eshell-last-dir-ring-file (expand-file-name "lastd"
                                                  (expand-file-name "eshell" pmacs-state-dir))
      nsm-settings-file (expand-file-name "network-security.data" pmacs-state-dir))

(provide 'pmacs)
;;; pmacs.el ends here
