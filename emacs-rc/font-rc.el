

;; 字体设置
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

;; 设置fontset的属性.
;; 设置各个字符集对应的字体
(defun set-fontset-prop (fontset font-eng-spec font-cht-spec)

  ;; 设置各个字符集对应的字体
  (set-fontset-font fontset nil font-cht-spec nil 'prepend) ;default
  (set-fontset-font fontset 'ascii font-eng-spec nil 'prepend) ;important
  (set-fontset-font fontset 'latin font-eng-spec nil 'prepend)
  (set-fontset-font fontset 'kana font-cht-spec nil 'prepend)
  (set-fontset-font fontset 'han font-cht-spec nil 'prepend) ;important
  (set-fontset-font fontset 'cjk-misc font-cht-spec nil 'prepend)
  (set-fontset-font fontset 'symbol font-cht-spec nil 'prepend))

;; 
;; 字体设置方法1
;; 
;; 设置各预定义字体. 当前窗口使用的是"fontset-default"
(defun set-font-method1 (&optional font-eng-spec font-cht-spec)
  ;; 默认使用缺省字体
  (or font-eng-spec (setq font-eng-spec default-font-eng-spec))
  (or font-cht-spec (setq font-cht-spec default-font-cht-spec))

  ;; 字体设置方法1
  (dolist (fontset '("fontset-default" "fontset-startup" "fontset-standard"))
    (set-fontset-prop fontset font-eng-spec font-cht-spec))
  ;; (push '(font . "fontset-default") default-frame-alist) ;fontset-default不能设置！
  )

(set-font-method1)

;; 
;; 字体设置方法2
;; 

;; 创建我自己的字体集"fontset-my"，全局唯一，以后更改字体都是对该字体集作操作
;; 每个窗口均使用该字符集
(create-fontset-from-fontset-spec "-*-Courier new-normal-r-*-*-10-*-*-*-c-*-fontset-mydefault")
(defvar my-fontset-default "fontset-mydefault" "我自己创建的字体")
;; 修改fontset属性，后面不再修改fontset
(set-fontset-prop my-fontset-default default-font-eng-spec default-font-cht-spec)
;; 所有的frame均使用该字体，后面只要更改fontset-my，就会对所有窗口有效
(setq default-frame-alist (assq-delete-all 'font default-frame-alist)) ;;先把重复的键干掉
(push `(font . ,my-fontset-default) default-frame-alist)

;; 每个frame使用各自的字体，互不影响
(defun my-set-frame-fontsize (&optional fontsize)
  (interactive "nfont-size: ")
  ;; 默认使用缺省字体
  (if (or (not fontsize) (< fontsize 8))
      (progn
	;; 恢复缺省字体
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

;; 字体设置方法3
;; (defun my-set-fontset (charset-list my-font-spec &optional frame)
;;   (let ((frame-font (frame-parameter frame 'font)))
;;     (dolist (charset charset-list)
;;       (set-fontset-font frame-font charset my-font-spec))))
;; (defun my-set-font ()
;;   (set-frame-font font-eng-spec)
;;   (my-set-fontset '(han cjk-misc symbol bopomofo chinese-gbk)
;; 		  font-cht-spec))
;; (my-set-font)
;; ;; 使得创建新的frame时【C-x 5 2】设置正常字体
;; (add-hook 'after-make-frame-functions
;; 	  (lambda (frame)
;; 	    (select-frame frame)
;; 	    (my-set-font)))
