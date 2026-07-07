;;; init.el --- pmacs auto-loader -*- lexical-binding: t; -*-
;;; Commentary:
;; Installed in ~/.emacs.d/ by `pmacs --sync`. Loads pmacs from its
;; install location so that plain `emacs` launches pmacs too.
;;; Code:

(defconst pmacs--loader-version "0.1.0")

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
        (condition-case err
            (load early-init nil t)
          (error (message "pmacs loader: early-init error: %s" err)))
        (condition-case err
            (load user-init nil t)
          (error (message "pmacs loader: init error: %s" err))))
    (message "pmacs loader: not found at %s" pmacs-root)))

;;; init.el ends here
