
;;;1.0 Flymake common setting
(defvar micro-flymake-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\M-p" 'flymake-goto-prev-error)
    (define-key map "\M-n" 'flymake-goto-next-error)
    map)
  "Keymap for my flymake minor mode.")

(defun my-flymake-err-at (pos)
  (let ((overlays (overlays-at pos)))
    (remove nil
            (mapcar (lambda (overlay)
                      (and (overlay-get overlay 'flymake-overlay)
                           (overlay-get overlay 'help-echo)))
                    overlays))))

(defun my-flymake-err-echo ()
  (message "%s" (mapconcat 'identity (my-flymake-err-at (point)) )))

;;not needed modify behavior now
;;(defadvice flymake-goto-next-error (after display-message activate compile)
;;  (my-flymake-err-echo))
;;
;;(defadvice flymake-goto-prev-error (after display-message activate compile)
;;  (my-flymake-err-echo))

(define-minor-mode micro-flymake-minor-mode
  "Simple minor mode which adds some key bindings for moving to the next and previous errors.

Key bindings:

\\{micro-flymake-minor-mode-map}"
  nil
  nil
  :keymap micro-flymake-minor-mode-map)

;; Enable this keybinding (my-flymake-minor-mode) by default
;; Added by Hartmut 2011-07-05
(add-hook 'flymake-mode-hook 'micro-flymake-minor-mode)



;;;2.0 Flymake program-mode setting

(add-hook 'verilog-mode-hook 'flymake-mode)
(add-hook 'verilog-mode-hook 'micro-flymake-minor-mode)

(require 'flymake-verilog-verilator)


;;;0.0 ending
(provide 'fly-make-config)
