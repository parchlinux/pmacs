;;; config.el --- editor module configuration -*- lexical-binding: t; -*-

(require 'pmacs-lib)

(when (fboundp 'yas-global-mode)
  (setq yas-snippet-dirs (list (pmacs-dir "snippets")
                                (pmacs-data-dir "snippets"))
        yas-wrap-around-region t
        yas-verbosity 0)
  (add-hook 'after-init-hook #'yas-global-mode))

(when (fboundp 'ws-butler-mode)
  (setq ws-butler-global-mode t)
  (add-hook 'after-init-hook #'ws-butler-mode))

(when (fboundp 'global-undo-tree-mode)
  (setq undo-tree-auto-save-history t
        undo-tree-history-directory-alist
        `(("." . ,(pmacs-state-dir "undo")))
        undo-tree-visualizer-diff t
        undo-tree-visualizer-timestamps t)
  (add-hook 'after-init-hook #'global-undo-tree-mode))

(when (fboundp 'hungry-delete-mode)
  (setq global-hungry-delete-mode t)
  (add-hook 'after-init-hook #'global-hungry-delete-mode))

(provide 'config)
;;; config.el ends here
