
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;install BSV-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;install Bsv-mode
(defun micro-bsv-dir-set()
  (if (eq system-type `windows-nt)
      (progn
          (add-to-list 'load-path (concat micro-prog-mode-path "bsv-mode\\"))
          (add-to-list 'load-path (concat micro-prog-mode-path "bsv-mode\\bsv-mode\\")))
      (progn
          (add-to-list 'load-path (concat micro-prog-mode-path "bsv-mode/"))
          (add-to-list 'load-path (concat micro-prog-mode-path "bsv-mode/bsv-mode/")))
      ))
(micro-bsv-dir-set)

;;* 2. outline mode header config
(defun v-bsv-outline-hook ()
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
  (define-key evil-normal-state-map (kbd "TAB") 'outline-toggle-children)
  (define-key evil-normal-state-map (kbd "<backtab>") 'outline-show-subtree) ;;shift + tab
)

;;; only when bsv-mode buffer execute
(add-hook 'bsv-mode-hook 'v-bsv-outline-hook)

(require 'bsv-mode)
(provide 'bsv-mode-config)

