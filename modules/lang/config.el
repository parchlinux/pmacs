;;; config.el --- language configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Configuration for programming language modules.
;;; Code:

(require 'pmacs-lib)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq-local tab-width 4)
            (setq-local indent-tabs-mode nil)
            (setq-local lisp-indent-offset 2)))

(when (fboundp 'helpful-setup-keys)
  (setq helpful-max-buffer-size (* 1024 1024))
  (global-set-key (kbd "C-h f") #'helpful-function)
  (global-set-key (kbd "C-h v") #'helpful-variable)
  (global-set-key (kbd "C-h k") #'helpful-key)
  (global-set-key (kbd "C-h m") #'helpful-macro)
  (global-set-key (kbd "C-h s") #'helpful-symbol))

(when (fboundp 'global-easy-kill-mode)
  (global-set-key [remap kill-ring-save] #'easy-kill)
  (global-set-key [remap mark-word] #'easy-mark-word))

(when (fboundp 'lispy-mode)
  (add-hook 'emacs-lisp-mode-hook #'lispy-mode)
  (add-hook 'lisp-mode-hook #'lispy-mode)
  (add-hook 'scheme-mode-hook #'lispy-mode))

(add-to-list 'auto-mode-alist '("\\.el\\'" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("\\.elc\\'" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("\\.dir-locals\\.el\\'" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("/Cask\\'" . emacs-lisp-mode))

(when (and (fboundp 'treesit-available-p) (treesit-available-p))
  (setq treesit-language-source-alist
        '((bash . ("https://github.com/tree-sitter/tree-sitter-bash"))
          (c . ("https://github.com/tree-sitter/tree-sitter-c"))
          (cpp . ("https://github.com/tree-sitter/tree-sitter-cpp"))
          (css . ("https://github.com/tree-sitter/tree-sitter-css"))
          (go . ("https://github.com/tree-sitter/tree-sitter-go"))
          (html . ("https://github.com/tree-sitter/tree-sitter-html"))
          (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
          (json . ("https://github.com/tree-sitter/tree-sitter-json"))
          (lua . ("https://github.com/tree-sitter/tree-sitter-lua"))
          (python . ("https://github.com/tree-sitter/tree-sitter-python"))
          (rust . ("https://github.com/tree-sitter/tree-sitter-rust"))
          (toml . ("https://github.com/tree-sitter/tree-sitter-toml"))
          (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src"))
          (yaml . ("https://github.com/tree-sitter/tree-sitter-yaml")))))

(add-hook 'python-mode-hook
          (lambda ()
            (setq-local python-indent-offset 4)
            (setq-local tab-width 4)))

(add-hook 'rust-mode-hook
          (lambda ()
            (setq-local rust-format-on-save t)
            (setq-local tab-width 4)))

(add-hook 'go-mode-hook
          (lambda ()
            (setq-local tab-width 4)
            (setq-local indent-tabs-mode t)))

(add-hook 'js-mode-hook
          (lambda ()
            (setq-local js-indent-level 2)
            (setq-local tab-width 2)))

(add-hook 'sh-mode-hook
          (lambda ()
            (setq-local sh-basic-offset 4)
            (setq-local sh-indentation 4)))

(add-hook 'yaml-mode-hook
          (lambda ()
            (setq-local yaml-indent-offset 2)
            (setq-local tab-width 2)))

(add-hook 'json-mode-hook
          (lambda ()
            (setq-local js-indent-level 2)
            (setq-local tab-width 2)))

(add-hook 'markdown-mode-hook
          (lambda ()
            (setq-local fill-column 80)
            (visual-line-mode 1)))

(when (fboundp 'nix-mode)
  (add-hook 'nix-mode-hook
            (lambda ()
              (setq-local nix-indent-offset 2)
              (setq-local tab-width 2))))

;;; config.el ends here
