;;; pmacs-packages.el --- pmacs package management -*- lexical-binding: t; -*-
;;; Commentary:
;; Package management for pmacs using straight.el.
;;; Code:

(require 'pmacs)
(require 'pmacs-lib)

(unless (string-suffix-p "/" user-emacs-directory)
  (setq user-emacs-directory (concat user-emacs-directory "/")))

(defun pmacs--straight-p ()
  "Return non-nil if straight.el is available."
  (fboundp 'straight-use-package))

(when (not (pmacs--straight-p))
  (let ((repository-file (expand-file-name "straight/repos/straight.el" user-emacs-directory)))
    (unless (file-exists-p repository-file)
      (message "pmacs: bootstrapping straight.el...")
      (with-current-buffer
          (url-retrieve-synchronously
           (concat "https://raw.githubusercontent.com/"
                   "radian-software/straight.el/develop/install.el")
           'silent 'inhibit-cookies)
        (goto-char (point-max))
        (eval-print-last-sexp)))
    (let ((straight-file (expand-file-name "straight.el" repository-file)))
      (if (file-exists-p straight-file)
          (load straight-file nil t)
        (error "pmacs: straight.el not found at %s" straight-file)))
    (unless (pmacs--straight-p)
      (error "pmacs: failed to bootstrap straight.el"))))

(setq straight-enable-use-package-integration t
      straight-build-dir (format "build-%s" emacs-version)
      straight-clone-default-branch "main"
      straight-vc-git-default-clone-depth '(1 single-branch)
      straight-check-for-modifications nil
      straight-enable-package-integration nil)

;; Register recipe repositories so straight.el can look up packages
(when (bound-and-true-p straight-initial-recipe-repositories)
  (dolist (recipe straight-initial-recipe-repositories)
    (when (fboundp 'straight-use-recipes)
      (condition-case nil
          (straight-use-recipes recipe "pmacs initialization")
        (error nil)))))

(defvar pmacs--package-recipes nil
  "Alist of (PACKAGE . RECIPE) for declared packages.")

(defvar pmacs--syncing-p nil
  "Non-nil during `pmacs-sync' to collect package recipes.")

(defmacro package! (name &rest props)
  "Declare a package for pmacs.
NAME is the package symbol. PROPS is a plist of:
  :recipe  - straight.el plist recipe, or t to look up in recipe repos
  :pin     - pin to a specific commit
  :disable - if non-nil, skip this package
  :ignore  - if non-nil, do not install but allow loading
  :built-in - mark as a built-in package"
  (declare (indent 1))
  (let ((recipe (plist-get props :recipe))
        (pin (plist-get props :pin))
        (disable (plist-get props :disable))
        (ignore (plist-get props :ignore))
        (built-in (plist-get props :built-in)))
    `(cond
      ((bound-and-true-p pmacs--syncing-p)
       ,(unless (or disable ignore built-in)
          (let ((recipe-form
                 (cond
                  ((not recipe) `(,name))
                  ((eq recipe t) `(,name))
                  (t recipe))))
            `(let ((recipe ',(if pin
                                 (append recipe-form `(:pin ,pin))
                               recipe-form)))
               (push (cons ',name recipe) pmacs--package-recipes)))))
      (,(not (or disable ignore))
       (condition-case nil
           (straight-use-package ',name)
         (error (require ',name nil t)))))))

(defmacro disable-packages! (&rest names)
  "Mark multiple packages as disabled."
  (declare (indent 0))
  `(progn
     ,@(cl-loop for name in names
                collect `(package! ,name :disable t))))

(defun pmacs-packages-install (recipes)
  "Install all packages in RECIPES via straight.el."
  (let ((installed 0)
        (skipped 0))
    (dolist (entry recipes)
      (let* ((name (car entry))
             (recipe (cdr entry))
             (spec (cond
                    ((not recipe) name)
                    ((cdr recipe)
                     (if (eq (car recipe) name)
                         recipe
                       (cons name recipe)))
                    (t name))))
        (condition-case err
            (progn
              (straight-use-package spec)
              (cl-incf installed))
          (error
           (message "pmacs: failed to install %s: %s" name (error-message-string err))
           (cl-incf skipped)))))
    (message "pmacs: installed %d packages, skipped %d" installed skipped)))

(defun pmacs-sync ()
  "Synchronize pmacs packages."
  (interactive)
  (let ((pmacs--syncing-p t)
        (pmacs--package-recipes nil))
    ;; Collect recipes from all modules
    (dolist (dir (directory-files pmacs-module-dir t "\\`[a-z-]+\\'" t))
      (when (file-directory-p dir)
        (let ((pkg-file (expand-file-name "packages.el" dir)))
          (when (file-exists-p pkg-file)
            (load pkg-file nil t)))))
    ;; Also load user's packages
    (let ((user-pkg (expand-file-name "packages.el" pmacs-user-dir)))
      (when (file-exists-p user-pkg)
        (load user-pkg nil t)))
    (message "pmacs: %d packages to install" (length pmacs--package-recipes))
    ;; Ensure recipe repos are registered if bootstrap didn't do it
    (unless straight-recipe-repositories
      (message "pmacs: registering recipe repositories...")
      (dolist (recipe straight-initial-recipe-repositories)
        (when (fboundp 'straight-use-recipes)
          (ignore-errors
            (straight-use-recipes recipe "pmacs sync")))))
    (when (and straight-recipe-repositories
               (fboundp 'straight-pull-recipe-repositories))
      (ignore-errors (straight-pull-recipe-repositories)))
    ;; Install all collected packages
    (pmacs-packages-install pmacs--package-recipes)
    (message "pmacs: sync complete.")))

(provide 'pmacs-packages)
;;; pmacs-packages.el ends here
