;;; init.example.el --- pmacs example configuration -*- lexical-binding: t; -*-

;;; Commentary:

;; Example configuration for pmacs. Copy this file to your PMACSDIR
;; (default ~/.config/pmacs/) as init.el to customize pmacs.

;;; Code:

;; ---------------------------------------------------------------------------
;; Theme
;;
;; Choose a theme from the available options:
;;   - parch (default)
;;   - doom-one
;;   - doom-nord-light
;;   - doom-gruvbox
;;   - doom-tokyo-night
;;   - modus-vivendi
;; ---------------------------------------------------------------------------

(setq pmacs-theme 'parch)

;; ---------------------------------------------------------------------------
;; Fonts
;;
;; Set your preferred fonts. Falls back to system defaults if the
;; specified font is not available.
;; ---------------------------------------------------------------------------

(setq pmacs-font "JetBrains Mono-14"
      pmacs-variable-pitch-font "Inter-12"
      pmacs-serif-font "Noto Serif-12")

;; ---------------------------------------------------------------------------
;; Evil mode
;;
;; Configure Evil mode behavior.
;; ---------------------------------------------------------------------------

;; Set initial Evil state: 'normal, 'insert, 'emacs
(setq pmacs-evil-state 'normal)

;; Change leader key (default SPC)
(setq pmacs-leader-key "SPC"
      pmacs-leader-alt-key "M-SPC")

;; ---------------------------------------------------------------------------
;; Packages
;;
;; Declare additional packages. Run pmacs --sync after changes.
;; ---------------------------------------------------------------------------

;; Example: Add a package from GitHub
;; (package! some-package
;;   :recipe (:host github :repo "user/repo"))

;; Example: Add a package from MELPA (default)
;; (package! another-package)

;; Example: Disable a core package
;; (disable-packages! some-unwanted-package)

;; ---------------------------------------------------------------------------
;; Custom keybindings
;;
;; Add your own keybindings using the map! macro.
;; ---------------------------------------------------------------------------

;; Example: Global keybinding
;; (global-set-key (kbd "C-c t") #'some-command)

;; Example: Evil normal state binding
;; (evil-define-key 'normal global-map (kbd "SPC o") #'some-command)

;; Example: Using map! macro
;; (map! :leader
;;   "o t" #'some-command
;;   "o f" #'another-command)

;; ---------------------------------------------------------------------------
;; Hooks
;;
;; Add custom hooks for specific modes.
;; ---------------------------------------------------------------------------

;; Example: Hook into prog-mode
;; (add-hook 'prog-mode-hook
;;           (lambda ()
;;             (setq-local tab-width 2)))

;; Example: Hook into org-mode
;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (org-indent-mode 1)))

;; ---------------------------------------------------------------------------
;; Custom variables
;;
;; Set Emacs custom variables.
;; ---------------------------------------------------------------------------

;; Example: Set custom variables
;; (setq inhibit-startup-message t)
;; (setq initial-major-mode 'text-mode)

;;; init.example.el ends here
