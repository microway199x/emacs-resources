;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;基本设置

;;Line mode Config,;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(global-linum-mode 1)  ;;左边显示行号
;;(global-hl-line-idle-mode 1);;空闲时高亮当前行

;;highlight back and face config ;;;;;;;;;;;;;;;;;;;
;;通过M-x describe-face，回车，之后选择high-light配置显示颜色等或通过下面的命令配置
;; (1)click on MenuBar Options option,
;; (2)then click on Customize Emacs,
;; (3)then click on Browse Customization Groups,
;; (4)expand Convenience group,
;; (5)expand Hl line group
;; (6)and then customize HighlineMode options.

(global-hl-line-mode 1)
(set-face-background 'highlight "#222")
(set-face-foreground 'highlight 'unspecified)
(set-face-underline 'highlight t)                ;;设置可能被主题覆盖，不起作用

(transient-mark-mode 1)                          ;;highlight mark area


;;frame & window config ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;鼠标只会滑到离边界3行的位置
(setq scroll-margin 3
      scroll-conservatively 10000)           

(tool-bar-mode -1)                               ;;隐藏tool bar

;;;frame setting;;;;;;;;;;
;;(set-frame-position (selected-frame) 0 0)
;;(setq default-frame-alist
;;             '((height . 28) (width . 130) (menu-bar-lines . 20) (tool-bar-lines . 2)))

;;显示当前buffer路径名,
(setq frame-title-format
      (list  "%b" 
             "(" 
             '(buffer-file-name "%f" (dired-directory dired-directory "%b")) 
             ")"  ))

;; window Text width setting 默认显示 80列就换行
(setq-default fill-column 80) 
(global-display-fill-column-indicator-mode)
;;;line wrap mode setting
(global-visual-line-mode 1)                     ;; 启用全局visual line模式
(global-visual-wrap-prefix-mode 1)              ;; 设置基于单词边界的折行前缀
(setq word-wrap-by-category t)                  ;; 可选：调整折行符号显示
(setq visual-line-fringe-indicators  
      '(left-curly-arrow right-curly-arrow))

;;cursor display setting ;;;;;;;;;;;
(mouse-avoidance-mode 'animate)                 ;;光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。
(blink-cursor-mode -1)                          ;;指针不要闪，眼睛花了

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;设置显示括号匹配
(show-paren-mode t)  
(setq show-paren-style 'parenthesis)

;;;easy use setting ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq default-major-mode 'text-mode)            ;; 一打开就启用 text 模式。

;;tab setting  ;;;;;;;;;;;;;;;;;;;;;
(setq tab-width 4) 
(setq-default tab-width 4) 
(setq indent-tabs-mode nil) 
(setq-default indent-tabs-mode nil) 

;;short cuts set;;;;;;;;;;;;;;;;;;;;
(setq echo-keystrokes 0.1)                      ;;尽快显示按键序列
(fset 'yes-or-no-p 'y-or-n-p)

(global-unset-key  (kbd "C-SPC"))
(global-set-key    (kbd "M-SPC") 'set-mark-command)

;;mics setting;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;关闭烦人的出错时的提示声
(setq visible-bell t)
(setq inhibit-startup-message t)
(setq gnus-inhibit-startup-message t)

;;backup file config ;;;;;;;;;;;;;;;
(setq-default make-backup-files nil)            ;;不生成临时文件
(setq make-backup-files nil)                    ;;不生成临时文件

(setq select-enable-clipboard t)                ;;允许emacs和外部其他程序的粘贴;;

;;auto revert and auto save ;;;;;;;;
(global-auto-revert-mode t)                    ;;文件更改后自动加载文件
;;(setq auto-save-default nil)                 ;;默认300s自动保存一次

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;设置主题
(add-to-list 'load-path micro-theme-path)
(add-to-list 'load-path (concat micro-theme-path "gruvbox"))
(add-to-list 'load-path (concat micro-theme-path "ef-themes"))
(add-to-list 'custom-theme-load-path micro-theme-path)
;(load-theme 'solarized-[light|dark] t))
;(load-theme 'gruvbox-light-soft t)
;(load-theme 'micro-light t)

(use-package ef-themes
  ;;:ensure t
  :init
  ;; This makes the Modus commands listed below consider only the Ef
  ;; themes.  For an alternative that includes Modus and all
  ;; derivative themes (like Ef), enable the
  ;; `modus-themes-include-derivatives-mode' instead.  The manual of
  ;; the Ef themes has a section that explains all the possibilities:
  ;;
  ;; - Evaluate `(info "(ef-themes) Working with other Modus themes or taking over Modus")'
  ;; - Visit <https://protesilaos.com/emacs/ef-themes#h:6585235a-5219-4f78-9dd5-6a64d87d1b6e>
  (ef-themes-take-over-modus-themes-mode 1)
  :bind
  (("<f5>"   . modus-themes-rotate)
   ("C-<f5>" . modus-themes-select)
   ("M-<f5>" . modus-themes-load-random))
  :config
  ;; All customisations here.
  (setq modus-themes-mixed-fonts t)
  (setq modus-themes-italic-constructs t)

  ;; Finally, load your theme of choice (or a random one with
  ;; `modus-themes-load-random', `modus-themes-load-random-dark',
  ;; `modus-themes-load-random-light').
  ;;(modus-themes-load-theme 'ef-summer)
  (modus-themes-load-random-light)

  ;;fontset for chinese 
  (if (eq system-type `windows-nt)
    (progn
       (set-frame-font "Consolas-14")
       (set-fontset-font "fontset-default"  
                         'gb18030 "KaiTi" ));; end progn
  (set-frame-font "Mono-14"))
) ;;;end use-packages 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;设置中英文字体，使中英文字体都舒服的显示
;;以下两种方式都可以良好的使用

(when (eq system-type 'windows-nt)
  ;;(set-default buffer-file-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  ;;(setq locale-coding-system 'gbk)
  ;;(setq w32-unicode-filenames 'gbk)
  (setq file-name-coding-system 'gbk)
  ;;(setq default-buffer-file-coding-system 'gbk)
  ;;(prefer-coding-system 'gbk)
  ;;(setq locale-language-environment 'gbk)
  ;;(setq current-language-environment 'gbk)'
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;设置常用公共函数
(defun micro-common-tooltik-dir-set()
  (if (eq system-type `windows-nt)
      (add-to-list 'load-path 
         (concat micro-config-path "micro-lib\\"))
      (add-to-list 'load-path 
         (concat micro-config-path "micro-lib"))))
(micro-common-tooltik-dir-set)
(require 'v-common-tooltik)
(auto-space-mode t)


(provide 'common-config)

