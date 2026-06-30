;;; pmacs-editor.el --- pmacs editor configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Indentation, whitespace, undo, snippets, and editing defaults.
;;; Code:

(require 'pmacs)
(require 'pmacs-lib)

(setq-default indent-tabs-mode nil
              tab-width 4
              indent-line-function 'indent-according-to-mode
              standard-indent 4)

(add-hook 'makefile-mode-hook
          (lambda () (setq-local indent-tabs-mode t)))

(when (fboundp 'ws-butler-mode)
  (add-hook 'after-init-hook #'ws-butler-mode))

(setq require-final-newline t)

(add-hook 'prog-mode-hook (lambda () (setq show-trailing-whitespace t)))
(add-hook 'text-mode-hook (lambda () (setq show-trailing-whitespace t)))

(when (fboundp 'global-undo-tree-mode)
  (setq undo-tree-auto-save-history t
        undo-tree-history-directory-alist
        `(("." . ,(pmacs-state-dir "undo")))
        undo-tree-visualizer-diff t
        undo-tree-visualizer-timestamps t)
  (add-hook 'after-init-hook #'global-undo-tree-mode))

(when (fboundp 'yas-global-mode)
  (setq yas-snippet-dirs (list (pmacs-dir "snippets")
                                (pmacs-data-dir "snippets"))
        yas-wrap-around-region t
        yas-verbosity 0)
  (add-hook 'after-init-hook #'yas-global-mode))

(setq auto-save-default t
      auto-save-timeout 20
      auto-save-interval 200)

(setq large-file-warning-threshold (* 20 1024 1024))
(setq vc-follow-symlinks t
      create-lockfiles nil)

(when (fboundp 'recentf-mode)
  (setq recentf-max-saved-items 200
        recentf-exclude (list "/tmp/" "/ssh:" "\\.elc$"))
  (add-hook 'after-init-hook #'recentf-mode))

(when (fboundp 'save-place-mode)
  (add-hook 'after-init-hook #'save-place-mode))

(electric-indent-mode 1)
(electric-pair-mode 1)

(setq-default fill-column 80)
(add-hook 'text-mode-hook #'auto-fill-mode)
(add-hook 'org-mode-hook #'auto-fill-mode)

(setq enable-recursive-minibuffers t
      minibuffer-depth-indicate-mode t)

(setq completion-auto-select t
      completion-cycle-threshold 3
      completion-ignore-case t)

(transient-mark-mode 1)

(setq default-frame-alist
      (append '((undecorated . nil))
              default-frame-alist))

(provide 'pmacs-editor)
;;; pmacs-editor.el ends here
