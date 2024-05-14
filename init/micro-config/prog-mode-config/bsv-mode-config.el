
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;install BSV-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;install Bsv-mode

(require 'bsv-mode)
;;* 2. outline mode header config
(defun v-bsv-outline-hook ()
  (interactive)
  ; outline uses this regexp to find headers. 
  ; use indent or noindent "///{, ///{{{, "
  ;(setq outline-regexp "[ \t]*///[{\f]+\\|[ \t]*\\(rule\\|function\\|module\\|method\\|interface\\)") //use manually ///{ 
   (setq outline-regexp "[ \t]*///[{\f]+") ;use manually ///{ 
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
)

;;; only when bsv-mode buffer execute
(add-hook 'bsv-mode-hook 'v-bsv-outline-hook)

(provide 'bsv-mode-config)

