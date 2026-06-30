;;; config.el --- UI configuration -*- lexical-binding: t; -*-

(require 'pmacs-lib)

(when (fboundp 'doom-themes-org-config)
  (add-hook 'after-init-hook #'doom-themes-org-config))

(when (fboundp 'doom-modeline-mode)
  (setq doom-modeline-height 28
        doom-modeline-bar-width 4
        doom-modeline-buffer-file-name-style 'truncate-upto-project
        doom-modeline-major-mode-icon t
        doom-modeline-modal-icon t
        doom-modeline-env-version t)
  (doom-modeline-mode 1))

(when (fboundp 'global-hl-todo-mode)
  (setq hl-todo-keyword-faces
        '(("TODO"   . "#ff9e64")
          ("FIXME"  . "#ff757f")
          ("NOTE"   . "#7aa2f7")
          ("DEPRECATED" . "#bb9af7")
          ("HACK"   . "#7dcfff")
          ("REVIEW" . "#73daca")))
  (add-hook 'prog-mode-hook #'hl-todo-mode))

(when (fboundp 'global-diff-hl-mode)
  (setq diff-hl-side 'left)
  (add-hook 'after-init-hook #'global-diff-hl-mode)
  (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh))

(provide 'config)
;;; config.el ends here
