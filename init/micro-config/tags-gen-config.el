

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;create tags use Ctags: use exuberant-ctags or universal-ctags(recommended)

;; (setq v-tags-default-directory "<the proj root>")
  (defun v-create-ctags (dir-name)
    """Create tags file use interactive <D> select directory
    and set tags-table-list to tags-table-list """
    (interactive "Dproj root dir: ")
    ;;dir-name: function parameter input at mini-buffer
    (setq v-tags-proj-root dir-name)

    (shell-command
       (format "rm -rf %s/.PROJ_TAGS"  v-tags-proj-root))
    (shell-command
      ;; normally system has Ctags, use ctags --help try, not need conffig ctags command path
      ;; (setq path-to-ctags "/opt/local/bin/ctags") ;; config which ctags-program-used-path here
     ;;(format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name)))
       (format "ctags -f .PROJ_TAGS -R %s --language-force=Verilog"  v-tags-proj-root))

       (setq tags-table-list (cons  (concat v-tags-proj-root ".PROJ_TAGS") tags-table-list)))

;;;etags not support verilog  --> take attention
(defun v-create-etags (dir-name)
    """Create tags file use interactive <D> select directory
    and set tags-table-list to tags-table-list """
    (interactive "Dproj root dir: ")
    ;;dir-name: function parameter input at mini-buffer
    
     (setq v-tags-proj-root dir-name)
     (shell-command
       (format "rm -rf %s/.PROJ_TAGS"  v-tags-proj-root))
     (eshell-command 
      (format "find %s -type f -name \"*.[svch]\" | etags -f .PROJ_TAGS" dir-name))
      (setq tags-table-list (cons (concat v-tags-proj-root ".PROJ_TAGS") tags-table-list )))

;;use find-tag find word @ current point, after do creat-etags
;;or use find-tag-regexp use regexp search
  (defun v-find-tags ()
    (interactive )
    ;;if tags-table-list is nil, will do visit-tags-table first
    (find-tag (thing-at-point 'symbol)))

;;; not generate TAGS automatic ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  (defadvice v-find-tag (around refresh-etags activate)
;;;   "Rerun etags and reload tags if tag not found and redo find-tag.              
;;;   If buffer is modified, ask about save before running etags."
;;;  (let ((extension (file-name-extension (buffer-file-name))))
;;;    (condition-case err
;;;    ad-do-it
;;;      (error (and (buffer-modified-p)
;;;          (not (ding))
;;;          (y-or-n-p "Buffer is modified, save it? ")
;;;          (save-buffer))
;;;         (v-refresh-etags extension)
;;;         ad-do-it))))
;;;
;;;
;;;  (defun v-refresh-etags (&optional extension)
;;;  "Run etags on all peer files in current dir and reload them silently."
;;;  (interactive)
;;;  (shell-command (format "etags *.%s" (or extension "v" "sv" "svh" "vh")))
;;;  (let ((tags-revert-without-query t))  ; don't query, revert silently          
;;;    (visit-tags-table v-tags-default-directory nil)))


(provide 'tags-gen-config)
