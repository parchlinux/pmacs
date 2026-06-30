;;; config.el --- terminal configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Configuration for terminal emulation modules.
;;; Code:

(require 'pmacs-lib)

(when (fboundp 'vterm)
  (setq vterm-max-scrollback 10000
        vterm-buffer-name-string "*vterm %s*"
        vterm-kill-buffer-on-exit t
        vterm-always-compile-module t))

(defun pmacs/vterm ()
  "Open a new vterm buffer."
  (interactive)
  (if (fboundp 'vterm)
      (vterm)
    (message "pmacs: vterm not available. Run `pmacs-sync' to install it.")))

(setq eshell-history-file (pmacs-state-dir "eshell" "history")
      eshell-last-dir-ring-file (pmacs-state-dir "eshell" "lastd")
      eshell-prompt-function 'pmacs-eshell-prompt
      eshell-prompt-regexp "^[^#$]*[#$] ")

(defun pmacs-eshell-prompt ()
  "Custom EShell prompt showing user@host:dir."
  (concat (if (string= (user-login-name) "root") "#" "$")
          " "))

(add-hook 'shell-mode-hook
          (lambda ()
            (setq-local shell-pushd-regexp
                        "\\(?:^\\|[ \t]\\)cd\\(?:[ \t]+\\|$\\)")
            (setq-local shell-popd-regexp
                        "\\(?:^\\|[ \t]\\)[Pp]opd\\(?:[ \t]+\\|$\\)")))

;;; config.el ends here
