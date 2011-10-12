;; bbsconnect.el -- bbs connect helper and provide anti-idle function.
;; Copyright (c) 2009 eol@newsmth.org
;;
;; Author: eol@newsmth.org
;; 
;; ������ansi-term�Զ���¼bbs���ṩ���������ܣ���ֹ���ߵ��ߣ�
;; ========================================
;; �÷�:
;; (1) �� bbsconnect.el ����loadpathĿ¼��(����site-lispĿ¼��)
;; (2) ��.emacs�м��� "require 'bbsconnect"
;; (3) ����emacs��"M-x bbs-connect <enter>"������bbs��ַ��
;;     �û��������롣�Զ���¼�����������������ܡ�
;;
;; �����ñ�����
;; (1) bbs-avoid-idle-char        �������ַ����ַ���
;;     fterm�õ���"\C-@"��ȱʡֵ
;; (2) bbs-avoid-idle-interval    �������ַ����ͼ������
;;     һ��5����û����ͻᱻ�����������ߡ�ȱʡ60��
;;
;; �ɵ������
;; (1) bbs-connect   �Զ���¼���ṩ����������
;;     interactive����(��ǰ����)��
;;     �� (bbs-connect bbs-url userid password)
;;     �û��������°󶨼����Զ���¼ˮľ��
;;     (global-set-key (kbd "<f1>")
;;        (lambda ()
;;           (interactive)
;;           (bbs-connect "bbs.newsmth.org"
;;              "�û���" "����")))
;;     

(defvar bbs-avoid-idle-char "\C-@"
  "�������ַ���\C-@Ϊˢ��ҳ�� \eOA up \eOB down")

(defvar bbs-avoid-idle-interval 300
  "���ͷ����ַ����ʱ�䣬��λ����")

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
      (cancel-timer timer-event-last) ;ɱ���Լ�
      (bbs-avoid-idle-stop buffer)    ;����ֲ�����
      (message "bbs-avoid-idle: buffer or process is invalid. stop idle"))
    ))

(defun bbs-avoid-idle-stop (buffer)
  (when (buffer-name buffer)		;�ж�buffer�Ƿ񻹴���
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
  "�Զ��ж��Ƿ�����ر�"
  ;;(interactive "bwhich term:")
  (setq buffer (get-buffer buffer))
  (or idle-char (setq idle-char bbs-avoid-idle-char))
  (or idle-interval (setq idle-interval bbs-avoid-idle-interval))
  (if (buffer-name buffer)		;�ж�buffer�Ƿ����
      (if (local-variable-p 'bbs-avoid-idle-timer) ;�ж�buffer�Ƿ�����timer
	  (bbs-avoid-idle-stop buffer)		   ;��������ִ��ֹͣtimer
	(progn
	  (if (get-buffer-process buffer) ;�ж�buffer�Ƿ���bbs
	       (bbs-avoid-idle-start buffer idle-char idle-interval) ;����timer
	    (message "bbs-avoid-idle: bbs process is invalid"))))
    (message "bbs-avoid-idle: buffer not exist")))

;; �û�ʹ��
(defun bbs-connect (url user psw)
  "bbs �Զ�����"
  (interactive "sbbs url: \nsuserid: \nspassword: ")

  (run-hooks 'bbs-hook)
  ;;(my-w32-maximize-frame)			;�������
  
  (ansi-term "telnet")			;����ansi-term������bash��Ϊshell

  (term-line-mode)
  (term-send-raw-string (concat "open " url "\n"))

  ;; (sit-for 2)  ; �ȴ�2��
  
  (run-at-time 				;��ʱ2���½
   2 nil
   (lambda (user psw)
     
     (term-send-raw-string (concat user "\n"))
     (term-send-raw-string (concat psw "\n"))

     (term-char-mode)
     ;;(term-pager-enable)

     (bbs-avoid-idle (current-buffer)))
   user psw))


;; ssh��¼��windows�������⣬û����
(defun bbs-connect-ssh (url user psw)
  "bbs �Զ�����"
  ;;(interactive "sbbs url: \nsuserid: \nspassword: ")

  (run-hooks 'bbs-hook)
  (my-w32-maximize-frame)
  
  (ansi-term "bash")			;����ansi-term������bash��Ϊshell

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
;; cygwin  ��Ҫ��Ϊ����ansi-term
;; ========================================
(require 'cygwin-mount)
(setq cygwin-mount-cygwin-bin-directory "c:/bin/cygwin/bin")
(cygwin-mount-activate)

;; ========================================
;; ��������bbs
;; ========================================
;; �������ÿ������Լ�д�ģ����������Զ���bbs��elisp�﷨�����ֳ��ֳ���û�취
(setq bbs-avoid-idle-char "\C-L")	;ˢ��

(setq bbs-avoid-idle-interval 300) 	;
