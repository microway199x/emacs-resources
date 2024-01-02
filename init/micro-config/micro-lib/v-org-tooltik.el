;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;add for org-mode 
(defun micro-org-insert-picture ()
  """use this function to insert picture 
   link @current directory/diagram/xxx.png"""
   (interactive)
   (setq micro-file-name (read-string "insert path and filename mannuly: ")) 
   (insert "#+CAPTATION: <typing in>  \n")
   (insert "#+LABEL:  \n")
   (insert "#+ATTR_HTML: :TITLE <typing in> :WIDTH 500  \n") 
   (insert (concat "[[" default-directory "diagram/" micro-file-name "]]")))
(global-set-key (kbd "C-c p i") 'micro-org-insert-picture)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;org do screenshots and insert to org files
;;; windows use tool:snipaster
;;; linux   use tool:flameshot
(defvar v-snip-exe-path "C:\\tools\\Snipaste\\Snipaste.exe")
;;if path-name has space
;;(defvar v-snip-exe-path "C:/\"Program Files\"/Snipaste/Snipaste.exe")
;;(defvar v-snip-quick-save "D:\\software\\snipaste\\quick-save\\snip-quick-save.png")
(defun v-org-snip-insert ()
  "Take a screenshot into a unique-named file in the current buffer file
   directory and insert a link to this file."
  (interactive)
  (lower-frame)
  (let* ((capture-name (concat (format-time-string "%Y%m%d%H%M%S") ".png"))
         (capture-imag-dir (concat "_images_" (file-name-nondirectory buffer-file-name) "/"))
         (capture-save-path (concat (file-name-directory buffer-file-name) capture-imag-dir))
         (capture-file (concat capture-save-path capture-name))
         (v-org-file-path 
          (if (eq system-type `windows-nt)
               (encode-coding-string (replace-regexp-in-string "/" "\\\\" capture-file) 'gbk)
               capture-file
               )))
;;(setq capture-file (concat capture-save-path capture-name))
  (progn (message v-org-file-path)
 ;;;;; comment for version V0.01 snipaste not support filename output command ;;;;;;;;;;;;;
     ;;  (shell-command (concat "del " v-snip-quick-save))
     ;;  (shell-command (concat v-snip-exe-path " snip -o quick-save")) ;;
     ;;  (unless (file-exists-p  capture-save-path)
     ;;      (make-directory capture-save-path))
     ;; (while (not (file-exists-p v-snip-quick-save))
     ;;    (run-with-idle-timer 23 nil (lambda() (message "waiting picture capture none......"))))
     ;;  (run-with-idle-timer 23 nil
     ;;	(lambda(v-snip-quick-save v-org-file-path)
     ;;            (progn (shell-command (concat "copy " v-snip-quick-save " " v-org-file-path))
     ;;		  (shell-command (concat "del " v-snip-quick-save))
     ;;		  )
     ;;	   ) v-snip-quick-save v-org-file-path)
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (unless (file-exists-p  capture-save-path)
             (make-directory capture-save-path))
          (if (eq system-type `windows-nt)
            (progn ;;; if windows 
                 (shell-command (concat v-snip-exe-path " snip -o \"" v-org-file-path "\""))) ;;
                 ;; if use async-shell-command, emacs will not be hang
                 ;;(async-shell-command (concat v-snip-exe-path " snip -o \"" v-org-file-path "\""))) ;;
            (progn ;;; if linux
                 (shell-command (concat  "flameshot gui -p " v-org-file-path )))) ;;
                 ;;(async-shell-command (concat  "flameshot gui -p " v-org-file-path )))) ;;

       ;;(insert "#+CAPTATION: <typing in>  \n")
       ;;(insert "#+LABEL:  \n")
       ;;(insert "#+ATTR_HTML: :TITLE <typing in> :WIDTH 500  \n") 
       ;;(insert "#+ATTR_HTML: :TITLE <typing in> :WIDTH   \n") ;; 
         (insert (concat "[[./" capture-imag-dir capture-name "]]"))
       ;;(org-display-inline-images)
	 )))



(defun v-org-snip-del ()
  "del org link and its file  "
  (interactive)
  (beginning-of-line)
  (search-forward "[[")
  (setq path-string-begin (point))
  (search-forward "png")
  (setq path-string-end (point))
  (setq v-line-path-get
	(replace-regexp-in-string "/" "\\\\"
	  (buffer-substring path-string-begin path-string-end)))
  (if (eq system-type `windows-nt)
      (shell-command (concat "del " v-line-path-get))
      (shell-command (concat "rm -rf " v-line-path-get)))
  (beginning-of-line)
  (kill-line))


(defun v-org-snip-del-region ()
  "del org link and its file  "
  (interactive)
  (narrow-to-region (region-beginning) (region-end))
  (while (search-forward-regexp "\[\[.*_images.*org.*png\]\]")
    (v-org-snip-del))
  ;;(widen)
)

(global-set-key (kbd "C-c p s") 'v-org-snip-insert)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;org drag picture to org files and 
;;insert picture path to org files
;; drag file to org mode
;; http://kitchingroup.cheme.cmu.edu/blog/2015/07/10/Drag-images-and-files-onto-org-mode-and-insert-a-link-to-them/
(defun my-dnd-func (event)
  (interactive "e")
  (goto-char (nth 1 (event-start event)))
  (x-focus-frame nil)
  (let* ((payload (car (last event)))
         (type (car payload))
         (fname (cadr payload))
         (img-regexp "\\(png\\|jp[e]?g\\|svg\\)\\>"))
    (cond
     ;; insert image link
     ((and  (eq 'drag-n-drop (car event))
            (eq 'file type)
            (string-match img-regexp fname))
      (dired-copy-file fname (format "./imgs/%s" (file-name-nondirectory fname)) t)
      (insert "#+ATTR_HTML: :width 100%\n")
      (insert (format "[[%s]]" (format "./imgs/%s" (file-name-nondirectory fname))))
      (org-display-inline-images))
     ;; regular drag and drop on file
     (t
      (error "I am not equipped for dnd on %s" payload)))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 增加org log time可视化
(defun v-org-agenda-time-grid-spacing ()
  "Set different line spacing w.r.t. time duration."
  (save-excursion
    (let* ((background (alist-get 'background-mode (frame-parameters)))
           (background-dark-p (string= background "dark"))
           (colors (if background-dark-p
                       (list "#aa557f" "DarkGreen" "DarkSlateGray" "DarkSlateBlue")
                     (list "#F6B1C3" "#FFFF9D" "#BEEB9F" "#ADD5F7")))
           pos
           duration)
      (nconc colors colors)
      (goto-char (point-min))
      (while (setq pos (next-single-property-change (point) 'duration))
        (goto-char pos)
        (when (and (not (equal pos (point-at-eol)))
                   (setq duration (org-get-at-bol 'duration)))
          (let ((line-height (if (< duration 30) 1.0 (+ 0.5 (/ duration 60))))
                (ov (make-overlay (point-at-bol) (1+ (point-at-eol)))))
            (overlay-put ov 'face `(:background ,(car colors)
                                                :foreground
                                                ,(if background-dark-p "black" "white")))
            (setq colors (cdr colors))
            (overlay-put ov 'line-height line-height)
            (overlay-put ov 'line-spacing (1- line-height))))))))

(add-hook 'org-agenda-finalize-hook #'v-org-agenda-time-grid-spacing)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; add roam notes mode for org-mode
;;TODO if need any other scence, v-roam-insert shall as base api

(defun v-roam-creat-single-file()
  (interactive)
  ;; 1. creat a new file ,and use this command puts file link to overview file
  ;; isolation file, without any connect
  (let* ((vv-roam-cur-file-name  (file-name-nondirectory buffer-file-name)))
     (goto-char (point-max))
     (newline 1)
     (forward-line)
     (beginning-of-line)
     (insert (format "* reference links"))
     ;; refresh roam overview file 
     (v-roam-overview-refresh t vv-roam-cur-file-name "")
     (switch-to-buffer vv-roam-cur-file-name)
     ))

(defun v-roam-creat-insert()
  (interactive)
  (let* ((vv-roam-cur-file-name  (file-name-nondirectory buffer-file-name))
         (vv-roam-link-file-name (if (equal "y" (read-string "reference exists file?, if yes,type y:"))
		 		 (file-name-nondirectory (read-file-name "select the reference note name:"))
                                 (read-string "input the reference note name, if no,type N:")))
          (vv-roam-ref-link (format"** roam ref note: [[file:%s]]" vv-roam-link-file-name))
          (vv-roam-back-link (format"** roam back note: [[file:%s]]" vv-roam-cur-file-name)))
     ;; insert reference link @ the end of file name 
     (goto-char (point-max))
     (newline)
     ;(newline 1)
     ;(forward-line)
     (beginning-of-line)
     (insert vv-roam-ref-link)
     ;; insert back link @ the end of file name 
     (if (equal "y" (read-string "need insert back link? if yes, type \"y\":"))
	 (progn
             (find-file vv-roam-link-file-name)
             (goto-char (point-max))
             (newline)
             ;(newline 1)
             ;(forward-line)
             (beginning-of-line)
             (insert vv-roam-back-link)))
     ;; refresh roam overview file 
     (v-roam-overview-refresh nil vv-roam-cur-file-name vv-roam-link-file-name)
     (switch-to-buffer vv-roam-cur-file-name)
     ))

(defun v-roam-insert-otherdir()
  (interactive)
  (let* ((vv-roam-cur-file-name  (file-name-nondirectory buffer-file-name))
          ;;(vv-roam-link-file-name (read-file-name "input the reference note name:"))
	  ;; mannual input relative path, for use @different device
          ;;(vv-roam-link-file-name (read-string "input the reference note name:"))
          (vv-roam-link-file-name (if (equal "y" (read-string "reference exists file?, if yes,type y:"))
		 		  (file-name-nondirectory (read-file-name "select the reference note name:"))
                                  (read-string "input the reference note name, if no,type N:")))
          (vv-roam-ref-link (format"roam ref note: [[file:%s]]" vv-roam-link-file-name))
          (vv-roam-back-link (format"roam back note: [[file:%s]]" vv-roam-cur-file-name)))
	  
     ;; insert reference link @ the end of file name 
     (goto-char (point-max))
     (newline)
     ;(newline 1)
     ;(forward-line)
     (insert vv-roam-ref-link)
     ;; insert back link @ the end of file name 
     (if (equal "y" (read-string "need insert back link?:"))
	 (progn
            (find-file vv-roam-link-file-name)
            (goto-char (point-max))
            (newline 1)
            (forward-line)
            (insert vv-roam-back-link)))
     ;; refresh roam overview file 
     (v-roam-overview-refresh nil vv-roam-cur-file-name vv-roam-link-file-name)
     (switch-to-buffer vv-roam-cur-file-name)
     ))

(defun v-roam-overview-refresh(vv-roam-create-single-file vv-roam-cur-file vv-roam-link-file)
  (if (not (file-exists-p "0-roam-overview.org"))
    (progn
      (find-file "0-roam-overview.org")
      (goto-char (point-min))
      (insert "* all-notes-list")
      (newline)
      (forward-line)
      (insert "* roam-relationship")
      (newline)
      (insert "#+BEGIN_SRC dot :file 0-roam-overview.png :cmdline -Kdot -Tpng")
      (newline)
      (insert "digraph G {")
      (newline)
      (insert "    layout=neato;")
      (newline)
      (insert "    //roam-connect-start")
      (newline)
      (insert "}")
      (newline)
      (insert "#+END_SRC")
      ))
    ;; put file input overview file list
      (find-file "0-roam-overview.org")
      (goto-char (point-min))
      (if (not (re-search-forward (format "\\[\\[file:%s\\]\\]" vv-roam-cur-file) (point-max) t 1))
        (progn 
	    (goto-char (point-min))
	    (search-forward "* all-notes-list" (point-max) t)
	    (newline 1)
            (insert (format "[[file:%s]]" vv-roam-cur-file))))

      (if (equal nil vv-roam-create-single-file)
	  (progn 
              (goto-char (point-min))
              (if (not (re-search-forward (format "\\[\\[file:%s\\]\\]" vv-roam-link-file) (point-max) t 1))
              	(progn
              	    (goto-char (point-min))
              	    (search-forward "* all-notes-list" (point-max) t)
              	    (newline 1)
                    (insert (format "[[file:%s]]" vv-roam-link-file))))
              ;; insert roam file connect 
              (goto-char (point-min))
              (if (search-forward "roam-connect-start" (point-max) t 1)
              	  (progn
              	    (newline)
                    (insert (format "    \"%s\" -> \"%s\";" (file-name-base vv-roam-cur-file) (file-name-base vv-roam-link-file))))))
	(progn
              ;; insert roam file connect 
              (goto-char (point-min))
              (if (search-forward "roam-connect-start" (point-max) t 1)
              	  (progn
              	    (newline)
                    (insert (format "    \"%s\";" (file-name-base vv-roam-cur-file))))))
       )  ;;end if
      (setq buffer-save-without-query t)
      (save-some-buffers)
      (setq buffer-save-without-query nil)
      ) ;;end defun

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;person config end here
(provide 'v-org-tooltik)
