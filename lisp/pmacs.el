;;; pmacs.el --- pmacs core definitions -*- lexical-binding: t; -*-

(defconst pmacs-version "0.1.0")

(defconst IS-LINUX (eq system-type 'gnu/linux))

(defconst pmacs-dir
  (cond
   (load-in-progress
    (file-name-directory
     (directory-file-name
      (file-name-directory
       (directory-file-name load-file-name)))))
   ((boundp 'user-emacs-directory)
    (expand-file-name user-emacs-directory))
   (t (expand-file-name default-directory))))

(defconst pmacs-core-dir (concat pmacs-dir "lisp/"))
(defconst pmacs-module-dir (concat pmacs-dir "modules/"))
(defconst pmacs-theme-dir (concat pmacs-dir "themes/"))

(defconst pmacs-user-dir
  (expand-file-name
   (or (getenv "PMACSDIR")
       (concat (or (getenv "XDG_CONFIG_HOME") (concat (getenv "HOME") "/.config")) "/pmacs"))))

(defconst pmacs-data-dir
  (expand-file-name
   (or (getenv "PMACSDATA")
       (concat (or (getenv "XDG_DATA_HOME") (concat (getenv "HOME") "/.local/share")) "/pmacs"))))

(defconst pmacs-cache-dir
  (expand-file-name
   (or (getenv "PMACSCACHE")
       (concat (or (getenv "XDG_CACHE_HOME") (concat (getenv "HOME") "/.local/cache")) "/pmacs"))))

(defconst pmacs-state-dir
  (expand-file-name
   (or (getenv "PMACSSTATE")
       (concat (or (getenv "XDG_STATE_HOME") (concat (getenv "HOME") "/.local/state")) "/pmacs"))))

(dolist (dir (list pmacs-user-dir pmacs-data-dir pmacs-cache-dir pmacs-state-dir))
  (unless (file-directory-p dir)
    (make-directory dir t)))

(push pmacs-core-dir load-path)
(push pmacs-user-dir load-path)

(setq custom-theme-load-path
      (append (list pmacs-theme-dir (pmacs-data-dir "themes"))
              custom-theme-load-path))

(provide 'pmacs)
;;; pmacs.el ends here
