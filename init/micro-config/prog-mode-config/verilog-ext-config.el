
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;install verilog-ext
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;install verilog-ext
(defun micro-verilog-ext-dir-set()
  (if (eq system-type `windows-nt)
      (progn
          (add-to-list 'load-path (concat micro-prog-mode-path "verilog-ext\\")))
      (progn
          (add-to-list 'load-path (concat micro-prog-mode-path "verilog-ext")))
      ))
(micro-verilog-ext-dir-set)
(setq verilog-ext-feature-list
      '(font-lock
        ;;xref
        ;;capf
        ;;hierarchy
        ;;eglot
        ;;lsp
        ;;lsp-bridge
        ;;lspce
        ;;flycheck
        ;;beautify
        ;;comment for can not install ag.dll @windows
        ;;navigation 
        ;;template
        ;;formatter
        ;;compilation
        ;;imenu
        ;;which-func
        ;;hideshow
        ;;typedefs
        ;;time-stamp
        ;;block-end-comments
        ports))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;set up example
;;(setq verilog-ext-project-alist
;;      `(("ucontroller" ; Project name
;;         :root "/home/gonz/Repos/larumbe/ucontroller" ; supports remote dirs via Tramp
;;         :files ("src/my_block.sv"
;;                 "src/*.v") ; Multiple files can be specified through the glob pattern
;;         :dirs ("src/tb"
;;                "-r src/rtl" ; -r to add directories recursively
;;                "src/syn/*_block"
;;                "src/**/netlists") ; add all dirs that begin with "src" and end with "netlists"
;;         :ignore-dirs ("src/ignored_ip")
;;         :ignore-files ("src/some_ip/ignored_sim_netlist.v")
;;         :compile-cmd "make tb_top" ; command used to compile current project
;;         ;; `vhier' related properties
;;         :command-file "commands.f" ; vhier command file
;;         :lib-search-path nil)))    ; list of dirs to look for include directories or libraries
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun v-get-directory-verilog-file (dir)
  "Print the names of all files in the directory DIR and its subdirectories."
  (interactive "DDirectory: ")
  (let ((files (directory-files dir t)))
    (dolist (file files)
      (if (file-directory-p file)
          (v-get-directory-verilog-file file)
          (progn 
              (if (or (string= "v" (file-name-extension file ))
                      (string= "sv" (file-name-extension file)))
                  (setq v-verilog-file-list (cons file v-verilog-file-list))))
        ))))

(defun v-get-directory-verilog-file (dir)
    (interactive "Update verilog-ext proj info path: ")
    (setq v-verilog-proj-path  (file-name-as-directory (expand-file-name default-directory)))
    ;;get all verilog filelist
    (setq v-verilog-file-list  '())
    (setq v-verilog-file-list  (v-get-directory-verilog-file v-verilog-proj-path))
    (setq verilog-ext-project-alist
         `(("default_shall_update" ; Project name
            :root v-verilog-proj-path
            :files  v-verilog-file-list
           :dirs ("src/tb"
                  "-r src/rtl" ; -r to add directories recursively
                  "src/*"
                  "src/**/rtl") ; add all dirs that begin with "src" and end with "netlists"
           :ignore-dirs ("src/ignored_ip")
           :ignore-files ("src/some_ip/ignored_sim_netlist.v")
           :compile-cmd "make tb_top" ; command used to compile current project
           ;; `vhier' related properties
           :command-file "commands.f" ; vhier command file
           :lib-search-path nil)))    ; list of dirs to look for include directories or libraries
  )
      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'verilog-ext)

(verilog-ext-mode-setup)
(add-hook 'verilog-mode-hook #'verilog-ext-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'verilog-ext-config)

