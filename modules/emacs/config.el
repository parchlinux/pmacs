;;; config.el --- emacs built-in enhancement configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Configuration for Emacs built-in enhancement modules.
;;; Code:

(require 'pmacs-lib)

(setq dired-kill-when-opening-new-dired-buffer t
      dired-listing-switches "-la --group-directories-first"
      dired-auto-revert-buffer t
      dired-recursive-copies 'always
      dired-recursive-deletes 'top)

(when (fboundp 'dired-find-alternate-file)
  (setq dired-kill-when-opening-new-dired-buffer t))

(setq electric-layout-rules
      '((?\; . after)
        (?{  . after)
        (?}  . before)))

(setq undo-limit 80000000
      undo-strong-limit 120000000
      undo-outer-limit 480000000)

(setq vc-follow-symlinks t
      vc-make-backup-files nil
      vc-command-messages nil)

(setq tramp-default-method "ssh"
      tramp-auto-save-directory (expand-file-name "auto-save" (expand-file-name "tramp" pmacs-state-dir))
      tramp-ssh-controlmaster-options
      "-o ControlMaster=auto -o ControlPath='tramp%%h' -o ControlPersist=no")

(when (fboundp 'better-jumper-mode)
  (add-hook 'after-init-hook #'better-jumper-mode)
  (add-hook 'evil-local-mode-hook #'better-jumper-mode))

(when (fboundp 'goto-last-change)
  (global-set-key (kbd "C-.") #'goto-last-change)
  (global-set-key (kbd "C-,") #'goto-last-change-reverse))

;;; config.el ends here
