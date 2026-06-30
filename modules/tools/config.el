;;; config.el --- magit tools configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Configuration for the magit tools module.
;;; Code:

(require 'pmacs-lib)

(when (fboundp 'magit-status)
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1
        magit-save-repository-buffers 'dontask
        magit-revision-insert-related-refs nil
        magit-diff-refine-hunk t
        magit-repository-directories '(("~/src/" . 2)
                                       ("~/projects/" . 2)
                                       ("~/code/" . 2))))

(when (fboundp 'forge-setup-pullreq-merge)
  )

(when (fboundp 'git-timemachine-mode)
  (setq git-timemachine-show-revision-count 20))

(defun pmacs/git-root ()
  "Return the root directory of the current git repository."
  (interactive)
  (let ((root (locate-dominating-file default-directory ".git")))
    (when root
      (message "Git root: %s" root)
      root)))

(defun pmacs/git-open ()
  "Open the current file's repository on the web (GitHub/GitLab)."
  (interactive)
  (let ((remote (shell-command-to-string "git remote get-url origin")))
    (when remote
      (setq remote (string-trim remote))
      (browse-url remote))))

;;; config.el ends here
