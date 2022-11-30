;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;yasnippet configure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun micro-elisp-demos-dir-set()
  (progn
      (if (eq system-type `windows-nt)
	(setq v-elisp-demos-path (concat micro-plugin-path "elisp-demos\\"))
        (setq v-elisp-demos-path (concat micro-plugin-path "elisp-demos/")))
      (add-to-list 'load-path v-elisp-demos-path)))

(micro-elisp-demos-dir-set)
(require 'elisp-demos)

(advice-add 'describe-function-1 :after #'elisp-demos-advice-describe-function-1)
(advice-add 'helpful-update :after #'elisp-demos-advice-helpful-update)
