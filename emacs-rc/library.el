;; ========================================
;; ���������������
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
;; org-mode֧��
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
;; �ļ�����֧��
;; ========================================
;;; easypg��emacs �Դ�
(require 'epa-file)
(epa-file-enable)
;; ����ʹ�öԳƼ���
(setq epa-file-encrypt-to nil)
;; ���������룬����༭ʱÿ�α��涼Ҫ��������
(setq epa-file-cache-passphrase-for-symmetric-encryption t)
;; �����Զ�����
(setq epa-file-inhibit-auto-save nil)

;; ========================================
;; ��ʾ�к�
;; ========================================
;;(require 'linum) ;;��emacs�Ѿ����ø�ģ�飬����require
;;���кű��
;; (let ((hooks '(python-mode-hook fortran-mode-hook f90-mode-hook c++-mode-hook c-mode-hook emacs-lisp-mode-hook)))
;;   (dolist (hook hooks)
;;     (add-hook hook 'linum-mode)))

;; ========================================
;; ��ǩ��
;; ========================================
                                        ;(require 'tabbar)
                                        ;(tabbar-mode t)

;; ========================================
;; win32��ȫ����ʾ
;; ========================================
;; (require 'darkroom-mode)

;; ;; ========================================
;; ;; EMMS
;; ;; ========================================
;; ;; ����Ե�ǰ�����б�
;; (defun my-emms ()
;;   ;;����������
;;   (interactive)
;;   (unless (bound-and-true-p my-emms)
;;     (setq my-emms t)

;;     (require 'emms-setup)
;;     (require 'emms-history)
;;     ;;(emms-standard)
;;     ;;(emms-devel)
;;     (emms-all)
;;     ;; ���ó�ʼ����
;;     (setq
;;      ;; ��������ļ�Ĭ�ϵ�Ŀ¼
;;      emms-source-file-default-directory "d:/entertainment/music/"
;;      emms-repeat-playlist t
;;      emms-playlist-mode-popup-enabled t
;;      ;; ����������˳��
;;      emms-player-list '(emms-player-mpg321
;;                      emms-player-ogg123)
;;      ;; ��������������
;;      ;; emms-volume-amixer-control "PCM"
;;      emms-player-mpg321-command-name "mpg123"
;;      emms-player-mplayer-parameters '("-slave"))
;;     ;; ����״̬����ʾ
;;     (emms-mode-line 1)
;;     (emms-playing-time nil)
;;     (emms-history-load)                      ;�����ϴεĲ����б�
;;     ;; (emms-add-directory-tree emms-source-file-default-directory)
;;     )

;;   ;; �򿪲����б���������. �˳�����`q'.
;;   (emms-playlist-mode-go-popup)
;;   (set-window-dedicated-p (selected-window) t))

;; ;; ��һ��ִ�и��������������Ժ����ִ�н��򿪵�ǰ�����б�
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
