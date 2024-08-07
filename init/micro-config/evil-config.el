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
;;; (define-key evil-normal-state-map (kbd "TAB") 'indent-for-tab-command)
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

;;{{ Emacs 设置evil-normal-state map for modes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;{{{ org-mode
(setq evil-want-C-i-jump nil)
(defun v-org-specify-config()
    (global-unset-key (kbd "TAB"))
    (setq org-adapt-indentation t)
    (define-key evil-normal-state-map (kbd "TAB") 'org-cycle))

(add-hook 'org-mode-hook 'v-org-specify-config)
;;;}}} org-mode

;;;{{{ outline-mode for other-mode, eg:verilog-mode,c-mode,...
;;; not used "TAB", 因为evil-normal-state-map只能将tab绑定到一个函数上，
;;;当打开多个文件时，即使使用xxx-mode-hook,切换major-mode时，无法切换按键
;;; xxx-mode-hook只在第一次打开对应文件时生效，所以按键按照最后一个xxx-mode-hook绑定，容易混淆
;;; 所以，尽量不要在同一个emacs中打开多个major-mode的文件，防止冲突
(add-hook 'verilog-mode-hook 
    (lambda () 
          (global-unset-key (kbd "<backtab>")) ;;unset掉，防止冲突
          ;;outline-mode在evil配置后加载，所以用verilog-mode hook重新绑定
          ;;原按键“TAB"给org-mode使用，防止冲突
          (define-key evil-normal-state-map (kbd "<backtab>") 'outline-toggle-children)
          )) 

(add-hook 'bsv-mode-hook 
    (lambda () 
          (global-unset-key (kbd "<backtab>")) ;;unset掉，防止冲突
          ;;outline-mode在evil配置后加载，所以用verilog-mode hook重新绑定
          ;;原按键“TAB"给org-mode使用，防止冲突
          (define-key evil-normal-state-map (kbd "<backtab>") 'outline-toggle-children)
          )) 


;;所有mode中都生效,所有prog-mode中建议使用，不建议使用<backtab>
(define-key evil-normal-state-map (kbd "z f") 'outline-hide-subtree)
(define-key evil-normal-state-map (kbd "z o") 'outline-show-subtree)
;;}}}


;;}}

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
