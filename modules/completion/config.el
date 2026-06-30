;;; config.el --- completion configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Vertico, orderless, marginalia, consult, embark setup.
;;; Code:

(require 'pmacs-lib)

(when (fboundp 'vertico-mode)
  (setq vertico-count 15
        vertico-cycle t
        vertico-scroll-margin 0
        vertico-resize t)
  (vertico-mode 1))

(when (fboundp 'orderless-define-completion-style)
  (setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles basic partial-completion)))
        orderless-component-separator 'orderless-escapable-split-on-space))

(when (fboundp 'marginalia-mode)
  (marginalia-mode 1))

(when (fboundp 'consult-customize)
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-line :preview-key '(:debounce 0.3 any)))

(when (fboundp 'embark-define-keymap)
  (setq prefix-help-command #'embark-prefix-help-command))

(with-eval-after-load 'embark
  (require 'embark-consult))

;;; config.el ends here
