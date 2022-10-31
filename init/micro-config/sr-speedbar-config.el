;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;配置 speedbar，使用sr-speedbar插件配置speedbar 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path micro-plugin-path)
(require 'sr-speedbar)  
(setq speedbar-show-unknown-files t)  
(setq speedbar-use-images nil)  
(setq sr-speedbar-width 39)  
;;右边绑定调用键为f5
(global-set-key (kbd "<f5>") (lambda()  
                              (interactive)  
                              (setq sr-speedbar-right-side t)  
                              (sr-speedbar-toggle)))  
;;左边绑定调用键为ctrl-f5
(global-set-key (kbd "<C-f5>") (lambda()  
                              (interactive)  
                              (setq sr-speedbar-right-side nil)  
                              (sr-speedbar-toggle)))  
(provide 'sr-speedbar-config)

