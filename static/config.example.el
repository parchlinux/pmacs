;;; config.example.el --- pmacs user configuration example -*- lexical-binding: t; -*-

;;; Commentary:

;; This is an example user configuration for pmacs. Copy this file to
;; your PMACSDIR (default ~/.config/pmacs/) as config.el to customize
;; your pmacs experience.

;;; Code:

;; ---------------------------------------------------------------------------
;; Theme
;; ---------------------------------------------------------------------------

;; Set the theme. Available themes:
;;   parch, doom-one, doom-nord-light, doom-gruvbox,
;;   doom-tokyo-night, modus-vivendi, etc.

(setq pmacs-theme 'parch)

;; ---------------------------------------------------------------------------
;; Fonts
;; ---------------------------------------------------------------------------

;; Monospace font for code (requires font to be installed)
(setq pmacs-font "JetBrains Mono-14")

;; Variable-pitch font for prose
(setq pmacs-variable-pitch-font "Inter-12")

;; Serif font for specific contexts
(setq pmacs-serif-font "Noto Serif-12")

;; ---------------------------------------------------------------------------
;; Evil mode
;; ---------------------------------------------------------------------------

;; Initial Evil state: 'normal, 'insert, 'emacs
(setq pmacs-evil-state 'normal)

;; ---------------------------------------------------------------------------
;; Editor settings
;; ---------------------------------------------------------------------------

;; Tab width
(setq-default tab-width 4)

;; Fill column
(setq-default fill-column 80)

;; Indent with spaces
(setq-default indent-tabs-mode nil)

;; ---------------------------------------------------------------------------
;; Package declarations
;;
;; Declare additional packages here. Run `pmacs --sync` after changes.
;; ---------------------------------------------------------------------------

;; Example: Add a package from GitHub
;; (package! treesit-auto
;;   :recipe (:host github :repo "renzmann/treesit-auto"))

;; Example: Add a package from MELPA
;; (package! yaml-mode)

;; ---------------------------------------------------------------------------
;; Custom keybindings
;; ---------------------------------------------------------------------------

;; Global keybindings
(global-set-key (kbd "C-c h") #'helpful-at-key)

;; Example: Custom evil keybindings
;; (evil-define-key 'normal prog-mode-map
;;   (kbd "K") #'helpful-function
;;   (kbd "J") #'evil-scroll-down)

;; ---------------------------------------------------------------------------
;; Custom hooks
;; ---------------------------------------------------------------------------

;; Example: Custom settings for specific modes
(add-hook 'prog-mode-hook
          (lambda ()
            (setq-local show-trailing-whitespace t)))

(add-hook 'text-mode-hook
          (lambda ()
            (visual-line-mode 1)
            (flyspell-mode 1)))

;; ---------------------------------------------------------------------------
;; Window management
;; ---------------------------------------------------------------------------

;; Example: Custom display buffer rules
;; (add-to-list 'display-buffer-alist
;;              '("\\*Help\\*"
;;                (display-buffer-reuse-mode-window display-buffer-pop-up-window)
;;                (side . right)
;;                (window-width . 0.4)))

;; ---------------------------------------------------------------------------
;; File associations
;; ---------------------------------------------------------------------------

;; Example: Associate file extensions with modes
;; (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
;; (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

;; ---------------------------------------------------------------------------
;; Custom functions
;; ---------------------------------------------------------------------------

;; Example: Custom utility function
;; (defun my/some-command ()
;;   "Do something useful."
;;   (interactive)
;;   (message "Hello from pmacs!"))

;;; config.example.el ends here
