;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;自定义函数
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;add-code-review-note 快捷键 C-M-n 用于做笔记
;;ska-point-to-register 标记当前光标所在文件和位置
;;快捷键 C-c 。
;;ska-jump-to-register  回调到标记位置  
;;快捷键 C-c ，
;;go-to-char  快捷键 C-c f 向前查找一个字母
;;go-bto-char 快捷键 C-c b 向后查找一个字母
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;自定义函数操作集合
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;光标停在源代码的需要做批注的位置，然后执行该函数，
;;emacs会创建一个新的叫做NOTES的缓冲区，
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;设置为默认垂直分割窗口
(setq split-height-threshold nil)
(setq split-width-threshold 0)

(defun add-code-review-note ()
   "Add note for current file and line number"
   (interactive)
   (let ((file-name (buffer-file-name))
         (file-line (line-number-at-pos)))
     (switch-to-buffer-other-window (get-buffer-create "NOTES"))
     (goto-char (point-min))
     (when (not (search-forward "-*- mode:compilation-shell-minor"
                                nil t))
       (compilation-shell-minor-mode 1)
       (insert "-*- mode:compilation-shell-minor -*-\n\n"))
     (goto-char (point-max))
     (if (/= (current-column) 0)
         (newline))
     (insert file-name ":" (number-to-string file-line) ": ")))

(global-set-key (kbd "C-M-n") 'add-code-review-note)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;跳到另一个文件进行一些操作，然后很快的跳回来
;;C-.标记
;;C-,回跳
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-c .") 'ska-point-to-register)
(global-set-key (kbd "C-c ,") 'ska-jump-to-register)
(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register. 
Use ska-jump-to-register to jump back to the stored 
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 7))

(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
        (jump-to-register 7)
        (set-register 7 tmp)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-c a x (x 是任意一个字符) 时，光 标就会到下一个 x 处。再次按 x，
;; 光标就到下一个 x。比如 C-c a w w , C-c a b b b 
;; C-c b x (x 是任意一个字符) 时，光 标就会到上一个 x 处
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))

(define-key global-map (kbd "C-c f") 'go-to-char)

(defun go-bto-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-bto-char-key' again will move backwad to the previous Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-backward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-backward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))

(define-key global-map (kbd "C-c b") 'go-bto-char)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;shell command short cut
;;;调用shell 命令
(defun zj-open-directory-with-explorer ()
"在windows中用explorer浏览当前目录"
(interactive)
 (shell-command"explorer.exe .")
 (browse-url"www.google.cn")
)

;;;处理shell命令输出
(defun zj-display-directory-files ()
"执行shell命令并处理它的输出。这里为显示当前目录下的文件"
(interactive)
 (message (shell-command-to-string"ls -l")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;番茄工作法， C-g停止提示
;;M-x my-pomodoro 开始计时
(defun v-ding-ding()
  (interactive)
  (message "time to have a rest,ha ha ha...")
  (setq i 1)
  (while (< i 77)    ;;loop 77 times
     (ding)
     (other-frame 0)
     (sit-for 1)        ;;wait 1s
     (setq i (+ i 1)))) 
  
(defun v-my-pomodoro()
  (interactive)
  (message "pomodoro time enabled")
  (org-clock-in)
 ;; (run-at-time "25 min" nil
  (run-at-time "30" nil
               (lambda ()
                 (progn
                   (org-clock-out) 
                   (setq visible-bell nil)
                   (ding-ding)
                   (setq visible-bell t))
                 t)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;定义auto-space-mode， 用于在中文和英文之间插入空格
;;
(defun add-space-between-chinese-and-english ()
  "Automatically add a space between Chinese and English characters."
  (let ((current-char (char-before))
        (prev-char (char-before (1- (point))))
        (next-char (char-after)))
    (when (and current-char prev-char
               (or (and (is-chinese-character prev-char) (is-halfwidth-character current-char))
                   (and (is-halfwidth-character prev-char) (is-chinese-character current-char)))
               (not (eq prev-char ?\s))) ; Check if the previous character is a space
      (save-excursion
        (goto-char (1- (point)))
        (insert " ")))
    (when (and current-char next-char
               (or (and (is-chinese-character current-char) (is-halfwidth-character next-char))
                   (and (is-halfwidth-character current-char) (is-chinese-character next-char)))
               (not (eq current-char ?\s))) ; Check if the current character is a space
      (save-excursion
        (goto-char (point))
        (insert " ")))))

(defun is-chinese-character (char)
  "判断字符是否为中文字符。"
  (and char (or (and (>= char #x4e00) (<= char #x9fff))
                (and (>= char #x3400) (<= char #x4dbf))
                (and (>= char #x20000) (<= char #x2a6df))
                (and (>= char #x2a700) (<= char #x2b73f))
                (and (>= char #x2b740) (<= char #x2b81f))
                (and (>= char #x2b820) (<= char #x2ceaf)))))

(defun is-halfwidth-character (char)
  "Determine if a character is a halfwidth character using char-width."
  (and char (not (member char '(?\s ?~ ?“ ?”))) (= (char-width char) 1)))

;;(defun is-halfwidth-character (char)
;;  "判断字符是否为半角字符，包括英文字母、数字和标点符号。"
;;  (and char (or (and (>= char ?a) (<= char ?z))
;;                (and (>= char ?A) (<= char ?Z))
;;                (and (>= char ?0) (<= char ?9))
;;                )))

(defun delayed-add-space-between-chinese-and-english ()
  "延迟执行，在中英文之间自动添加空格。"
  (run-with-idle-timer 0 nil 'add-space-between-chinese-and-english))
(defun process-pasted-text (text prev-char next-char)
  "Process pasted TEXT to add spaces between Chinese and English characters, considering PREV-CHAR and NEXT-CHAR."
  (with-temp-buffer
    (insert (if prev-char (concat (char-to-string prev-char) text) text))
    (goto-char (point-min))
    (while (not (eobp))
      (let ((current-char (char-after))
            (next-char-internal (char-after (1+ (point)))))
        (when (and current-char next-char-internal
                   (should-insert-space current-char next-char-internal)
                   (not (eq (char-after) ?\s)))
          (save-excursion
            (goto-char (1+ (point)))
            (insert " "))))
      (forward-char))
    (let ((buffer-content (buffer-string)))
      (if prev-char
          (setq buffer-content (substring buffer-content 1)))
      ;; Add space between the last char of pasted text and next-char
      (setq buffer-content (insert-space-if-needed
                            (aref buffer-content (1- (length buffer-content)))
                            next-char
                            buffer-content))
      buffer-content)))

(defun auto-space-yank-advice (orig-fun &rest args)
  "Advice to automatically add spaces between Chinese and English characters after yanking."
  (let ((beg (point))
        (prev-char (char-before)))
    (apply orig-fun args)
    (let ((end (point))
          (next-char (char-after)))
      (let ((pasted-text (buffer-substring-no-properties beg end)))
        (delete-region beg end)
        (insert (process-pasted-text pasted-text prev-char next-char))))))

(advice-add 'yank :around #'auto-space-yank-advice)
(advice-add 'yank-pop :around #'auto-space-yank-advice)


(define-minor-mode auto-space-mode
  "在中英文之间自动添加空格的模式。"
  :lighter " Auto-Space"
  :global t
  (if auto-space-mode
      (add-hook 'post-self-insert-hook 'add-space-between-chinese-and-english)
    (remove-hook 'post-self-insert-hook 'add-space-between-chinese-and-english)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;person config end here
(provide 'v-common-tooltik)
