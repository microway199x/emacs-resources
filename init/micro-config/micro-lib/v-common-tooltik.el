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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;person config end here
(provide 'v-common-tooltik)
