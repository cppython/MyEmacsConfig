;; ;; ========================================
;; ;; CEDET
;; ;; ========================================
;; ;; Load CEDET.
;; ;; See cedet/common/cedet.info for configuration details.
;; (load-file "~/emacs-ext/cedet/common/cedet.el")

;; ;; if needed. 
;; ;;(require 'semanticdb)
;; ;;(global-semanticdb-minor-mode 1)

;; ;; Enable EDE (Project Management) features
;; (global-ede-mode 1)
;; ;; Enable prototype help and smart completion 
;; (semantic-load-enable-code-helpers)
;; ;; Enable template insertion menu
;; (global-srecode-minor-mode 1)
;; ;; To use additional features for names completion, and displaying of information for tags & classes
;; (require 'semantic-ia)
;; (require 'semantic-gcc)

;; ;; gnu global support
;; (require 'semanticdb-global)
;; ;; (semanticdb-enable-gnu-global-databases 'c-mode)
;; ;; (semanticdb-enable-gnu-global-databases 'c++-mode)
;; ;; (semanticdb-enable-gnu-global-databases 'python-mode)

;; ;; 添加系统路径
;; ;;(semantic-add-system-include "~/exp/include/boost_1_37" 'c++-mode)
;; (semantic-add-system-include "C:/bin/MinGW/include" 'c++-mode)
;; (semantic-add-system-include "C:/bin/MinGW/include" 'c-mode)

;; (dolist (path load-path)
;;   (semantic-add-system-include path 'emacs-lisp-mode))

;; (setq python-lib-path
;;       (process-lines "python.exe"
;; 		     (expand-file-name
;; 		      (concat (file-name-as-directory emacs-rc-path) "python-path.py"))))

;; (dolist (path python-lib-path)
;;   (semantic-add-system-include path 'python-mode))
;;   ;;(message path))

;; ;; (add-hook 'python-mode-hook '(lambda ()
;; ;; 			       (setq semantic-dependency-system-include-path python-lib-path))))
;; (setq semantic-python-dependency-system-include-path python-lib-path)

;; (defun my-smart-completion ()
;;   ;; completion inline (underlining the target symbol) and allows TAB to be used for completion purposes.
;;   ;; 必须先调用该命令出现下划线后TAB键才能使用，该命令应该是使用最普遍的
;;   ;;(local-set-key "\C-c>" 'semantic-complete-analyze-inline)
;;   (local-set-key [(control tab)] 'semantic-complete-analyze-inline)

;;   ;; 补全公共部分，第二次执行时在缓冲区显示所有可能的补全
;;   (local-set-key [(control return)] 'semantic-ia-complete-symbol)

;;   ;; 功能同上，显示补全菜单
;;   ;;(local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
;;   (local-set-key "\C-cm" 'semantic-ia-complete-symbol-menu) ;这个应该是最好用的
  
;;   ;; displays list of possible completions as tooltip
;;   ;; (local-set-key "\C-ct" 'semantic-ia-complete-tip)


;;   (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)

;;   ;; for simple completion
;;   (local-set-key "\C-c\t" 'senator-complete-symbol)
;;   (local-set-key "\C-c " 'senator-completion-menu-popup) ;;graphical menu of senator-complete-symbol

;;   ;; 成员显示  有了前面的，这个没有必要。这个会导致在注释等地方也会出现不必要的补全
;;   ;; (local-set-key "." 'semantic-complete-self-insert)
;;   ;; (local-set-key ">" 'semantic-complete-self-insert)
;;   ) 

;; (let ((hooks
;;        '(python-mode-hook
;; 	 c-mode-common-hook fortran-mode-hook c++-mode-hook c-mode-hook
;; 	 emacs-lisp-mode-hook lisp-mode-hook)))
;;   (dolist (hook hooks)
;;     (add-hook hook 'my-smart-completion)))

;; ;; hooks, specific for semantic
;; (defun my-semantic-hook ()
;;   ;; (semantic-tag-folding-mode 1)
;;   (imenu-add-to-menubar "TAGS")
;;   )
;; (add-hook 'semantic-init-hooks 'my-semantic-hook)


;; (custom-set-variables
;;  '(global-semantic-decoration-mode t nil (semantic-decorate-mode))
;;  '(global-semantic-highlight-edits-mode t nil (semantic-util-modes))
;;  '(global-semantic-highlight-func-mode t nil (semantic-util-modes))
;;  '(global-semantic-idle-completions-mode t nil (semantic-idle))
;;  '(global-semantic-idle-scheduler-mode t nil (semantic-idle))
;;  '(global-semantic-idle-summary-mode t nil (semantic-idle))
;;  '(global-semantic-idle-tag-highlight-mode t nil (semantic-idle))
;;  '(global-semantic-mru-bookmark-mode t nil (semantic-util-modes))
;;  '(global-semantic-show-parser-state-mode t nil (semantic-util-modes))
;;  '(global-semantic-show-unmatched-syntax-mode t nil (semantic-util-modes))
;;  '(global-semantic-stickyfunc-mode t nil (semantic-util-modes))
;;  '(global-senator-minor-mode t nil (senator))
;;  '(semanticdb-global-mode t nil (semanticdb))
;;  '(which-function-mode t))


;; ;; Load CEDET.
;; ;; See cedet/common/cedet.info for configuration details.
;; (load-file "~/emacs-ext/cedet/common/cedet.el")

;; (defun my-programming-mode ()
;;   (interactive)
;;   (unless (bound-and-true-p my-programming-mode)
;;     (setq my-programming-mode t)

;; ;; ========================================
;; ;; CEDET
;; ;; ========================================

;; ;;(setq semantic-load-turn-everything-on t)


;; ;; Enable prototype help and smart completion 
;; (semantic-load-enable-excessive-code-helpers)
;; ;;(semantic-load-enable-semantic-debugging-helpers)

;; (setq senator-minor-mode-name "SN")
;; (setq semantic-imenu-auto-rebuild-directory-indexes nil)
;; (global-srecode-minor-mode 1)
;; (global-semantic-mru-bookmark-mode 1)

;; (global-semantic-folding-mode 1) 	;打开代码折叠功能，在左边显示三角提示

;; (require 'semantic-decorate-include)

;; ;; gcc setup
;; (require 'semantic-gcc)

;; ;; smart complitions
;; (require 'semantic-ia)

;; ;; 设置搜索次序
;; (let ((modes
;;        '(python-mode
;; 	 c-mode c++-mode fortran-mode
;; 	 emacs-lisp-mode lisp-mode)))
;;   (dolist (mode modes)
;;     (setq-mode-local mode semanticdb-find-default-throttle
;; 		     '(project unloaded system recursive))))

;; ;; 自动选择是全局隐藏还是局部隐藏
;; (defun my-semantic-tag-folding-fold ()
;;   "折叠代码，根据上下文判断是全局还是代码块"
;;   (interactive)
;;   (if (semantic-overlay-p (semantic-tag-folding-get-overlay))
;;       (semantic-tag-folding-fold-block)
;;     ;; 搞不懂为为什么不能把(semantic-tag-folding-get-overlay)的值保存起来
;;     ;; 调用结果竟然不一样，不知道他们怎么写的这个函数
;;     ;;(semantic-tag-folding-set-overlay-visibility ov nil)
;;     (semantic-tag-folding-fold-all)
;;     ))

;; ;; 自动选择是全局显示还是局部显示
;; (defun my-semantic-tag-folding-show ()
;;   "折叠代码，根据上下文判断是全局还是代码块"
;;   (interactive)
;;   (if (semantic-overlay-p (semantic-tag-folding-get-overlay))
;;       (semantic-tag-folding-show-block)
;;     ;;(semantic-tag-folding-set-overlay-visibility ov t)
;;     (semantic-tag-folding-show-all)
;;     ))

;; (defun my-cedet-smart-hook ()
;;   ;; completion inline (underlining the target symbol) and allows TAB to be used for completion purposes.
;;   ;; 必须先调用该命令出现下划线后TAB键才能使用，该命令应该是使用最普遍的
;;   (local-set-key [(control tab)] 'semantic-complete-analyze-inline)

;;   ;; 补全公共部分，第二次执行时在缓冲区显示所有可能的补全
;;   (local-set-key [(control return)] 'semantic-ia-complete-symbol)
;;   (local-set-key "\C-cm" 'semantic-ia-complete-symbol-menu) ;功能同上，显示补全菜单,这个应该是最好用的

;;   ;; (local-set-key "\C-ct" 'semantic-ia-complete-tip) ; displays list of possible completions as tooltip

;;   ;; for simple completion
;;   (local-set-key "\C-c\t" 'senator-complete-symbol)
;;   (local-set-key "\C-c " 'senator-completion-menu-popup) ;;graphical menu of senator-complete-symbol

;;   ;; 跳转
;;   (local-set-key "\C-c=" 'semantic-decoration-include-visit) ;Visit the included file at point.
;;   (local-set-key "\C-cj" 'semantic-ia-fast-jump)	     ;这个不如semantic-complete-jump<C-c , J>好用
;;   ;; 
;;   (local-set-key "\C-cq" 'semantic-ia-show-doc)
;;   (local-set-key "\C-cs" 'semantic-ia-show-summary)
;;   (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)

;;   (local-set-key (kbd "C--") 'my-semantic-tag-folding-fold) ;整合了 block 和 all
;;   (local-set-key (kbd "C-+") 'my-semantic-tag-folding-show)
;;   (local-set-key (kbd "C-c -") 'semantic-tag-folding-fold-children)
;;   (local-set-key (kbd "C-c +") 'semantic-tag-folding-show-children)

;;   ;; (local-set-key (kbd "C-c - b") 'semantic-tag-folding-fold-block)
;;   ;; (local-set-key (kbd "C-c + b") 'semantic-tag-folding-show-block)
;;   ;; (local-set-key (kbd "C-c - a") 'semantic-tag-folding-fold-all)
;;   ;; (local-set-key (kbd "C-c + a") 'semantic-tag-folding-show-all)
;;   ;; (local-set-key (kbd "C-c - c") 'semantic-tag-folding-fold-children)
;;   ;; (local-set-key (kbd "C-c + c") 'semantic-tag-folding-show-children)
;;   )

;; (let ((hooks
;;        '(python-mode-hook
;; 	 c-mode-common-hook fortran-mode-hook c++-mode-hook c-mode-hook
;; 	 emacs-lisp-mode-hook lisp-mode-hook)))
;;   (dolist (hook hooks)
;;     (add-hook hook 'my-cedet-smart-hook)))

;; (require 'eassist)
;; (defun my-c-mode-cedet-hook ()
;;   ;; 成员显示  有了前面的，这个没有必要。这个会导致在注释等地方也会出现不必要的补全
;;   ;; (local-set-key "." 'semantic-complete-self-insert)
;;   ;; (local-set-key ">" 'semantic-complete-self-insert)
;;   (local-set-key "\C-ct" 'eassist-switch-h-cpp)
;;   (local-set-key "\C-xt" 'eassist-switch-h-cpp)
;;   (local-set-key "\C-ce" 'eassist-list-methods)
;;   (local-set-key "\C-c\C-r" 'semantic-symref)
;;   )
;; (add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

;; ;; hooks, specific for semantic
;; (defun my-semantic-hook ()
;;   ;; (semantic-tag-folding-mode 1)
;;   (imenu-add-to-menubar "TAGS")
;;   )
;; (add-hook 'semantic-init-hooks 'my-semantic-hook)


;; ;; gnu global support
;; (require 'semanticdb-global)
;; ;; 使用已有的etag
;; ;; (let ((modes
;; ;;        '(python-mode
;; ;; 	 c-mode c++-mode fortran-mode
;; ;; 	 emacs-lisp-mode lisp-mode)))
;; ;;   (dolist (mode modes)
;; ;;     (semanticdb-enable-gnu-global-databases mode)))

;; ;; 添加 include 路径
;; (dolist (path load-path)
;;   (semantic-add-system-include path 'emacs-lisp-mode))

;; (dolist (path '("C:/bin/MinGW/include"
;; 		"C:/bin/MinGW/include/c++/3.4.5"
;; 		"C:/bin/MinGW/include/sys"
;; 		"C:/bin/MinGW/include/GL"
;; 		"C:/bin/MinGW/include/ddk"))
;;   ;;  (semantic-add-system-include path 'c-mode)
;;   (semantic-add-system-include path 'c++-mode)
;;   )

;; (setq python-lib-path
;;       (process-lines "python.exe"
;; 		     (expand-file-name
;; 		      (concat (file-name-as-directory emacs-rc-path) "python-path.py"))))

;; (dolist (path python-lib-path)
;;   (semantic-add-system-include path 'python-mode))
;; ;;(message path))


;; ;;; ede customization
;; (require 'semantic-lex-spp)
;; (global-ede-mode t) ;; Enable EDE (Project Management) features

;; (custom-set-variables
;;  '(semantic-idle-scheduler-idle-time 2)
;;  '(semantic-self-insert-show-completion-function (lambda nil (semantic-ia-complete-symbol-menu (point))))
;;  '(global-semantic-tag-folding-mode t nil (semantic-util-modes))
;;  )

;; ;; how to make a project definition
;; ;; (setq cpp-tests-project
;; ;;       (ede-cpp-root-project "my-cpp-project"
;; ;; 			    :name "my-cpp-project"
;; ;; 			    :file "f:/source-code/cpp-project/readme.txt"
;; ;; 			    :include-path '()
;; ;; 			    :system-include-path '("C:/bin/MinGW/include"
;; ;; 						   "C:/bin/MinGW/include/c++/3.4.5"
;; ;; 						   "C:/bin/MinGW/include/sys"
;; ;; 						   "C:/bin/MinGW/include/GL"
;; ;; 						   "C:/bin/MinGW/include/ddk")
;; ;; 			    :local-variables 
;; ;; 			    '(
;; ;; 			      (compile-command . "cd f:/source-code/cpp-project; make -all")
;; ;; 			      )
;; ;; 			    ))

;; ;; (setq python-tests-project
;; ;;       (ede-cpp-root-project "my-python-project"
;; ;; 			    :name "my-python-project"
;; ;; 			    :file "f:/source-code/python-project/readme.txt"
;; ;; 			    :include-path '()
;; ;; 			    :system-include-path '("C:/bin/MinGW/include"
;; ;; 						   "C:/bin/MinGW/include/c++/3.4.5"
;; ;; 						   "C:/bin/MinGW/include/sys"
;; ;; 						   "C:/bin/MinGW/include/GL"
;; ;; 						   "C:/bin/MinGW/include/ddk")
;; ;; 			    :local-variables 
;; ;; 			    '(
;; ;; 			      (compile-command . "cd f:/source-code/cpp-project; make -all")
;; ;; 			      )
;; ;; 			    ))

;; ;; my functions for EDE
;; (defun my-ede-get-local-var (fname var)
;;   "fetch given variable var from :local-variables of project of file fname"
;;   (let* ((current-dir (file-name-directory fname))
;;          (prj (ede-current-project current-dir)))
;;     (when prj
;;       (let* ((ov (oref prj local-variables))
;; 	     (lst (assoc var ov)))
;;         (when lst
;;           (cdr lst))))))

;; ;; setup compile package
;; ;; TODO: allow to specify function as compile-command
;; (require 'compile)
;; (setq compilation-disable-input nil)
;; (setq compilation-scroll-output t)
;; (setq mode-compile-always-save-buffer-p t)
;; (defun My-Compile ()
;;   "Saves all unsaved buffers, and runs 'compile'."
;;   (interactive)
;;   (save-some-buffers t)
;;   (compile (or (my-ede-get-local-var (buffer-file-name (current-buffer)) 'compile-command)
;;                compile-command)))
;; (global-set-key [f9] 'My-Compile)



;; ;; ========================================
;; ;; ecb
;; ;; ========================================
;; ;; If you want to load the complete ECB at (X)Emacs-loadtime (Advantage: All ECB-options available after loading ECB. Disadvantage: Increasing loadtime2):
;; ;; (require 'ecb)
;; ;; If you want to load the ECB first after starting it by ecb-activate (Advantage: Fast loading3. Disadvantage: ECB- and semantic-options first available after starting ECB):
;; (require 'ecb-autoloads)
;; ;; This loads all available autoloads of ECB, e.g. ecb-activate, ecb-minor-mode, ecb-byte-compile and ecb-show-help. 

;; (custom-set-variables
;;  '(ecb-options-version "2.40")
;;  '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
;;  '(ecb-tip-of-the-day nil)
;;  '(ecb-wget-setup (quote cons)))

;; ))


;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;; (load-file "~/emacs-ext/cedet-1.0/common/cedet.el")


;; ;; Enable EDE (Project Management) features
;; (global-ede-mode 1)

;; ;; Enable EDE for a pre-existing C++ project
;; ;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")


;; ;; Enabling Semantic (code-parsing, smart completion) features
;; ;; Select one of the following:

;; ;; * This enables the database and idle reparse engines
;; (semantic-load-enable-minimum-features)

;; ;; * This enables some tools useful for coding, such as summary mode
;; ;;   imenu support, and the semantic navigator
;; (semantic-load-enable-code-helpers)

;; ;; * This enables even more coding tools such as intellisense mode
;; ;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;; ;; (semantic-load-enable-gaudy-code-helpers)

;; ;; * This enables the use of Exuberent ctags if you have it installed.
;; ;;   If you use C++ templates or boost, you should NOT enable it.
;; ;; (semantic-load-enable-all-exuberent-ctags-support)
;; ;;   Or, use one of these two types of support.
;; ;;   Add support for new languges only via ctags.
;; ;; (semantic-load-enable-primary-exuberent-ctags-support)
;; ;;   Add support for using ctags as a backup parser.
;; ;; (semantic-load-enable-secondary-exuberent-ctags-support)

;; ;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)

;; (global-semantic-tag-folding-mode 1)