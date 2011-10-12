;;Time-stamp: < 2010-10-20 19:28:27>

;;�������
;; �����������ڴ�С
(dolist (key '((height . 24) 		;ע�ⵥλ�ǡ���
	       (width . 80)		;ע�ⵥλ�ǡ���
	       ;;(menu-bar-lines . 1)
	       ;;(tool-bar-lines . 0))
	       ))
  (setq default-frame-alist (assq-delete-all (car key) default-frame-alist)) ;�Ȱ��ظ��ļ��ɵ�
  (push key default-frame-alist))

;; ��Ҫ������
(tool-bar-mode 0)
;; ��Ҫ�˵�
;;(menu-bar-mode nil)
;; ��Ҫ������
(scroll-bar-mode nil)
;;�޸������ı����о�,3������
;;(setq-default line-spacing 1)

;;ʱ����ʾ����
;;ʱ��ʹ��24Сʱ��
(setq display-time-24hr-format t)
;;ʱ����ʾ�������ں;���ʱ��
;; (setq display-time-day-and-date t)
;; ;;ʱ�����Ա������ʼ�����
;; (setq display-time-use-mail-icon t)
;;ʱ��ı仯Ƶ��
(setq display-time-interval 10)
;;��ʾʱ��ĸ�ʽ
;;(setq display-time-format "%a %b %d %H:%M") ;see format-time-string
;;����ʱ����ʾ���ã���minibuffer������Ǹ�����
(display-time-mode 1)

;;��Ѱ��һ��ͬ�����ļ����ı�����buffer������,ǰ�����Ŀ¼��
(setq uniquify-buffer-name-style 'forward)

;; ���ָ���ܹ��
;; (mouse-avoidance-mode 'animate)

;; ��ʾ�к�
(setq column-number-mode t)

;;ָ�벻Ҫ�����ҵ��۾�����
;;(blink-cursor-mode nil)

;; ѡ�����������ʾ ȱʡ�Ǵ򿪵�
;;(transient-mark-mode t)

;; ������ʾ�ɶ����ţ�����������
(show-paren-mode t)

;;���ù������
(mouse-wheel-mode t)

;;ȥ�����˵ľ�������
(setq visible-bell t)

;;����ҳ��ʱ�Ƚ��������Ҫ��ҳ�Ĺ���  ȱʡ�Ǵ򿪵�
(setq ;;scroll-step 1 ;����Ҫͬʱʹ��
      ;;scroll-margin 3
      scroll-conservatively 10000)

;;ȥ��Emacs��gnus����ʱ����������
(setq inhibit-startup-message t)
(setq gnus-inhibit-startup-message t)

;; ��������ʾbuffer����·��
(setq frame-title-format "%b %f")

;; ��������ʱ�ļ�
(setq-default make-backup-files nil)

(setq-default ispell-program-name "aspell.exe")
(setq-default ispell-local-dictionary "american")

;; ����ȱʡ·��
(setq default-directory "~/")

;; ����idoģʽ�������ļ�����������
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

;;��ʹ��M-x COMMAND���^1����@ʾԓ COMMAND �������I
(setq suggest-key-bindings 1)
;;���������β�����Ƅӵĕr��ʼ�K��������β��
(setq track-eol t)
;;֧��emacs���ⲿ�����ճ�N `ȱʡ��֧��'
;;(setq x-select-enable-clipboard t)

;;�Ԅ��aȫ
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
;; <M-/>Ϊdabbrev-expand��`ϵͳĬ������'

;; ffap �򿪹�괦���ļ�
(global-set-key (kbd "C-c C-f") 'ffap)

;; ��Ӳ�̴��¼����ļ������������ͬʱ�����༭���ڲ�������ļ�
;;(global-set-key (kbd "C-c r") 'revert-buffer)
(global-auto-revert-mode 1)		;�Զ����ظ����ļ�

;; ����session
;;(desktop-save-mode 1)

;; Ϊ view-mode ���� vim �İ�����
;; (add-hook 'view-mode-hook
;; 	  (lambda ()
;; 	    (define-key view-mode-map (kbd "h") 'backward-char)
;; 	    (define-key view-mode-map (kbd "l") 'forward-char)
;; 	    (define-key view-mode-map (kbd "j") 'next-line)
;; 	    (define-key view-mode-map (kbd "k") 'previous-line)))

;; �Զ����ļ�ͷ���� time-stamp����ʽ�ο� time-stamp ������˵����
(add-hook 'before-save-hook 'time-stamp)
(setq time-stamp-active t)
(setq time-stamp-warn-inactive t)
(add-hook 'write-file-hooks 'time-stamp)
(setq time-stamp-format "%U %:y-%02m-%02d %02H:%02M:%02S")

