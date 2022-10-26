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

(provide 'verilog-mode-config)
