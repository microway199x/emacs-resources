;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; install magit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun micro-magit-dir-set()
  (if (eq system-type `windows-nt)
      (progn
          (add-to-list 'load-path (concat micro-plugin-path "magit\\"))
          (add-to-list 'load-path (concat micro-plugin-path "magit-section\\"))
          (add-to-list 'load-path (concat micro-plugin-path "dash\\"))
          (add-to-list 'load-path (concat micro-plugin-path "git-commit\\"))
          (add-to-list 'load-path (concat micro-plugin-path "transient\\"))
          (add-to-list 'load-path (concat micro-plugin-path "with-editor\\"))
      )
      (progn 
          (add-to-list 'load-path (concat micro-plugin-path "magit/"))
          (add-to-list 'load-path (concat micro-plugin-path "magit-section/"))
          (add-to-list 'load-path (concat micro-plugin-path "dash/"))
          (add-to-list 'load-path (concat micro-plugin-path "git-commit/"))
          (add-to-list 'load-path (concat micro-plugin-path "transient/"))
          (add-to-list 'load-path (concat micro-plugin-path "with-editor/"))
      )
      ))
(micro-magit-dir-set)

(require 'magit)
