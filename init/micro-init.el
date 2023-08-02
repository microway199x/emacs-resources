
;;* 1. common plugin path setting ;;;;;;;;;;;;;;;;;;
;; 自定义插件配置 ;;设置插件路径
(defun micro-system-chk()
  (if (eq system-type `windows-nt)
    (progn ;;; if windows 
       (setq micro-snippets-path (concat micro-config-root-path "snippets\\"))
       (setq micro-plugin-path (concat micro-config-root-path "plugin\\"))
       (setq micro-config-path (concat micro-config-root-path "micro-config\\"))
       (setq micro-run-path (concat micro-config-root-path "run-command\\"))
       (setq micro-theme-path (concat micro-config-root-path "themes\\"))
       (setq micro-prog-mode-path (concat micro-config-root-path "prog-mode\\")))
    (progn 
        (setq micro-snippets-path (concat micro-config-root-path "snippets/"))
        (setq micro-plugin-path (concat micro-config-root-path "plugin/"))
        (setq micro-config-path (concat micro-config-root-path "micro-config/"))
        (setq micro-run-path (concat micro-config-root-path "run-command/"))
        (setq micro-theme-path (concat micro-config-root-path "themes/"))
        (setq micro-prog-mode-path (concat micro-config-root-path "prog-mode/")))
    ))

(micro-system-chk)

;;* 2. common plugin setting ;;;;;;;;;;;;;;;;;;;;;;;
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

(setq byte-compile-warnings '(not nresolved
                                  free-vars
                                  callargs
                                  redefine
                                  obsolete
                                  noruntime
                                  cl-functions
                                  interactive-only
                                  ))

(add-to-list 'load-path micro-config-path)
(add-to-list 'load-path micro-plugin-path)
(add-to-list 'load-path micro-prog-mode-path)


(add-hook 'emacs-startup-hook 
          (load (concat micro-config-path "common-config")))
;;perfer use default undo-redo
;;(add-hook 'emacs-startup-hook 
;;          (load (concat micro-config-path "undo-plugin-config")))

(add-hook 'emacs-startup-hook 
          (load (concat micro-config-path "evil-config")))

(add-hook 'emacs-startup-hook 
          (load (concat micro-config-path "ivy-config")))

(add-hook 'emacs-startup-hook 
                 (load (concat micro-config-path "magit-config")))

(add-hook 'emacs-startup-hook 
          (load (concat micro-config-path "sr-speedbar-config")))

(add-hook 'emacs-startup-hook 
          (load (concat micro-config-path "which-key-config")))

(add-hook 'emacs-startup-hook 
          (load (concat micro-prog-mode-path "org-capture-config")))

(add-hook 'emacs-startup-hook 
                 (load (concat micro-config-path "company-mode-config")))

(add-hook 'emacs-startup-hook 
                 (load (concat micro-config-path "yasnippet-config")))

;;show put before bbyac-config, for bbyac.el require browse-kill-ring
(add-hook 'emacs-startup-hook 
                 (load (concat micro-config-path "browse-kill-ring-config")))
;;(add-hook 'emacs-startup-hook 
;;                 (load (concat micro-config-path "bbyac-config")))

;;* 2. program mode config   ;;;;;;;;;;;;;;;;;;;;;;;
;;(eval-after-load 'c-mode 
;;                 '(load (concat micro-config-path "auto-complete-config")))
;;(eval-after-load 'verilog-mode 
;;                 '(load (concat micro-config-path "auto-complete-config")))
;;(eval-after-load 'c-mode 
;;                 '(load (concat micro-config-path "yasnippet-config")))
(eval-after-load 'verilog-mode 
                  (load (concat micro-prog-mode-path "verilog-mode-config")))

(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))

(eval-after-load 'org-mode
           (load (concat micro-prog-mode-path "org-config")))

(eval-after-load 'org-mode
          (load (concat micro-config-path "deft-config")))

;; (add-hook 'org-mode-hook 
;;           (load (concat micro-config-path "org-config")))

;;(add-hook 'org-mode-hook 
;;          (load (concat micro-config-path "deft-config")))

(add-to-list 'auto-mode-alist '("\\.bsv\\'" . bsv-mode))

(eval-after-load 'bsv-mode 
            (load (concat micro-prog-mode-path "bsv-mode-config")))

(eval-after-load 'help-mode
          (load (concat micro-config-path "elisp-demos-config")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;auto run command ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'perl-mode (load (concat micro-run-path "run-perl")))
(add-hook 'python-mode (load (concat micro-run-path "run-python")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;my config func ends here
(provide 'micro-init)
