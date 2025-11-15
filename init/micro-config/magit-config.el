;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; install magit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun micro-magit-dir-set()
  (if (eq system-type `windows-nt)
      (progn
          (add-to-list 'load-path (concat micro-plugin-path "magit\\"))
          (add-to-list 'load-path (concat micro-plugin-path "magit-section\\"))
      )
      (progn 
          (add-to-list 'load-path (concat micro-plugin-path "magit/"))
          (add-to-list 'load-path (concat micro-plugin-path "magit-section/"))
      )
      ))
(micro-magit-dir-set)

(require 'magit)
