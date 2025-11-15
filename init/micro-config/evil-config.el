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


(use-package evil
  ;;:ensure t
  :after ef-themes
  :init
  :bind
  :config
    (evil-mode t)
    ;;所有mode中都生效,所有prog-mode中建议使用，不建议使用<backtab>
    (define-key evil-normal-state-map (kbd "z f") 'outline-hide-subtree)
    (define-key evil-normal-state-map (kbd "z o") 'outline-show-subtree)

    (define-key evil-insert-state-map [escape] 'evil-normal-state)
    ;;; Use j/k to move one visual line insted of gj/gk
    (define-key evil-normal-state-map (kbd "<remap> <evil-next-line>")     'evil-next-visual-line)
    (define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
    (define-key evil-motion-state-map (kbd "<remap> <evil-next-line>")     'evil-next-visual-line)
    (define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)

    (evil-set-undo-system 'undo-redo)    ;;perfer use undo-redo

    ;;evil state modeline setting ;;;;;;;;;;;;;;;;;;;;;;
    ;;TODO, not work,after use ef-themes
    (defun v--evil-mode-line-setup ()
        (setq original-background (face-attribute 'mode-line :background))
        (setq normal-state-background "pale green")
        (add-hook 'evil-normal-state-entry-hook
             (lambda () (set-face-attribute 'mode-line nil :background normal-state-background)))
        (add-hook 'evil-normal-state-exit-hook
             (lambda () (set-face-attribute 'mode-line nil :background original-background))))
    (v--evil-mode-line-setup)

    ;;{{ Emacs 设置evil-normal-state map for modes 
    ;;;{{{ Hook Setting 
    (add-hook 'org-mode-hook (lambda() 
                                 (global-unset-key (kbd "TAB"))
                                 (setq org-adapt-indentation t)
                                 (define-key evil-normal-state-map (kbd "TAB") 'org-cycle)))

    ;;outline-mode在evil配置后加载，所以用verilog-mode hook重新绑定
    ;;原按键“TAB"给org-mode使用，防止冲突
    (add-hook 'verilog-mode-hook (lambda () 
                                     (global-unset-key (kbd "<backtab>")) ;;unset掉，防止冲突
                                     (define-key evil-normal-state-map (kbd "<backtab>") 'outline-toggle-children))) 

    (add-hook 'bsv-mode-hook (lambda () 
                                 (global-unset-key (kbd "<backtab>")) ;;unset掉，防止冲突
                                 (define-key evil-normal-state-map (kbd "<backtab>") 'outline-toggle-children))) 
    ;;;}}} Hook Setting 
) ;;;end use-packages 

(provide 'evil-config)
