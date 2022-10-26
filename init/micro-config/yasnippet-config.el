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
;����snippetĿ¼
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
;;���ƴ���
;;
;;������
;;
;;name: file header ����Ƭ�ε����ƣ����� file header����� file header����ʾ��emacs�˵�����yasnippet�
;;
;;key: fh ���ǿ�ݼ������ļ�������fh��tab���ͻ�չ�����Ƭ�Ρ�
;;
;;��#-- �����������Ƭ�ξͺ���
;;
;;Filename:`(file-name-nondirectory buffer-file-name)` �������˼�ˣ��������ʾ��ǰbuffer�����ֵģ���emacs�����Զ�д��
;;time:`(format-time-string "%Y-%m-%d,%a")` ����Elispֱ�Ӳ���ʱ�� 
;;time:`(current-time-string)` ����Elispֱ�Ӳ���ʱ�� 
;;
;;$0 ��ʾƬ��չ���������ڵ�λ��
