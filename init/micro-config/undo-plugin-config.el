;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;undo-plugin configure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun micro-undo-plugin-dir-set()
  (progn
      (if (eq system-type `windows-nt)
	(setq v-undo-tree-path (concat micro-plugin-path "undo-tree\\"))
        (setq v-undo-tree-path (concat micro-plugin-path "undo-tree")))
      (add-to-list 'load-path v-undo-tree-path))

  (progn
      (if (eq system-type `windows-nt)
	(setq v-vundo-path (concat micro-plugin-path "vundo\\"))
        (setq v-vundo-path (concat micro-plugin-path "vundo")))
      (add-to-list 'load-path v-vundo-path))
  )

(micro-undo-plugin-dir-set)

;Yasnippet
(require 'undo-tree)
(require 'vundo)
(global-undo-tree-mode)
