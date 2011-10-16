;; ========================================
;; 其它软件包的设置
;; ========================================

;; ========================================
;; color theme
;; ========================================
(require 'color-theme)
(color-theme-initialize)
;;(color-theme-classic)
;;(color-theme-deep-blue2)
;; (color-theme-blue)
(color-theme-dark-laptop)

;; ========================================
;; org-mode支持
;; ========================================
;;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(setq org-agenda-files
      '("~/"))
;; (global-set-key "\C-cl" 'org-store-link)
;; (global-set-key "\C-ca" 'org-agenda)
;; (global-set-key "\C-cb" 'org-iswitchb)
;; (setq org-log-done 'note)

;; ========================================
;; 文件加密支持
;; ========================================
;;; easypg，emacs 自带
(require 'epa-file)
(epa-file-enable)
;; 总是使用对称加密
(setq epa-file-encrypt-to nil)
;; 允许缓存密码，否则编辑时每次保存都要输入密码
(setq epa-file-cache-passphrase-for-symmetric-encryption t)
;; 允许自动保存
(setq epa-file-inhibit-auto-save nil)

;; ========================================
;; 显示行号
;; ========================================
;;(require 'linum) ;;新emacs已经内置该模块，无需require
;;打开行号标记
;; (let ((hooks '(python-mode-hook fortran-mode-hook f90-mode-hook c++-mode-hook c-mode-hook emacs-lisp-mode-hook)))
;;   (dolist (hook hooks)
;;     (add-hook hook 'linum-mode)))

;; ========================================
;; 标签栏
;; ========================================
                                        ;(require 'tabbar)
                                        ;(tabbar-mode t)

;; ========================================
;; win32下全屏显示
;; ========================================
;; (require 'darkroom-mode)

;; ;; ========================================
;; ;; EMMS
;; ;; ========================================
;; ;; 仅针对当前播放列表
;; (defun my-emms ()
;;   ;;创建播放器
;;   (interactive)
;;   (unless (bound-and-true-p my-emms)
;;     (setq my-emms t)

;;     (require 'emms-setup)
;;     (require 'emms-history)
;;     ;;(emms-standard)
;;     ;;(emms-devel)
;;     (emms-all)
;;     ;; 设置初始变量
;;     (setq
;;      ;; 添加音乐文件默认的目录
;;      emms-source-file-default-directory "d:/entertainment/music/"
;;      emms-repeat-playlist t
;;      emms-playlist-mode-popup-enabled t
;;      ;; 播放器优先顺序
;;      emms-player-list '(emms-player-mpg321
;;                      emms-player-ogg123)
;;      ;; 调节音量的声道
;;      ;; emms-volume-amixer-control "PCM"
;;      emms-player-mpg321-command-name "mpg123"
;;      emms-player-mplayer-parameters '("-slave"))
;;     ;; 开启状态栏显示
;;     (emms-mode-line 1)
;;     (emms-playing-time nil)
;;     (emms-history-load)                      ;加载上次的播放列表
;;     ;; (emms-add-directory-tree emms-source-file-default-directory)
;;     )

;;   ;; 打开播放列表，锁定窗口. 退出窗口`q'.
;;   (emms-playlist-mode-go-popup)
;;   (set-window-dedicated-p (selected-window) t))

;; ;; 第一次执行负责开启播放器，以后各次执行仅打开当前播放列表
;; (global-set-key [(f5)] 'my-emms)

;; ========================================
;; w3m
;; ========================================
(defun my-w3m-mode ()
  (interactive)
  (unless (bound-and-true-p my-w3m-mode)
    (setq my-w3m-mode t)

    (require 'w3m-load)
    (setq w3m-command-arguments '("-cookie" "-F"))
    ;;(setq w3m-tab-width 4)
    (setq w3m-use-cookies t)
    )
  (command-execute 'w3m)
  )

(setq doc-view-ghostscript-program (executable-find "gswin32c"))

;; ;; ========================================
;; ;; jabber
;; ;; ========================================
;; (defun my-jabber-connect ()
;;   (interactive)
;;   (unless (bound-and-true-p my-jabber-connect)
;;     (setq my-jabber-connect t)

;;     (require 'jabber-autoloads)
;;     (setq jabber-account-list
;;        '(
;;          ("cppython@gmail.com"
;;           ;;   (:password . nil) or (:password . "your-pass")
;;           (:password . "woshizhu")
;;           (:network-server . "talk.google.com")
;;           (:port . 443)
;;           (:connection-type . ssl))
;;          ("jianwn@gmail.com"
;;           (:password . "woshizhu")
;;           (:network-server . "talk.google.com")
;;           (:port . 443)
;;           (:connection-type . ssl)
;;           (:disabled . nil))
;;          ))
;;     (setq jabber-history-enabled t)
;;     ;;(setq jabber-activity-count-in-title t)
;;     (setq jabber-auto-reconnect t)
;;     ;;(remove-hook 'jabber-post-connect-hooks 'jabber-send-current-presence)
;;     (setq jabber-default-show "xa")
;;     (setq jabber-default-status "")
;;     )

;;   (command-execute 'jabber-connect)

;;   )
