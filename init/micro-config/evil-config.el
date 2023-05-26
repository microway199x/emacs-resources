;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;设置Evil ctrl+z 进行emacs vim之间的切换 
; C-o按键调用vim功能（就是临时进入normal模式，然后自动回来） 
; C-o 3dd C-o dib C-o yy C-o p C-o f 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun micro-evil-dir-set()
  (if (eq system-type `windows-nt)
      (add-to-list 'load-path 
              (concat micro-plugin-path "Evil\\"))
      (add-to-list 'load-path 
              (concat micro-plugin-path "Evil/"))))
(micro-evil-dir-set)

(require 'evil)
;;默认不启动evil，手动启动
(evil-mode t)
(evil-set-undo-system 'undo-redo)    ;;perfer use undo-redo
;;(evil-set-undo-system 'undo-tree) ;;compat with emacs 24.3
;;; ESC to switch back normal-state
(define-key evil-insert-state-map [escape] 'evil-normal-state)
;;; TAB to indent in normal-state
(define-key evil-normal-state-map (kbd "TAB") 'indent-for-tab-command)
;    
;;; Use j/k to move one visual line insted of gj/gk
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)


;; (setq evil-default-state 'emacs)  ;;default is vim-mode ,use this set to emacs-mode default
;; (define-key evil-emacs-state-map (kbd "C-o") 'evil-execute-in-normal-state)
;; 下面4行是设置使用C-d作为ESC按键，这个自己看吧
;; (define-key evil-insert-state-map (kbd "C-d") 'evil-change-to-previous-state)
;; (define-key evil-normal-state-map (kbd "C-d") 'evil-force-normal-state)
;; (define-key evil-replace-state-map (kbd "C-d") 'evil-normal-state)
;; (define-key evil-visual-state-map (kbd "C-d") 'evil-exit-visual-state)
;; 以下设置时使用t作为多剪贴板的起始按键，比如 tay(不是 "ay哦) tap(就是"ap啦)~
;; (define-key evil-normal-state-map "t" 'evil-use-register) 
;; (setq evil-toggle-key "")	; remove default evil-toggle-key C-z, manually setup later
;; (setq evil-want-C-i-jump nil)	; don't bind [tab] to evil-jump-forward
;;    
;; remove all keybindings from insert-state keymap, use emacs-state when editing
;; (setcdr evil-insert-state-map nil)

(setq original-background (face-attribute 'mode-line :background))
;;(setq normal-state-background "#76eec6")
;;(setq normal-state-background "aquamarine2")
(setq normal-state-background "pale green")
(add-hook 'evil-normal-state-entry-hook
          (lambda ()
            (set-face-attribute 'mode-line nil :background normal-state-background)))

(add-hook 'evil-normal-state-exit-hook
          (lambda ()
            (set-face-attribute 'mode-line nil :background original-background)))


(provide 'evil-config)
