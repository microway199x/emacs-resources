;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;install emacs-which-key config
(defun micro-which-key-dir-set()
  (if (eq system-type `windows-nt)
      (add-to-list 'load-path 
              (concat micro-plugin-path "emacs-which-key\\"))
      (add-to-list 'load-path 
              (concat micro-plugin-path "emacs-which-key"))))
(micro-which-key-dir-set)

(require 'which-key)
;;(which-key-mode)  ;;;default not enable
(provide 'which-key-config)
