;;; init.el --- pmacs auto-loader -*- lexical-binding: t; -*-

(let* ((pmacs-root (or (getenv "PMACSDIR")
                       (expand-file-name "~/.config/pmacs")))
       (early-init (expand-file-name "early-init.el" pmacs-root))
       (user-init  (expand-file-name "init.el" pmacs-root))
       (lisp-dir   (expand-file-name "lisp" pmacs-root)))
  (if (and (file-directory-p lisp-dir)
           (file-exists-p user-init))
      (progn
        (setq user-emacs-directory pmacs-root)
        (add-to-list 'load-path lisp-dir)
        (load early-init nil t)
        (load user-init nil t))
    (message "pmacs loader: not found at %s" pmacs-root)))

;;; init.el ends here
