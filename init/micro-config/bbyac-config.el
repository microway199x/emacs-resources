;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;yasnippet configure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun micro-bbyac-dir-set()
  (progn
      (if (eq system-type `windows-nt)
	(setq v-bbyac-path (concat micro-plugin-path "bbyac\\"))
        (setq v-bbyac-path (concat micro-plugin-path "bbyac/")))
      (add-to-list 'load-path v-bbyac-path)))

(micro-bbyac-dir-set)

(require 'bbyac)
(bbyac-global-mode 1)
