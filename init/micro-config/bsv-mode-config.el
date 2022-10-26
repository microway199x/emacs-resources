
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

(require 'bsv-mode)
(provide 'bsv-mode-config)

