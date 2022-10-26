
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 自定义插件配置 ;;设置插件路径
(defun micro-system-chk()
  (if (eq system-type `windows-nt)
    (progn ;;; if windows 
       (setq micro-snippets-path (concat micro-config-root-path "snippets\\"))
       (setq micro-plugin-path (concat micro-config-root-path "plugin\\"))
       (setq micro-config-path (concat micro-config-root-path "micro-config\\"))
       (setq micro-run-path (concat micro-config-root-path "run-command\\"))
       (setq micro-theme-path (concat micro-config-root-path "themes\\")))
    (progn 
        (setq micro-snippets-path (concat micro-config-root-path "snippets/"))
        (setq micro-plugin-path (concat micro-config-root-path "plugin/"))
        (setq micro-config-path (concat micro-config-root-path "micro-config/"))
        (setq micro-run-path (concat micro-config-root-path "run-command/"))
        (setq micro-theme-path (concat micro-config-root-path "themes/")))))

(micro-system-chk)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;common settiong
;;evil 
;;helm or ivy
;;which-key config
;;sr-speedbar config
;;org-capture config
;;auto complete
;;yasnippet
;;org-mode config
;;personal config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path micro-config-path)

(add-hook 'emacs-startup-hook 
          (load (concat micro-config-path "common-config")))

(add-hook 'emacs-startup-hook 
          (load (concat micro-config-path "evil-config")))

(add-hook 'emacs-startup-hook 
          (load (concat micro-config-path "ivy-config")))

(add-hook 'emacs-startup-hook 
                 (load (concat micro-config-path "magit-config")))

(add-hook 'emacs-startup-hook 
          (load (concat micro-config-path "which-key-config")))

(add-hook 'emacs-startup-hook 
          (load (concat micro-config-path "sr-speedbar-config")))

(add-hook 'emacs-startup-hook 
          (load (concat micro-config-path "org-capture-config")))
(add-hook 'emacs-startup-hook 
                 (load (concat micro-config-path "company-mode-config")))
(add-hook 'emacs-startup-hook 
                 (load (concat micro-config-path "yasnippet-config")))

;;(eval-after-load 'c-mode 
;;                 '(load (concat micro-config-path "auto-complete-config")))
;;(eval-after-load 'verilog-mode 
;;                 '(load (concat micro-config-path "auto-complete-config")))
;;   
;;(eval-after-load 'c-mode 
;;                 '(load (concat micro-config-path "yasnippet-config")))
(eval-after-load 'verilog-mode 
                 '(load (concat micro-config-path "yasnippet-config")))
(eval-after-load 'verilog-mode 
                 '(load (concat micro-config-path "verilog-mode-config")))

(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))

(eval-after-load 'org-mode
           (load (concat micro-config-path "org-config")))

(eval-after-load 'org-mode
          (load (concat micro-config-path "deft-config")))

;; (add-hook 'org-mode-hook 
;;           (load (concat micro-config-path "org-config")))

;;(add-hook 'org-mode-hook 
;;          (load (concat micro-config-path "deft-config")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;auto run command ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'perl-mode (load (concat micro-run-path "run-perl")))
(add-hook 'python-mode (load (concat micro-run-path "run-python")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;my config func ends here
(provide 'micro-init)
