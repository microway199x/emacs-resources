
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(display-time-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(warning-suppress-log-types '((comp) (comp) (comp) (comp) (comp)))
 '(warning-suppress-types '((comp) (comp) (comp) (comp) (comp) (comp))))

(if (eq system-type `windows-nt)
    (add-hook 'after-init-hook 
          (lambda ()
            (defvar micro-config-root-path "C:\\tools\\emacs\\init\\")
             (add-to-list 'load-path "C:\\tools\\emacs\\init\\")
             (require 'micro-init)))
    (add-hook 'after-init-hook 
          (lambda ()
             (defvar micro-config-root-path  "~/git/emacs-resources/init/")
             (add-to-list 'load-path "~/git/emacs-resources/init/")
             (require 'micro-init))))

