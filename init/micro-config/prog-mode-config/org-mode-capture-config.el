;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;org-mode capture function config here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun micro-org-capture-dir-set()
  (if (eq system-type `windows-nt)
      (setq micro-org-capture-path 
        "D:\\~notes\\org-gtd\\")
      (setq micro-org-capture-path 
        "~/note-gtd-ebook/org-gtd/")))
(micro-org-capture-dir-set)

(defun v-open-todo-list()
  """open todo file and agenda mode"""
  (interactive)
  (find-file (concat micro-org-capture-path "todo_capture.org"))
  (find-file (concat micro-org-capture-path "todo_BrainStorm.org"))
  (find-file (concat micro-org-capture-path "todo.org"))
  (find-file "D:/micro_data_plantform/work/~notes/org-gtd/todo.org")
  (org-mode)
  (setq org-agenda-start-with-log-mode t)
  (setq org-agenda-files (list (concat micro-org-capture-path "todo.org")
                               (concat micro-org-capture-path "todo_capture.org")
                               (concat micro-org-capture-path "todo_BrainStorm.org")
                               "D:/micro_data_plantform/work/~notes/org-gtd/todo.org"
                          ))
  ;;(org-agenda)
  ;;(org-agenda-day-view)
  )

;;(setq org-agenda-files (file-expand-wildcards (concat micro-org-capture-path "*.org")))
;;(setq org-agenda-files (list (file-expand-wildcards (concat micro-org-capture-path "*.org"))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;¨¦¨¨??org-capture
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-capture-templates 
      ;;;;add todo task
      '(("t" "Todo" entry
         (file+headline "D:\\~notes\\org-gtd\\todo_capture.org"
                        "task") 
           "* %t %?\n %i\n")
      ;;   "* %?\n %i\n %a") ;;change for all mannul input
      ;;;;use to collect ideas and brainstorm
        ("b" "Brainstorm" entry 
         (file+datetree "D:\\~notes\\org-gtd\\brainstroam_capture.org")
          "* %t %?\n %U\n %i\n")))
        ;;"* %t %?\n %U\n %i\n %a"))) ;;use input manually



(provide 'org-capture-config)
