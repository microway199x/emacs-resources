;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;���� speedbar��ʹ��sr-speedbar�������speedbar 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path micro-plugin-path)
(require 'sr-speedbar)  
(setq speedbar-show-unknown-files t)  
(setq speedbar-use-images nil)  
(setq sr-speedbar-width 25)  
;;�ұ߰󶨵��ü�Ϊf5
(global-set-key (kbd "<f5>") (lambda()  
                              (interactive)  
                              (setq sr-speedbar-right-side t)  
                              (sr-speedbar-toggle)))  
;;��߰󶨵��ü�Ϊctrl-f5
(global-set-key (kbd "<C-f5>") (lambda()  
                              (interactive)  
                              (setq sr-speedbar-right-side nil)  
                              (sr-speedbar-toggle)))  
(provide 'sr-speedbar-config)

