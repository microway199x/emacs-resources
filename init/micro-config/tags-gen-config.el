

    (setq v-tags-default-directory "~/editor-tags/emacs/TAGS")
    (setq v-tags-proj-root (directory-file-name default-directory))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;create tags use Ctags

;; normally system has Ctags, use ctags --help try, not need conffig ctags command path
;; (setq path-to-ctags "/opt/local/bin/ctags") ;; config your ctags path here
  (defun v-create-ctags (dir-name)
    "Create tags file.use DDirectory selece directory"
    (interactive "DDirectory: ")
    (shell-command
     ;;(format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name)))
       (format "ctags -f TAGS -e -R %s"  v-tags-proj-root)
       (setq (cons tags-table-list (concat v-tags-proj-root "/" "TAGS")))
  ))


;;;etags not support verilog  --> take attention
(defun v-create-etags (dir-name)
     "Create tags file."
     (interactive "DDirectory: ")
     (eshell-command 
      (format "find %s -type f -name \"*.[svch]\" | etags -" dir-name)))


;;use find-tag
;;or use find-tag-regexp use regexp search
  (defun v-find-tags ()
    (interactive "find tags at-point ")
    (find-tags (thing-at-point thing)))

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
