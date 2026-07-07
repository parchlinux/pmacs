;;; pmacs-dashboard.el --- startup welcome screen -*- lexical-binding: t; -*-

(defvar pmacs-dashboard-buffer-name "*pmacs*")

(defun pmacs-dashboard--time-greeting ()
  (let ((hour (string-to-number (format-time-string "%H"))))
    (cond ((< hour 12) "Good morning")
          ((< hour 17) "Good afternoon")
          (t "Good evening"))))

(defun pmacs-dashboard--os-name ()
  (with-temp-buffer
    (insert-file-contents "/etc/os-release" nil nil 4096 t)
    (if (re-search-forward "^PRETTY_NAME=\"\\([^\"]+\\)\"" nil t)
        (match-string 1)
      (if (re-search-forward "^PRETTY_NAME=\\([^\n]+\\)" nil t)
          (match-string 1)
        (capitalize (symbol-name system-type))))))

(defun pmacs-dashboard--kernel-version ()
  (with-temp-buffer
    (call-process "uname" nil t nil "-r")
    (string-trim (buffer-string))))

(defun pmacs-dashboard--uptime ()
  (with-temp-buffer
    (insert-file-contents "/proc/uptime" nil nil 256 t)
    (let ((seconds (floor (string-to-number (buffer-string)))))
      (format "%dd %dh %dm" (/ seconds 86400) (% (/ seconds 3600) 24) (% (/ seconds 60) 60)))))

(defun pmacs-dashboard--load-average ()
  (with-temp-buffer
    (insert-file-contents "/proc/loadavg" nil nil 256 t)
    (let ((parts (split-string (buffer-string))))
      (car parts))))

(defun pmacs-dashboard--insert-recent-files ()
  (when (and (boundp 'recentf-list) recentf-list)
    (insert "\n")
    (let ((files (cl-subseq recentf-list 0 (min 10 (length recentf-list)))))
      (dolist (f files)
        (insert (propertize (abbreviate-file-name f)
                            'face 'font-lock-keyword-face
                            'help-echo "Mouse-1: open this file"
                            'mouse-face 'highlight
                            'keymap (let ((map (make-sparse-keymap)))
                                      (define-key map [mouse-1]
                                        (lambda ()
                                          (interactive)
                                          (find-file f)))
                                      map))
                "\n")))))

(defun pmacs-dashboard--show ()
  (interactive)
  (let ((buf (get-buffer-create pmacs-dashboard-buffer-name)))
    (with-current-buffer buf
      (erase-buffer)
      (read-only-mode -1)
      (insert (pmacs-dashboard--time-greeting)
              ", and welcome to pmacs.\n\n")
      (insert (pmacs-dashboard--os-name) "\n"
              "Kernel " (pmacs-dashboard--kernel-version) "\n"
              "Uptime " (pmacs-dashboard--uptime) "\n"
              "Load   " (pmacs-dashboard--load-average) "\n\n")
      (when (and (boundp 'recentf-list) recentf-list)
        (insert "Recent files:\n")
        (pmacs-dashboard--insert-recent-files)
        (insert "\n"))
      (insert (format "Emacs %s  —  pmacs %s" emacs-version pmacs-version))
      (goto-char (point-min))
      (read-only-mode 1))
    (switch-to-buffer buf)))

(defun pmacs-dashboard--schedule ()
  (run-with-idle-timer 0.3 nil
    (lambda ()
      (unless (buffer-file-name)
        (pmacs-dashboard--show)))))

(provide 'pmacs-dashboard)
;;; pmacs-dashboard.el ends here
