;;Time-stamp: < 2010-10-20 19:28:27>

;;外观设置
;; 设置启动窗口大小
(dolist (key '((height . 24) 		;注意单位是×行
	       (width . 80)		;注意单位是×列
	       ;;(menu-bar-lines . 1)
	       ;;(tool-bar-lines . 0))
	       ))
  (setq default-frame-alist (assq-delete-all (car key) default-frame-alist)) ;先把重复的键干掉
  (push key default-frame-alist))

;; 不要工具栏
(tool-bar-mode 0)
;; 不要菜单
;;(menu-bar-mode nil)
;; 不要滚动栏
(scroll-bar-mode nil)
;;修改中文文本的行距,3个象素
;;(setq-default line-spacing 1)

;;时间显示设置
;;时间使用24小时制
(setq display-time-24hr-format t)
;;时间显示包括日期和具体时间
;; (setq display-time-day-and-date t)
;; ;;时间栏旁边启用邮件设置
;; (setq display-time-use-mail-icon t)
;;时间的变化频率
(setq display-time-interval 10)
;;显示时间的格式
;;(setq display-time-format "%a %b %d %H:%M") ;see format-time-string
;;启用时间显示设置，在minibuffer上面的那个杠上
(display-time-mode 1)

;;当寻找一个同名的文件，改变两个buffer的名字,前面加上目录名
(setq uniquify-buffer-name-style 'forward)

;; 鼠标指针规避光标
;; (mouse-avoidance-mode 'animate)

;; 显示列号
(setq column-number-mode t)

;;指针不要闪，我得眼睛花了
;;(blink-cursor-mode nil)

;; 选中区域高亮显示 缺省是打开的
;;(transient-mark-mode t)

;; 高亮显示成对括号，但不来回跳
(show-paren-mode t)

;;是用滚轴鼠标
(mouse-wheel-mode t)

;;去掉烦人的警告铃声
(setq visible-bell t)

;;滚动页面时比较舒服，不要整页的滚动  缺省是打开的
(setq ;;scroll-step 1 ;个不要同时使用
      ;;scroll-margin 3
      scroll-conservatively 10000)

;;去掉Emacs和gnus启动时的引导界面
(setq inhibit-startup-message t)
(setq gnus-inhibit-startup-message t)

;; 标题栏显示buffer完整路径
(setq frame-title-format "%b %f")

;; 不生成临时文件
(setq-default make-backup-files nil)

(setq-default ispell-program-name "aspell.exe")
(setq-default ispell-local-dictionary "american")

;; 设置缺省路径
(setq default-directory "~/")

;; 开启ido模式，方便文件缓冲区查找
(ido-mode t)
(setq ido-ignore-buffers (append
			  '("\*Messages*" "\*Completions*")
			  ido-ignore-buffers))

(windmove-default-keybindings)
;;   "Set up keybindings for 'windmove'.
;; Keybindings are of the form MODIFIER-{left,right,up,down}.
;; Default MODIFIER is 'shift."

(winner-mode 1)
;; Winner mode is a global minor mode that records the changes in the
;; window configuration (i.e. how the frames are partitioned into
;; windows) so that the changes can be "undone" using the command
;; 'winner-undo'.  By default this one is bound to the key sequence
;; ctrl-c left.  If you change your mind (while undoing), you can
;; press ctrl-c right (calling 'winner-redo'). 

;;當使用M-x COMMAND後過1秒鐘顯示該 COMMAND 綁定的鍵
(setq suggest-key-bindings 1)
;;當光標在行尾上下移動的時候，始終保持在行尾。
(setq track-eol t)
;;支持emacs和外部程序的粘貼 `缺省已支持'
;;(setq x-select-enable-clipboard t)

;;自動補全
(setq hippie-expand-try-functions-list
      '(try-expand-line
        try-expand-dabbrev
        try-expand-line-all-buffers
        try-expand-list
        try-expand-list-all-buffers
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name
        try-complete-file-name-partially
        try-complete-lisp-symbol
        try-complete-lisp-symbol-partially
        try-expand-whole-kill))
(global-set-key (kbd "M-?") 'hippie-expand)
;; <M-/>为dabbrev-expand，`系统默认设置'

;; ffap 打开光标处的文件
(global-set-key (kbd "C-c C-f") 'ffap)

;; 从硬盘从新加载文件，比如你可能同时两个编辑器在操作这个文件
;;(global-set-key (kbd "C-c r") 'revert-buffer)
(global-auto-revert-mode 1)		;自动加载更新文件

;; 启用session
;;(desktop-save-mode 1)

;; 为 view-mode 加入 vim 的按键。
;; (add-hook 'view-mode-hook
;; 	  (lambda ()
;; 	    (define-key view-mode-map (kbd "h") 'backward-char)
;; 	    (define-key view-mode-map (kbd "l") 'forward-char)
;; 	    (define-key view-mode-map (kbd "j") 'next-line)
;; 	    (define-key view-mode-map (kbd "k") 'previous-line)))

;; 自动在文件头加入 time-stamp。格式参考 time-stamp 函数的说明。
(add-hook 'before-save-hook 'time-stamp)
(setq time-stamp-active t)
(setq time-stamp-warn-inactive t)
(add-hook 'write-file-hooks 'time-stamp)
(setq time-stamp-format "%U %:y-%02m-%02d %02H:%02M:%02S")

