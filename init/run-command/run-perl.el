(defun run-perl()
  "run perl,执行当前缓冲区的Perl程序"
  (interactive)
  ;(save-buffer)
  (let ((filename buffer-file-name)
       (cmd "")
       (oldbuf (current-buffer))
       (end (point-max)))
      (if filename
          (save-buffer)
          (save-excursion
              (setq filename (concat (getenv "tmp") "/temp.pl"))
              (set-buffer (create-file-buffer filename))
              (insert-buffer-substring oldbuf 1 end)
              (write-file filename)
              (kill-buffer (current-buffer))))
    (setq cmd (concat "perl -w " filename))
    (message "%s  ..." cmd)
    (shell-command cmd)))
(provide 'run-perl)


