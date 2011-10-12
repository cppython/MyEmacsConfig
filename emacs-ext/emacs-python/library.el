;; ========================================
;; ���������������
;; ========================================

;; ���������·��
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/emacs-ext/site-lisp")
	   (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))

;; ========================================
;; color theme
;; ========================================
(require 'color-theme)
(color-theme-initialize)
;;(color-theme-classic)
;;(color-theme-deep-blue2)
(color-theme-blue)

;; ========================================
;; org-mode֧��
;; ========================================
;;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(setq org-agenda-files
      '("~/"))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done 'note)

;; ========================================
;; python-mode֧��
;; ========================================
(push '("\\.py$" . python-mode) auto-mode-alist)
(push '("python" . python-mode) interpreter-mode-alist)
(autoload 'python-mode "python-mode" "Python editing mode." t)
;; (global-font-lock-mode t)
;; (setq font-lock-maximum-decoration t)


;; ========================================
;; ipython֧��
;; ========================================
(require 'ipython)
;(setq py-python-command-args '("-pylab" "-colors" "LightBG"))

;; ========================================
;; Auctex����
;; ========================================

(require 'tex-site)
(require 'tex-mik)

(setq reftex-plug-into-AUCTeX t)
(setq bib-cite-use-reftex-view-crossref t)
(setq reftex-texpath-environment-variables '("."))
(setq reftex-bibpath-environment-variables '("."))
(setq TeX-source-specials-mode t) ; ��winedtһ������Ҫ��dvi�мӵ��ϲ���֧��Yap�ķ�������
;; (setq outline-minor-mode-prefix "\C-c@")
(setq TeX-electric-sub-and-superscript t)
(setq TeX-auto-save t)
(setq Tex-parse-self t)
;;(setq-default TeX-master nil)
;;(setq TeX-electric-escape t)

(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (reftex-mode)
	    (turn-on-reftex)
	    (outline-minor-mode)
	    ;;(flyspell-mode)
	    (LaTeX-math-mode)
	    (turn-on-auto-fill)
	    ;;(tool-bar-mode t)
	    (TeX-fold-mode)
	    (define-key LaTeX-mode-map '[C-tab] 'TeX-complete-symbol)))

;; ========================================
;; cdlatex����
;; ========================================

(autoload 'cdlatex-mode "cdlatex" "CDLaTeX Mode" t)
(autoload 'turn-on-cdlatex "cdlatex" "CDLaTeX Mode" nil)
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-cdlatex)   ; with Emacs latex mode

;; ========================================
;; CEDET
;; ========================================

;;(setq semantic-load-turn-everything-on t)

;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
(load-file "~/emacs-ext/cedet/common/cedet.el")

;; Enable prototype help and smart completion 
(semantic-load-enable-excessive-code-helpers)
;;(semantic-load-enable-semantic-debugging-helpers)

(setq senator-minor-mode-name "SN")
(setq semantic-imenu-auto-rebuild-directory-indexes nil)
(global-srecode-minor-mode 1)
(global-semantic-mru-bookmark-mode 1)

(global-semantic-folding-mode 1) 	;�򿪴����۵����ܣ��������ʾ������ʾ

(require 'semantic-decorate-include)

;; gcc setup
(require 'semantic-gcc)

;; smart complitions
(require 'semantic-ia)

;; ������������
(let ((modes
       '(python-mode
	 c-mode c++-mode fortran-mode
	 emacs-lisp-mode lisp-mode)))
  (dolist (mode modes)
    (setq-mode-local mode semanticdb-find-default-throttle
		     '(project unloaded system recursive))))

;; �Զ�ѡ����ȫ�����ػ��Ǿֲ�����
(defun my-semantic-tag-folding-fold ()
  "�۵����룬�����������ж���ȫ�ֻ��Ǵ����"
  (interactive)
  (if (semantic-overlay-p (semantic-tag-folding-get-overlay))
      (semantic-tag-folding-fold-block)
    ;; �㲻��ΪΪʲô���ܰ�(semantic-tag-folding-get-overlay)��ֵ��������
    ;; ���ý����Ȼ��һ������֪��������ôд���������
    ;;(semantic-tag-folding-set-overlay-visibility ov nil)
    (semantic-tag-folding-fold-all)
      ))

;; �Զ�ѡ����ȫ����ʾ���Ǿֲ���ʾ
(defun my-semantic-tag-folding-show ()
  "�۵����룬�����������ж���ȫ�ֻ��Ǵ����"
  (interactive)
  (if (semantic-overlay-p (semantic-tag-folding-get-overlay))
      (semantic-tag-folding-show-block)
    ;;(semantic-tag-folding-set-overlay-visibility ov t)
    (semantic-tag-folding-show-all)
    ))

(defun my-cedet-smart-hook ()
  ;; completion inline (underlining the target symbol) and allows TAB to be used for completion purposes.
  ;; �����ȵ��ø���������»��ߺ�TAB������ʹ�ã�������Ӧ����ʹ�����ձ��
  (local-set-key [(control tab)] 'semantic-complete-analyze-inline)

  ;; ��ȫ�������֣��ڶ���ִ��ʱ�ڻ�������ʾ���п��ܵĲ�ȫ
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-cm" 'semantic-ia-complete-symbol-menu) ;����ͬ�ϣ���ʾ��ȫ�˵�,���Ӧ��������õ�

  ;; (local-set-key "\C-ct" 'semantic-ia-complete-tip) ; displays list of possible completions as tooltip

  ;; for simple completion
  (local-set-key "\C-c\t" 'senator-complete-symbol)
  (local-set-key "\C-c " 'senator-completion-menu-popup) ;;graphical menu of senator-complete-symbol

  ;; ��ת
  (local-set-key "\C-c=" 'semantic-decoration-include-visit) ;Visit the included file at point.
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)	     ;�������semantic-complete-jump<C-c , J>����
  ;; 
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)

  (local-set-key (kbd "C--") 'my-semantic-tag-folding-fold) ;������ block �� all
  (local-set-key (kbd "C-+") 'my-semantic-tag-folding-show)
  (local-set-key (kbd "C-c -") 'semantic-tag-folding-fold-children)
  (local-set-key (kbd "C-c +") 'semantic-tag-folding-show-children)

  ;; (local-set-key (kbd "C-c - b") 'semantic-tag-folding-fold-block)
  ;; (local-set-key (kbd "C-c + b") 'semantic-tag-folding-show-block)
  ;; (local-set-key (kbd "C-c - a") 'semantic-tag-folding-fold-all)
  ;; (local-set-key (kbd "C-c + a") 'semantic-tag-folding-show-all)
  ;; (local-set-key (kbd "C-c - c") 'semantic-tag-folding-fold-children)
  ;; (local-set-key (kbd "C-c + c") 'semantic-tag-folding-show-children)
  )

(let ((hooks
       '(python-mode-hook
	 c-mode-common-hook fortran-mode-hook c++-mode-hook c-mode-hook
	 emacs-lisp-mode-hook lisp-mode-hook)))
  (dolist (hook hooks)
    (add-hook hook 'my-cedet-smart-hook)))

(require 'eassist)
(defun my-c-mode-cedet-hook ()
  ;; ��Ա��ʾ  ����ǰ��ģ����û�б�Ҫ������ᵼ����ע�͵ȵط�Ҳ����ֲ���Ҫ�Ĳ�ȫ
  ;; (local-set-key "." 'semantic-complete-self-insert)
  ;; (local-set-key ">" 'semantic-complete-self-insert)
  (local-set-key "\C-ct" 'eassist-switch-h-cpp)
  (local-set-key "\C-xt" 'eassist-switch-h-cpp)
  (local-set-key "\C-ce" 'eassist-list-methods)
  (local-set-key "\C-c\C-r" 'semantic-symref)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

;; hooks, specific for semantic
(defun my-semantic-hook ()
;; (semantic-tag-folding-mode 1)
  (imenu-add-to-menubar "TAGS")
 )
(add-hook 'semantic-init-hooks 'my-semantic-hook)


;; gnu global support
(require 'semanticdb-global)
;; ʹ�����е�etag
;; (let ((modes
;;        '(python-mode
;; 	 c-mode c++-mode fortran-mode
;; 	 emacs-lisp-mode lisp-mode)))
;;   (dolist (mode modes)
;;     (semanticdb-enable-gnu-global-databases mode)))

;; ��� include ·��
(dolist (path load-path)
  (semantic-add-system-include path 'emacs-lisp-mode))

(dolist (path '("C:/bin/MinGW/include"
		       "C:/bin/MinGW/include/c++/3.4.5"
		       "C:/bin/MinGW/include/sys"
		       "C:/bin/MinGW/include/GL"
		       "C:/bin/MinGW/include/ddk"))
  ;;  (semantic-add-system-include path 'c-mode)
  (semantic-add-system-include path 'c++-mode)
  )

;;; ede customization
(require 'semantic-lex-spp)
(global-ede-mode t) ;; Enable EDE (Project Management) features

(custom-set-variables
 '(semantic-idle-scheduler-idle-time 2)
 '(semantic-self-insert-show-completion-function (lambda nil (semantic-ia-complete-symbol-menu (point))))
 '(global-semantic-tag-folding-mode t nil (semantic-util-modes))
 )

;; how to make a project definition
;; (setq cpp-tests-project
;;       (ede-cpp-root-project "my-cpp-project"
;; 			    :name "my-cpp-project"
;; 			    :file "f:/source-code/cpp-project/readme.txt"
;; 			    :include-path '()
;; 			    :system-include-path '("C:/bin/MinGW/include"
;; 						   "C:/bin/MinGW/include/c++/3.4.5"
;; 						   "C:/bin/MinGW/include/sys"
;; 						   "C:/bin/MinGW/include/GL"
;; 						   "C:/bin/MinGW/include/ddk")
;; 			    :local-variables 
;; 			    '(
;; 			      (compile-command . "cd f:/source-code/cpp-project; make -all")
;; 			      )
;; 			    ))

;; (setq python-tests-project
;;       (ede-cpp-root-project "my-python-project"
;; 			    :name "my-python-project"
;; 			    :file "f:/source-code/python-project/readme.txt"
;; 			    :include-path '()
;; 			    :system-include-path '("C:/bin/MinGW/include"
;; 						   "C:/bin/MinGW/include/c++/3.4.5"
;; 						   "C:/bin/MinGW/include/sys"
;; 						   "C:/bin/MinGW/include/GL"
;; 						   "C:/bin/MinGW/include/ddk")
;; 			    :local-variables 
;; 			    '(
;; 			      (compile-command . "cd f:/source-code/cpp-project; make -all")
;; 			      )
;; 			    ))

;; my functions for EDE
(defun my-ede-get-local-var (fname var)
  "fetch given variable var from :local-variables of project of file fname"
  (let* ((current-dir (file-name-directory fname))
         (prj (ede-current-project current-dir)))
    (when prj
      (let* ((ov (oref prj local-variables))
	     (lst (assoc var ov)))
        (when lst
          (cdr lst))))))

;; setup compile package
;; TODO: allow to specify function as compile-command
(require 'compile)
(setq compilation-disable-input nil)
(setq compilation-scroll-output t)
(setq mode-compile-always-save-buffer-p t)
(defun My-Compile ()
  "Saves all unsaved buffers, and runs 'compile'."
  (interactive)
  (save-some-buffers t)
  (compile (or (my-ede-get-local-var (buffer-file-name (current-buffer)) 'compile-command)
               compile-command)))
(global-set-key [f9] 'My-Compile)


;; ========================================
;; ecb
;; ========================================
;; If you want to load the complete ECB at (X)Emacs-loadtime (Advantage: All ECB-options available after loading ECB. Disadvantage: Increasing loadtime2):
;; (require 'ecb)
;; If you want to load the ECB first after starting it by ecb-activate (Advantage: Fast loading3. Disadvantage: ECB- and semantic-options first available after starting ECB):
(require 'ecb-autoloads)
;; This loads all available autoloads of ECB, e.g. ecb-activate, ecb-minor-mode, ecb-byte-compile and ecb-show-help. 

(custom-set-variables
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(ecb-tip-of-the-day nil)
 '(ecb-wget-setup (quote cons)))

;; ========================================
;; ��ʾ�к�
;; ========================================
(require 'linum)
(global-linum-mode t)			;���е�buffer�����к�
;;���кű��
;; (let ((hooks '(python-mode-hook fortran-mode-hook c++-mode-hook c-mode-hook emacs-lisp-mode-hook)))
;;   (dolist (hook hooks)
;;     (add-hook hook 'linum-mode)))

;; ========================================
;; ��ǩ��
;; ========================================
;(require 'tabbar)
;(tabbar-mode t)

;; ========================================
;; EMMS
;; ========================================
;; ����Ե�ǰ�����б�
(defvar my-emms nil "��ǲ������Ƿ���") ;flag
(defun my-emms ()
  (interactive)
  (unless my-emms			;����������
    (require 'emms-setup)
    (require 'emms-history)
    ;;(emms-standard)
    ;;(emms-devel)
    (emms-all)
    ;; ���ó�ʼ����
    (setq
     ;; ��������ļ�Ĭ�ϵ�Ŀ¼
     emms-source-file-default-directory "d:/entertainment/music/"
     emms-repeat-playlist t
     emms-playlist-mode-popup-enabled t
     ;; ����������˳��
     emms-player-list '(emms-player-mpg321
			emms-player-ogg123)
     ;; ��������������
     ;; emms-volume-amixer-control "PCM"
     emms-player-mpg321-command-name "mpg123"
     emms-player-mplayer-parameters '("-slave"))
    ;; ����״̬����ʾ
    (emms-mode-line 1)
    (emms-playing-time nil)
    (emms-history-load)			;�����ϴεĲ����б�
    ;; (emms-add-directory-tree emms-source-file-default-directory)
    (setq my-emms t))

  ;; �򿪲����б���������. �˳�����`q'.
  (emms-playlist-mode-go-popup)
  (set-window-dedicated-p (selected-window) t))

;; ��һ��ִ�и��������������Ժ����ִ�н��򿪵�ǰ�����б�
(global-set-key [(f3)] 'my-emms)

;; ========================================
;; w3m
;; ========================================
(require 'w3m-load)
(setq w3m-command-arguments '("-cookie" "-F"))
;;(setq w3m-tab-width 4)
(setq w3m-use-cookies t)


(setq doc-view-ghostscript-program (executable-find "gswin32c"))


;; ========================================
;; cygwin  ��Ҫ��Ϊ����windows����ansi-term
;; ����Ҫ��ϵͳ��telnet.exe����cygwin��
;; ========================================
(require 'cygwin-mount)
(setq cygwin-mount-cygwin-bin-directory "c:/bin/cygwin/bin")
(cygwin-mount-activate)
(setenv "TERM" "vt100")
;; ========================================
;; ��������bbs
;; ========================================
;; �������ÿ������Լ�д�ģ����������Զ���bbs��elisp�﷨�����ֳ��ֳ���û�취
(require 'bbsconnect)

(setq bbs-avoid-idle-char "\C-L")
(setq bbs-avoid-idle-interval 300)

(global-set-key (kbd "<f1>")
		'(lambda ()
		  (interactive)
		  (bbs-connect "bbs.newsmth.org" "nmu" "11223")))

(global-set-key (kbd "<f2>")
		'(lambda ()
		  (interactive)
		  (bbs-connect "mitbbs.com" "lift" "112233")))


(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))

(require 'pycomplete)


