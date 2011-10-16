;; 设置load-path路径
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/emacs-ext/site-lisp")
	   (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))

(setq default-font-spec '(
			  (:font-name-eng . "Consolas")
			  (:font-name-cht . "微软雅黑")
			  (:font-size-eng . 14)
			  (:font-size-cht . 14)
			  (:font-size-cht-eng-fun . (lambda (cht-size) (- cht-size 0)))))

;; 设置上bbs时的字体
;; (add-hook 'bbs-hook (lambda ()
;; 		      ;; 调整当前frame的字体和行距
;; 		      (my-set-frame-fontsize 19)
;; 		      (my-set-frame-line-spacing 0)
;; 		      ))

(defvar emacs-rc-path "~/emacs-rc/")

(setq custom-file "~/emacs-rc/my-custom.el")

(dolist (rc-file '(
		   "util.el"
		   "my-custom.el"
		   "basic.el"
		   "font-rc.el"
		   "library.el"
		   "bbs-rc.el"
		   ;; "tex-rc.el"
		   "python-rc.el"
		   ;; "cedet-ecb.el"
		   "programming-config.el"
		   ))
  (load-file (concat
	      (file-name-as-directory emacs-rc-path)
	      rc-file)))

(global-set-key (kbd "<f1>")
		'(lambda ()
		   (interactive)
		   (bbs-connect "bbs.newsmth.org" "nmu" "11223")))

(global-set-key (kbd "<f2>")
		'(lambda ()
		   (interactive)
		   (bbs-connect "mitbbs.com" "lift" "112233")))
;; 打开rope
;; (my-python-mode)
;; (autoload 'company-mode "company" nil t)
;; (company-mode)
;; ;; 全局绑定M-p, M-n为上一个/下一个补全项
;; (global-set-key "\M-n" 'company-select-next)
;; (global-set-key "\M-p" 'company-select-previous)
;; ;; 关闭补全菜单的自动触发，这样就不再自动弹出了，必须得M-p或者M-n才弹出来
;; (setq company-idle-delay nil)
;; (global-set-key "\M-/" 'company-complete)

;; (py-shell)
;; (delete-other-windows)

;; 启动emacs server
;; 时间较慢，放在最后
;; 在新窗口中打开新文件
(server-force-delete) ;;如果已经开启，先干掉
(server-start)
;; 在老窗口中打开新文件
;; (require 'server)
;; (unless (server-running-p)
;;   (server-start))


(put 'narrow-to-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'upcase-region 'disabled nil)


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")))