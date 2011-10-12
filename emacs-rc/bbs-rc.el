;; bbsconnect.el -- bbs connect helper and provide anti-idle function.
;; Copyright (c) 2009 eol@newsmth.org
;;
;; Author: eol@newsmth.org
;; 
;; 方便用ansi-term自动登录bbs，提供防发呆功能（防止被踢掉线）
;; ========================================
;; 用法:
;; (1) 把 bbsconnect.el 放入loadpath目录中(比如site-lisp目录下)
;; (2) 在.emacs中加入 "require 'bbsconnect"
;; (3) 启动emacs后，"M-x bbs-connect <enter>"，输入bbs网址，
;;     用户名，密码。自动登录，并开启防发呆功能。
;;
;; 可设置变量：
;; (1) bbs-avoid-idle-char        防发呆字符，字符串
;;     fterm用的是"\C-@"。缺省值
;; (2) bbs-avoid-idle-interval    防发呆字符发送间隔，秒
;;     一般5分钟没输入就会被服务器踢下线。缺省60秒
;;
;; 可调用命令：
;; (1) bbs-connect   自动登录，提供防发呆功能
;;     interactive调用(如前所述)。
;;     或 (bbs-connect bbs-url userid password)
;;     用户可以如下绑定键来自动登录水木：
;;     (global-set-key (kbd "<f1>")
;;        (lambda ()
;;           (interactive)
;;           (bbs-connect "bbs.newsmth.org"
;;              "用户名" "密码")))
;;     

(defvar bbs-avoid-idle-char "\C-@"
  "防发呆字符。\C-@为刷新页面 \eOA up \eOB down")

(defvar bbs-avoid-idle-interval 300
  "发送发呆字符间隔时间，单位：秒")

;;(setq bbs-avoid-idle-char "\eOB")

(defun bbs-avoid-idle-callback (buffer idle-char)
  (if (and (buffer-name buffer)
	   (get-buffer-process buffer))
      (progn
	(save-excursion
	  (set-buffer buffer)
	  ;;(message "bbs-avoid-idle: send char `%s'" idle-char)
	  (term-send-raw-string idle-char)
	  ))
    (progn
      (cancel-timer timer-event-last) ;杀死自己
      (bbs-avoid-idle-stop buffer)    ;清理局部变量
      (message "bbs-avoid-idle: buffer or process is invalid. stop idle"))
    ))

(defun bbs-avoid-idle-stop (buffer)
  (when (buffer-name buffer)		;判断buffer是否还存在
      (save-excursion
	(set-buffer buffer)
	(when (boundp 'bbs-avoid-idle-timer)
	  (cancel-timer bbs-avoid-idle-timer))
	(kill-local-variable 'bbs-avoid-idle-timer)
	(message "bbs-avoid-idle: stop"))))

(defun bbs-avoid-idle-start  (buffer idle-char idle-interval)
  (save-excursion
    (set-buffer buffer)
    (make-local-variable 'bbs-avoid-idle-timer)
    (setq bbs-avoid-idle-timer
	  (run-at-time t idle-interval
		       'bbs-avoid-idle-callback buffer idle-char))
    (message "bbs-avoid-idle: start")
    (message "bbs-avoid-idle: sec:%ds char:`%s'" idle-interval idle-char)))

(defun bbs-avoid-idle (buffer &optional idle-char idle-interval)
  "自动判断是否开启或关闭"
  ;;(interactive "bwhich term:")
  (setq buffer (get-buffer buffer))
  (or idle-char (setq idle-char bbs-avoid-idle-char))
  (or idle-interval (setq idle-interval bbs-avoid-idle-interval))
  (if (buffer-name buffer)		;判断buffer是否存在
      (if (local-variable-p 'bbs-avoid-idle-timer) ;判断buffer是否开启过timer
	  (bbs-avoid-idle-stop buffer)		   ;开启过就执行停止timer
	(progn
	  (if (get-buffer-process buffer) ;判断buffer是否在bbs
	       (bbs-avoid-idle-start buffer idle-char idle-interval) ;开启timer
	    (message "bbs-avoid-idle: bbs process is invalid"))))
    (message "bbs-avoid-idle: buffer not exist")))

;; 用户使用
(defun bbs-connect (url user psw)
  "bbs 自动连接"
  (interactive "sbbs url: \nsuserid: \nspassword: ")

  (run-hooks 'bbs-hook)
  ;;(my-w32-maximize-frame)			;窗口最大化
  
  (ansi-term "telnet")			;开启ansi-term，采用bash作为shell

  (term-line-mode)
  (term-send-raw-string (concat "open " url "\n"))

  ;; (sit-for 2)  ; 等待2秒
  
  (run-at-time 				;延时2秒登陆
   2 nil
   (lambda (user psw)
     
     (term-send-raw-string (concat user "\n"))
     (term-send-raw-string (concat psw "\n"))

     (term-char-mode)
     ;;(term-pager-enable)

     (bbs-avoid-idle (current-buffer)))
   user psw))


;; ssh登录，windows存在问题，没法用
(defun bbs-connect-ssh (url user psw)
  "bbs 自动连接"
  ;;(interactive "sbbs url: \nsuserid: \nspassword: ")

  (run-hooks 'bbs-hook)
  (my-w32-maximize-frame)
  
  (ansi-term "bash")			;开启ansi-term，采用bash作为shell

  (term-line-mode)
  (term-send-raw-string (format "ssh -tt %s@%s\n" user url))
  (term-send-raw-string (format "yes\n" user url))
  (run-at-time
   2 nil
   (lambda (user psw)
     (term-send-raw-string (concat psw "\n"))
     (term-char-mode)
     ;;(term-pager-enable)
     (bbs-avoid-idle (current-buffer)))
   user psw))

;; ========================================
;; cygwin  主要是为了用ansi-term
;; ========================================
(require 'cygwin-mount)
(setq cygwin-mount-cygwin-bin-directory "c:/bin/cygwin/bin")
(cygwin-mount-activate)

;; ========================================
;; 方便与上bbs
;; ========================================
;; 哈哈，该库是我自己写的，防发呆，自动上bbs，elisp语法真是又臭又长，没办法
(setq bbs-avoid-idle-char "\C-L")	;刷新

(setq bbs-avoid-idle-interval 300) 	;
