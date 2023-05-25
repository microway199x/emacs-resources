;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;����Evil ctrl+z ����emacs vim֮����л� 
; C-o��������vim���ܣ�������ʱ����normalģʽ��Ȼ���Զ������� 
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
;;Ĭ�ϲ�����evil���ֶ�����
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
;; ����4��������ʹ��C-d��ΪESC����������Լ�����
;; (define-key evil-insert-state-map (kbd "C-d") 'evil-change-to-previous-state)
;; (define-key evil-normal-state-map (kbd "C-d") 'evil-force-normal-state)
;; (define-key evil-replace-state-map (kbd "C-d") 'evil-normal-state)
;; (define-key evil-visual-state-map (kbd "C-d") 'evil-exit-visual-state)
;; ��������ʱʹ��t��Ϊ����������ʼ���������� tay(���� "ayŶ) tap(����"ap��)~
;; (define-key evil-normal-state-map "t" 'evil-use-register) 
;; (setq evil-toggle-key "")	; remove default evil-toggle-key C-z, manually setup later
;; (setq evil-want-C-i-jump nil)	; don't bind [tab] to evil-jump-forward
;;    
;; remove all keybindings from insert-state keymap, use emacs-state when editing
;; (setcdr evil-insert-state-map nil)

(setq original-background (face-attribute 'mode-line :background))
;;(setq normal-state-background "76eec6")
;;(setq normal-state-background "aquamarine2")
(setq normal-state-background "pale green")
(add-hook 'evil-normal-state-entry-hook
          (lambda ()
            (set-face-attribute 'mode-line nil :background normal-state-background)))

(add-hook 'evil-normal-state-exit-hook
          (lambda ()
            (set-face-attribute 'mode-line nil :background original-background)))


(provide 'evil-config)
