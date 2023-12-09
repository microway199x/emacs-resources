;;; flymake-verilator --- Flymake for Verilog  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'flymake)

(defvar verilog--flymake-proc nil
  "A flymake verilog process.")

(defvar verilog-flymake-command '("verilator" "--lint-only" "-Wall")
  "Command for verilog's flymake.")

(defvar verilog--flymake-output-buffer " *stderr of verilog-flymake*"
  "Buffer for verilog's flymake output.")

(defun verilog-flymake-done (report-fn
                             source-buffer
                             output-buffer)
  (with-current-buffer source-buffer
    (save-excursion
      (save-restriction
        (with-current-buffer output-buffer
          (goto-char (point-min))
          (let ((diags))
            (while (search-forward-regexp
                    "^\\(%.*\\): .*:\\([0-9]+\\):\\([0-9]+\\): \\(.*\\)$"
                    nil t)
              (let* ((msg (match-string 4))
                     (level-msg (match-string 1))
                     (line (string-to-number (match-string 2)))
                     (locate-string)
                     (cal)
                     (beg)
                     (end)
                     (level))
                (setq level (cond
                             ((string-match-p "%Error" level-msg) ':error)
                             ((string-match-p "%Warning" level-msg) ':warning)
                             (t :note)))

                (search-forward-regexp "\\(\\^~*\\)" nil t)
                (setq cal (length (match-string 1)))
                (let ((current (point))
                      (line-beginning (line-beginning-position)))
                  (forward-line -1)
                  (forward-char (- current line-beginning))
                  (setq locate-string (buffer-substring-no-properties (- (point) cal) (point))))

                (setq beg (with-current-buffer source-buffer
                            (save-excursion
                              (save-restriction
                                (goto-char (point-min))
                                (or (equal line 1)
                                    (forward-line (- line 1)))
                                (search-forward locate-string nil t)
                                (- (point) cal)
                                ))))
                (setq end (+ beg cal))

                (setq diags
                      (cons (flymake-make-diagnostic
                             source-buffer beg end level msg)
                            diags))
                ))
            (funcall report-fn diags)
            )))))
  )

(defun verilog-flymake-detect (report-fn &rest _args)
  "A Flymake backend for verilog.
Spawn an verilator process that byte-compiles a file representing the
current buffer state and calls REPORT-FN when done."
  (interactive)
  (when verilog--flymake-proc
    (when (process-live-p verilog--flymake-proc)
      (kill-process verilog--flymake-proc)))
  (let ((source-buffer (current-buffer))
        (coding-system-for-write 'utf-8-unix)
        (coding-system-for-read 'utf-8))
    (save-restriction
      (widen)
      (let* ((output-buffer (generate-new-buffer " *verilog-flymake*")))
        (setq verilog--flymake-proc
              (make-process
               :name "verilog-flymake-process"
               :buffer output-buffer
               :command (append verilog-flymake-command
                                (list (buffer-file-name source-buffer)))
               :connection-type 'pipe
               :sentinel
               (lambda (proc _event)
                 (unless (process-live-p proc)
                   (unwind-protect
                       (cond
                        ((not (and (buffer-live-p source-buffer)
                                   (eq proc (with-current-buffer source-buffer
                                              verilog--flymake-proc))))
                         (flymake-log :warning
                                      "verilog-flymake process %s obsolete" proc))
                        ((memq (process-status proc) '(exit signal))
                         (verilog-flymake-done report-fn
                                               source-buffer
                                               verilog--flymake-output-buffer
                                               ))
                        (t
                         (funcall report-fn
                                  :panic
                                  :explanation
                                  (format "process %s died" proc))))
                     (kill-buffer verilog--flymake-output-buffer)
                     )))
               :stderr verilog--flymake-output-buffer
               :noquery t))))))

(defun verilog-setup-flymake-backend ()
  "Setup `flymake-verilator' for verilog buffer."
  (add-hook 'flymake-diagnostic-functions 'verilog-flymake-detect nil t))

(add-hook 'verilog-mode-hook 'verilog-setup-flymake-backend)

(provide 'flymake-verilog-verilator)
;;; flymake-verilator.el ends here.
