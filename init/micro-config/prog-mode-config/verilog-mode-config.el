;;* {{ 1. common config 
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
;;* }} 1. common config 

;;* {{ 2. outline mode header config

(defun v-verilog-outline-hook ()
  " outline uses this regexp to find headers.  
    use indent or noindent  ///{, ///{{{, always,function,module  "

  ;(setq outline-regexp "///[{\f]+\\|[ \t]*\\(always\\|module\\|function\\|begin\\)") ;; use ///{ manually fold
  (setq outline-regexp "[ \t]*///[{\f]+") ;; use ///{ manually fold
  ;(setq outline-heading-end-regexp "///[}\f]+") ;; not used
  ;(setq outline-heading-alist `(("chapter". 2) ("section". 2) )) ;; not used
  ;use default fold level, default fold level is column number ,enable our level computation
  ;(setq outline-level 'py-outline-level)
  ; do not use their \C-c@ prefix, too hard to type. Note this overides some bindings.
  (setq outline-minor-mode-prefix "\C-t")
  ; turn on outline mode
  (outline-minor-mode 1)
  ; initially hide all but the headers
  ;(hide-body)
  ; make paren matches visible
  (show-paren-mode 1)
)
;;; only when verolog-mode buffer execute
(add-hook 'verilog-mode-hook 'v-verilog-outline-hook)
;;* }} 2. outline mode header config

;;* {{ 3. ======= Code folding =======
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
;;* }} 3. ======= Code folding =======


;;* {{ 4. personal scripts

;;* {{{ 4.1 verilog instant align
(defun v-verilog-align-inst ()
  "verilog align instance connect wires..."
  (interactive)
  (setq region-start-p (region-beginning))
  (setq region-end-p (region-end))
  (setq region-strings (buffer-substring region-start-p region-end-p))
  (setq region-line-list (split-string region-strings "\n"))
  (setq new-region-line-list '())
  (setq max-inst-len 0)
  (setq max-con-len 0)

  ;;get instant signal width
  (dolist (line-string region-line-list)
    ;;;string match for connect wire: empty float or others
    (cond ((string-match "^[ ]*\\.[ ]*\\([^ ]*\\)[ ]+([ ]*\\([^ ].*[^ ]\\|[^ ]\\|\\)[ ]*)[ ]*,[ ]*\\(.*\\)$" line-string)
           (progn
             ( if ( < max-inst-len (length (match-string 1 line-string)))
                 (setq max-inst-len (length (match-string 1 line-string))))
             ( if ( < max-con-len (length (match-string 2 line-string)))
                 (setq max-con-len (length (match-string 2 line-string))))
             ))
          ((string-match "^[ ]*\\.[ ]*\\([^ ]*\\)[ ]+([ ]*\\([^ ].*[^ ]\\|[^ ]\\|\\)[ ]*)[ ]*)[ ]*;[ ]*\\(.*\\)$" line-string)
           (progn
             ( if ( < max-inst-len (length (match-string 1 line-string)))
                 (setq max-inst-len (length (match-string 1 line-string))))
             ( if ( < max-con-len (length (match-string 2 line-string)))
                 (setq max-con-len (length (match-string 2 line-string))))
             ))
          ((string-match "^[ ]*\\.[ ]*\\([^ ]*\\)[ ]+([ ]*\\([^ ].*[^ ]\\|[^ ]\\|\\)[ ]*)[ ]*)[ ]*\\(.*\\)$" line-string)
           (progn
             ( if ( < max-inst-len (length (match-string 1 line-string)))
                 (setq max-inst-len (length (match-string 1 line-string))))
             ( if ( < max-con-len (length (match-string 2 line-string)))
                 (setq max-con-len (length (match-string 2 line-string))))
             ))
          ((string-match "^[ ]*\\.[ ]*\\([^ ]*\\)[ ]+([ ]*\\([^ ].*[^ ]\\|[^ ]\\|\\)[ ]*)[ ]*\\(.*\\)$" line-string)
           (progn
             ( if ( < max-inst-len (length (match-string 1 line-string)))
                 (setq max-inst-len (length (match-string 1 line-string))))
             ( if ( < max-con-len (length (match-string 2 line-string)))
                 (setq max-con-len (length (match-string 2 line-string))))
             ))
     );;;end cond
    ) ;;;end dolist

  ;;;get output string width and format string
  (setq line-output-format (concat "    .%-"
                              (format "%d" (* 10 (+ 1 (/ max-inst-len 10))))
                              "s (%-"
                              (format "%d" (* 10 (+ 1 (/ max-con-len 10))))
                              "s )%-2s %-s"))
  ;;;format output string 
  (dolist (line-string region-line-list new-region-line-list)
    (cond ((string-match "^[ ]*\\.[ ]*\\([^ ]*\\)[ ]+([ ]*\\([^ ].*[^ ]\\|[^ ]\\|\\)[ ]*)[ ]*,[ ]*\\(.*\\)$" line-string)
           (progn
             (setq new-line-string (format line-output-format
                                           (match-string 1 line-string)
                                           (match-string 2 line-string)
                                           ","
                                           (match-string 3 line-string)))))
          ((string-match "^[ ]*\\.[ ]*\\([^ ]*\\)[ ]+([ ]*\\([^ ].*[^ ]\\|[^ ]\\|\\)[ ]*)[ ]*)[ ]*;[ ]*\\(.*\\)$" line-string)
           (progn
             (setq new-line-string (format line-output-format
                                           (match-string 1 line-string)
                                           (match-string 2 line-string)
                                           ");"
                                           (match-string 3 line-string)))))
          ((string-match "^[ ]*\\.[ ]*\\([^ ]*\\)[ ]+([ ]*\\([^ ].*[^ ]\\|[^ ]\\|\\)[ ]*)[ ]*)[ ]*\\(.*\\)$" line-string)
           (progn
             (setq new-line-string (format line-output-format
                                           (match-string 1 line-string)
                                           (match-string 2 line-string)
                                           ")"
                                           (match-string 3 line-string)))))
          ((string-match "^[ ]*\\.[ ]*\\([^ ]*\\)[ ]+([ ]*\\([^ ].*[^ ]\\|[^ ]\\|\\)[ ]*)[ ]*\\(.*\\)$" line-string)
           (progn
             (setq new-line-string (format line-output-format
                                           (match-string 1 line-string)
                                           (match-string 2 line-string)
                                           ""
                                           (match-string 3 line-string)))))
          ;;;default: output origin string
          (t
               (setq new-line-string line-string))
     );;;end cond
    (setq new-region-line-list (append new-region-line-list (list new-line-string)))
    ) ;;;end dolist

  ;;;output and replace region string
  (delete-region region-start-p region-end-p)
  (dolist (line-string new-region-line-list)
    (progn
      (message line-string )
      (insert line-string "\n" )
      )
    )
  ) ;;; end func v-verilog-align-inst


;;* }}} 4.1 verilog instant align


;;* }} 4. personal scripts



(provide 'verilog-mode-config)
