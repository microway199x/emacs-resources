;;* 1. common config 
;;(setq verilog-active-low-regexp t)  ;;comment for sometimes case verilog-auto-tieoff/reset fail
  (setq verilog-align-declaration-comments t)
  (setq verilog-align-ifelse t)
  (setq verilog-auto-inst-param-value t) ;;;自动例化时，参数会被例化的参数/值展开替换
  (setq verilog-auto-lineup 'all) ;;;自动对齐，表达式,定义变量
  (setq verilog-auto-read-includes t) ;;;执行auto之前，先读入define/include文件
  (setq verilog-auto-tieoff-declaration "assign")
  (setq verilog-indent-declarations-macros t) ;;macro宏正常做indent
  (setq verilog-compiler "vcs -l tmp.log ")
  (setq verilog-linter "spyglass") ;;;
  (setq verilog-tool "verilog-compiler" ) ;;;
  (setq enable-local-eval t)
  (setq verilog-auto-newline t)
  (setq verilog-auto-indent-on-newline t)
  (setq verilog-auto-inst-column 60)
;; 可以修改 verilog-mode中的函数，verilog-insert-definition中的
;;  indent-to变量最大值，设置自动定义变量的宽度,比如 input、output、wire等
;; can use load module to use new version plugin
;;(load xxx/xx/verilog-mode.el)  ;;example

;;* 2. outline mode header config

(defun v-verilog-outline-hook ()
  ; outline uses this regexp to find headers. 
  ; use indent or noindent "///{, ///{{{, always,function,module"
  ;(setq outline-regexp "///[{\f]+\\|[ \t]*\\(always\\|module\\|function\\|begin\\)") ;; use ///{ manually fold
  (setq outline-regexp "[ \t]*///[{\f]+") ;; use ///{ manually fold
  ;(setq outline-heading-end-regexp "///[}\f]+") ;; not used
  ;(setq outline-heading-alist `(("chapter". 2) ("section". 2) )) ;; not used
  ;use default fold level, default fold level is column number
  ; enable our level computation
  ;(setq outline-level 'py-outline-level)
  ; do not use their \C-c@ prefix, too hard to type. Note this overides some bindings.
  (setq outline-minor-mode-prefix "\C-t")
  ; turn on outline mode
  (outline-minor-mode 1)
  ; initially hide all but the headers
  ;(hide-body)
  ; make paren matches visible
  (show-paren-mode 1)
  (define-key evil-normal-state-map (kbd "TAB") 'outline-toggle-children)
  (define-key evil-normal-state-map (kbd "<backtab>") 'outline-show-subtree) ;;shift + tab
)
;;; only when verolog-mode buffer execute
(add-hook 'verilog-mode-hook 'v-verilog-outline-hook)

;;======= Code folding =======
;(add-hook 'python-mode-hook 'my-python-outline-hook)
;; this gets called by outline to deteremine the level. Just use the length of the whitespace
;(defun py-outline-level ()
;  (let (buffer-invisibility-spec)
;    (save-excursion
;      (skip-chars-forward "    ")
;      (current-column))))
; this get called after python mode is enabled

;(defun my-python-outline-hook ()
;  ; outline uses this regexp to find headers. I match lines with no indent and indented "class"
;  ; and "def" lines.
;  (setq outline-regexp "[^ \t]\\|[ \t]*\\(def\\|class\\) ")
;  ; enable our level computation
;  (setq outline-level 'py-outline-level)
;  ; do not use their \C-c@ prefix, too hard to type. Note this overides some bindings.
;  (setq outline-minor-mode-prefix "\C-t")
;  ; turn on outline mode
;  (outline-minor-mode t)
;  ; initially hide all but the headers
;  ;(hide-body)
;  ; make paren matches visible
;  (show-paren-mode 1)
;)

(provide 'verilog-mode-config)
