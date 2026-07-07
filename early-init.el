;;; early-init.el --- pmacs early initialization -*- lexical-binding: t; -*-
;;; Commentary:
;; Runs before package system and init.el. Optimizes startup performance.
;;; Code:

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(defvar pmacs--file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(internal-border-width . 0) default-frame-alist)
(add-to-list 'default-frame-alist '(background-color . "#1e1e2e"))
(add-to-list 'default-frame-alist '(foreground-color . "#cdd6f4"))

(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message t
      inhibit-startup-message t
      inhibit-startup-buffer-menu t)
(setq initial-buffer-choice nil
      initial-major-mode 'fundamental-mode
      custom-file (expand-file-name "custom.el" user-emacs-directory))

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(setq minibuffer-prompt-properties
      '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

(setq frame-inhibit-implied-resize t)

(setq evil-want-keybinding nil)

;;; early-init.el ends here
