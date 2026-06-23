;;; init.el --- pmacs auto-loader -*- lexical-binding: t; -*-

(let ((pmacs-root (or (getenv "PMACSDIR")
                      (expand-file-name "~/.config/pmacs"))))
  (when (file-directory-p pmacs-root)
    (setq user-emacs-directory pmacs-root)
    (add-to-list 'load-path (expand-file-name "lisp" pmacs-root))
    (load (expand-file-name "early-init.el" pmacs-root) nil t)
    (load (expand-file-name "init.el" pmacs-root) nil t)))

;;; init.el ends here
