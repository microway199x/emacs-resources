;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;install general plugin config 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;install emacs-async
;;(add-to-list 'load-path 
;;	     "C:\\emacs\\init\\plugin\\helm\\")
;;(require 'helm-config)
;;;;(helm-mode t)
;;(global-set-key (kbd "M-x") 'helm-M-x)
;;(global-set-key (kbd "C-x C-f") 'helm-find-files)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;install general
(defun micro-general-dir-set()
  (if (eq system-type `windows-nt)
      (add-to-list 'load-path 
              (concat micro-plugin-path "general\\"))
      (add-to-list 'load-path 
              (concat micro-plugin-path "general"))))
(micro-general-dir-set)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'general)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Evil related config
(general-evil-setup)
(general-evil-setup t)

(general-nmap
  :prefix "SPC"
  "ft" 'v-find-tags)

;; bind in motion state (inherited by the normal, visual, and operator states)
(general-mmap
  ";" 'evil-ex
  ":" 'evil-repeat-find-char)

;; alternatively, for shorter names
(general-evil-setup t)
(mmap
  ";" 'evil-ex
  ":" 'evil-repeat-find-char)

;; * Mode Keybindings
(general-nmap
  :keymaps 'emacs-lisp-mode-map
  "K" 'elisp-slime-nav-describe-elisp-thing-at-point)
;; same as
(general-nmap emacs-lisp-mode-map
  "K" 'elisp-slime-nav-describe-elisp-thing-at-point)


(provide 'general-config)

