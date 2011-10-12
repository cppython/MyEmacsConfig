

;; ��������
(defvar default-font-spec '(
			    (:font-name-eng . "Monaco")
			    (:font-name-cht . "YaHei Consolas Hybrid")
			    (:font-size-eng . 16)
			    (:font-size-cht . 18)
			    (:font-size-cht-eng-fun . (lambda (cht-size) (- cht-size 2)))))

(defmacro get-alist-value (key my-alist)
  `(cdr (assq ',key ,my-alist)))

(defun get-default-font-spec (&optional cht-font-size)
  (let ((eng-size (get-alist-value :font-size-eng default-font-spec))
	(cht-size (get-alist-value :font-size-cht default-font-spec))
	(eng-name (get-alist-value :font-name-eng default-font-spec))
	(cht-name (get-alist-value :font-name-cht default-font-spec))
	(size-fun (get-alist-value :font-size-cht-eng-fun default-font-spec))
	)
    (when (and cht-font-size (> cht-font-size 8))
      (setq cht-size cht-font-size)
      (setq eng-size (funcall size-fun cht-font-size))
      )
    (cons (format (concat eng-name ":pixelsize=%d") eng-size)
	  (format (concat cht-name ":pixelsize=%d") cht-size))))

(defvar default-font-eng-spec (car (get-default-font-spec)))
(defvar default-font-cht-spec (cdr (get-default-font-spec)))

;; (setq face-font-family-alternatives '(("Monaco" "YaHei Consolas Hybrid")))
;; (setq w32-standard-fontset-spec "-*-Monaco-normal-r-*-*-16-*-*-*-c-*-fontset-standard")

;; ����fontset������.
;; ���ø����ַ�����Ӧ������
(defun set-fontset-prop (fontset font-eng-spec font-cht-spec)

  ;; ���ø����ַ�����Ӧ������
  (set-fontset-font fontset nil font-cht-spec nil 'prepend) ;default
  (set-fontset-font fontset 'ascii font-eng-spec nil 'prepend) ;important
  (set-fontset-font fontset 'latin font-eng-spec nil 'prepend)
  (set-fontset-font fontset 'kana font-cht-spec nil 'prepend)
  (set-fontset-font fontset 'han font-cht-spec nil 'prepend) ;important
  (set-fontset-font fontset 'cjk-misc font-cht-spec nil 'prepend)
  (set-fontset-font fontset 'symbol font-cht-spec nil 'prepend))

;; 
;; �������÷���1
;; 
;; ���ø�Ԥ��������. ��ǰ����ʹ�õ���"fontset-default"
(defun set-font-method1 (&optional font-eng-spec font-cht-spec)
  ;; Ĭ��ʹ��ȱʡ����
  (or font-eng-spec (setq font-eng-spec default-font-eng-spec))
  (or font-cht-spec (setq font-cht-spec default-font-cht-spec))

  ;; �������÷���1
  (dolist (fontset '("fontset-default" "fontset-startup" "fontset-standard"))
    (set-fontset-prop fontset font-eng-spec font-cht-spec))
  ;; (push '(font . "fontset-default") default-frame-alist) ;fontset-default�������ã�
  )

(set-font-method1)

;; 
;; �������÷���2
;; 

;; �������Լ������弯"fontset-my"��ȫ��Ψһ���Ժ�������嶼�ǶԸ����弯������
;; ÿ�����ھ�ʹ�ø��ַ���
(create-fontset-from-fontset-spec "-*-Courier new-normal-r-*-*-10-*-*-*-c-*-fontset-mydefault")
(defvar my-fontset-default "fontset-mydefault" "���Լ�����������")
;; �޸�fontset���ԣ����治���޸�fontset
(set-fontset-prop my-fontset-default default-font-eng-spec default-font-cht-spec)
;; ���е�frame��ʹ�ø����壬����ֻҪ����fontset-my���ͻ�����д�����Ч
(setq default-frame-alist (assq-delete-all 'font default-frame-alist)) ;;�Ȱ��ظ��ļ��ɵ�
(push `(font . ,my-fontset-default) default-frame-alist)

;; ÿ��frameʹ�ø��Ե����壬����Ӱ��
(defun my-set-frame-fontsize (&optional fontsize)
  (interactive "nfont-size: ")
  ;; Ĭ��ʹ��ȱʡ����
  (if (or (not fontsize) (< fontsize 8))
      (progn
	;; �ָ�ȱʡ����
	(set-frame-font my-fontset-default))
    (progn
      (unless (frame-parameter nil 'my-fontset-name)
	(let ((id (frame-parameter nil 'window-id)))
	  (create-fontset-from-fontset-spec
	   (concat "-*-Courier new-normal-r-*-*-16-*-*-*-c-*-fontset-"
		   id))
	  (set-frame-parameter nil
			       'my-fontset-name (concat "fontset-" id))
	))
      (let* ((font-spec (get-default-font-spec fontsize))
	     (eng-font (car font-spec))
	     (cht-font (cdr font-spec))
	     (fontset-name (frame-parameter nil 'my-fontset-name))
	    )
	(set-fontset-prop fontset-name eng-font cht-font)
	(set-frame-font fontset-name)))))

(defun my-set-frame-line-spacing (value)
  (interactive "nline-spacing: ")
  (when (< value 0) (setq value 0))
  (set-frame-parameter nil 'line-spacing value))

;; �������÷���3
;; (defun my-set-fontset (charset-list my-font-spec &optional frame)
;;   (let ((frame-font (frame-parameter frame 'font)))
;;     (dolist (charset charset-list)
;;       (set-fontset-font frame-font charset my-font-spec))))
;; (defun my-set-font ()
;;   (set-frame-font font-eng-spec)
;;   (my-set-fontset '(han cjk-misc symbol bopomofo chinese-gbk)
;; 		  font-cht-spec))
;; (my-set-font)
;; ;; ʹ�ô����µ�frameʱ��C-x 5 2��������������
;; (add-hook 'after-make-frame-functions
;; 	  (lambda (frame)
;; 	    (select-frame frame)
;; 	    (my-set-font)))
