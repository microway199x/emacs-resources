;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;yasnippet configure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun micro-yasnippet-dir-set()
  (progn
      (if (eq system-type `windows-nt)
	(setq v-yasnippet-path (concat micro-plugin-path "yasnippet\\"))
        (setq v-yasnippet-path (concat micro-plugin-path "yasnippet/")))
      (add-to-list 'load-path v-yasnippet-path)))

(micro-yasnippet-dir-set)

;Yasnippet
(require 'yasnippet)
;设置snippet目录
(setq yas-snippet-dirs '(
     micro-snippets-path;personal snippets
;"~/.emacs.d/custom-snippets" ;personal snippets
;"~/.emacs.d/elpa/yasnippet-20140729.1240/snippets" ;default
;"~/.emacs.d/elpa/yasnippet-20140720.1534/snippets" ;default
))
(yas-global-mode 1)


;;# name: file header
;;# key: fh
;;# binding: direct-keybinding
;;# --
;;#!/usr/bin/env python
;;# coding:utf-8
;;# Filename:`(file-name-nondirectory buffer-file-name)`
;;
;;$0
;;
;;复制代码
;;
;;解释下
;;
;;name: file header 这是片段的名称，叫做 file header，这个 file header会显示在emacs菜单栏的yasnippet里。
;;
;;key: fh 这是快捷键，在文件里输入fh后按tab键就会展开这个片段。
;;
;;从#-- 以下输入代码片段就好了
;;
;;Filename:`(file-name-nondirectory buffer-file-name)` 这个有意思了，这个是显示当前buffer的名字的，让emacs帮你自动写。
;;time:`(format-time-string "%Y-%m-%d,%a")` 利用Elisp直接插入时间 
;;time:`(current-time-string)` 利用Elisp直接插入时间 
;;
;;$0 表示片段展开后光标所在的位置
