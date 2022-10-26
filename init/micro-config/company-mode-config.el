;;;; auto complete configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun micro-company-mode-dir-set()
  (if (eq system-type `windows-nt)
      (add-to-list 'load-path 
         (concat micro-plugin-path "company-mode\\"))
      (add-to-list 'load-path 
         (concat micro-plugin-path "company-mode/"))))
(micro-company-mode-dir-set)

;company,ctrl+tab启动
(require 'company)
;;(add-hook 'after-init-hook 'global-company-mode)
(global-company-mode)
(autoload 'company-mode "company" nil t)
(setq company-idle-delay nil)
;;(add-hook 'c-mode-hook '(lambda () (company-mode)))
;;(add-hook 'c++-mode-hook '(lambda () (company-mode)))
;;(global-set-key [(tab)] 'company-complete-common) conflict with org-mode, change to C-tab
(global-set-key [(control tab)] 'company-complete-common)

(provide 'company-mode-config)
