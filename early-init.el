;;; early-init.el --- pmacs early initialization -*- lexical-binding: t; -*-

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(defvar pmacs--file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message t)

(prefer-coding-system 'utf-8)

;;; early-init.el ends here
