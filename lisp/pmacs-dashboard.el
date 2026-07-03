;;; pmacs-dashboard.el --- startup welcome screen -*- lexical-binding: t; -*-

(defvar pmacs-dashboard-buffer-name "*pmacs*")

(defun pmacs-dashboard-open ()
  (interactive)
  (switch-to-buffer (get-buffer-create pmacs-dashboard-buffer-name))
  (erase-buffer)
  (insert "Welcome to pmacs\n")
  (goto-char (point-min)))

(provide 'pmacs-dashboard)
;;; pmacs-dashboard.el ends here
