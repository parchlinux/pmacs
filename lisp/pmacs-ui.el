;;; pmacs-ui.el --- pmacs UI configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Theme, fonts, modeline, line numbers, and visual defaults.
;;; Code:

(require 'pmacs)
(require 'pmacs-lib)

(defvar pmacs-font nil
  "Default monospace font. Set to a string like \"JetBrains Mono-14\".")

(defvar pmacs-variable-pitch-font nil
  "Variable-pitch font for prose.")

(defvar pmacs-serif-font nil
  "Serif font for specific contexts.")

(defun pmacs-init-fonts ()
  "Initialize pmacs font configuration."
  (when pmacs-font
    (set-face-attribute 'default nil :font pmacs-font)
    (set-face-attribute 'fixed-pitch nil :font pmacs-font)
    (set-frame-parameter nil 'font pmacs-font))
  (when pmacs-variable-pitch-font
    (set-face-attribute 'variable-pitch nil :font pmacs-variable-pitch-font))
  (when pmacs-serif-font
    (set-face-attribute 'serif nil :font pmacs-serif-font)))

(defvar pmacs-theme 'parch
  "Default theme for pmacs.")

(defvar pmacs-load-theme-hook nil
  "Hook run after a theme is loaded.")

(defun pmacs-load-theme (&optional theme)
  "Load THEME and run `pmacs-load-theme-hook'."
  (interactive)
  (let ((theme (or theme pmacs-theme)))
    (condition-case err
        (progn
          (mapc #'disable-theme custom-enabled-themes)
          (load-theme theme t)
          (run-hook-with-args 'pmacs-load-theme-hook theme))
      (error
       (message "pmacs: failed to load theme `%s': %s" theme
                (error-message-string err))
       (load-theme 'modus-vivendi t)))))

(defvar pmacs-nerd-icons-font-checked nil)

(defun pmacs--nerd-icons-font-available-p ()
  "Return t if nerd-icons fonts are installed."
  (when (fboundp 'nerd-icons--find-all-fonts)
    (nerd-icons--find-all-fonts)))

(defun pmacs--check-nerd-icons-fonts ()
  "Warn if nerd-icons fonts are not installed."
  (when (and (fboundp 'nerd-icons-install-fonts)
             (not pmacs-nerd-icons-font-checked))
    (setq pmacs-nerd-icons-font-checked t)
    (unless (pmacs--nerd-icons-font-available-p)
      (message (concat "pmacs: nerd-icons fonts not found. "
                       "Run `nerd-icons-install-fonts' to install.")))))

(defun pmacs-install-nerd-icons-fonts ()
  "Install nerd-icons fonts for UI icons."
  (interactive)
  (when (fboundp 'nerd-icons-install-fonts)
    (nerd-icons-install-fonts)
    (message "pmacs: nerd-icons fonts installed. Restart to use.")))

(setq menu-bar-mode nil
      tool-bar-mode nil
      scroll-bar-mode nil)

(setq-default display-line-numbers-type 'relative
              display-line-numbers-width 3
              display-line-numbers-grow-only t)

(dolist (hook '(prog-mode-hook text-mode-hook conf-mode-hook))
  (add-hook hook #'display-line-numbers-mode))

(setq-default left-fringe-width 6
              right-fringe-width 6)

(setq indicate-buffer-boundaries 'left
      indicate-empty-lines t)

(setq scroll-margin 0
      scroll-conservatively 101
      scroll-preserve-screen-position t
      auto-window-vscroll nil)

(setq cursor-type 'bar
      blink-cursor-mode nil
      frame-resize-pixelwise t)

(show-paren-mode 1)
(setq show-paren-delay 0.05
      show-paren-highlight-entire t)

(global-hl-line-mode 1)

(column-number-mode 1)
(size-indication-mode 1)

(setq display-time-24hr-format t
      display-time-default-load-average nil)

(delete-selection-mode 1)
(winner-mode 1)

(when (fboundp 'pixel-scroll-precision-mode)
  (pixel-scroll-precision-mode 1))

(when (fboundp 'window-divider-mode)
  (window-divider-mode 1))

(when (fboundp 'which-key-mode)
  (setq which-key-idle-delay 0.5
        which-key-sort-order 'which-key-key-order-alpha)
  (which-key-mode 1))

(when (fboundp 'doom-modeline-mode)
  (setq doom-modeline-height 28
        doom-modeline-bar-width 4
        doom-modeline-buffer-file-name-style 'truncate-upto-project)
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
  (add-hook 'after-init-hook #'global-diff-hl-mode)
  (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh))

(setq frame-title-format
      '(:eval
        (let ((buf (buffer-file-name))
              (project (when (fboundp 'projectile-project-p)
                         (projectile-project-p))))
          (cond
           ((and buf project)
            (format "%s - %s" (file-name-nondirectory buf) project))
           (buf
            (abbreviate-file-name buf))
           (t "%b"))))
      icon-title-format frame-title-format)

(setq-default mode-line-format
              '("%e"
                mode-line-front-space
                mode-line-mule-info
                mode-line-client
                mode-line-modified
                mode-line-remote
                mode-line-frame-identification
                mode-line-buffer-identification
                "  "
                mode-line-position
                "  "
                mode-line-misc-info
                mode-line-end-spaces))

(provide 'pmacs-ui)
;;; pmacs-ui.el ends here
