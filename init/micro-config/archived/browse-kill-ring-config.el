;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;yasnippet configure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun micro-browse-kill-ring-dir-set()
  (progn
      (if (eq system-type `windows-nt)
	(setq v-browse-kill-ring-path (concat micro-plugin-path "browse-kill-ring\\"))
        (setq v-browse-kill-ring-path (concat micro-plugin-path "browse-kill-ring/")))
      (add-to-list 'load-path v-browse-kill-ring-path)))

(micro-browse-kill-ring-dir-set)

(require 'browse-kill-ring)
