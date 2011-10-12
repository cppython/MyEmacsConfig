
(defmacro my-run-once (flag-name code-lisp)
  `(unless (bound-and-true-p ,flag-name)
     (setq ,flag-name t)
     ,code-lisp
    )
  )

;; ========================================
;; python-mode支持
;; ========================================
(push '("\\.py$" . python-mode) auto-mode-alist)
(push '("python" . python-mode) interpreter-mode-alist)
(autoload 'python-mode "python-mode" "Python editing mode." t)

;; ========================================
;; ipython支持
;; ========================================
(require 'ipython)
;(setq py-python-command-args '("-pylab" "-colors" "LightBG"))

;; ========================================
;; pymacs and python completion
;; ========================================

;; (defun my-python-mode()
;;   (interactive)
;;   (unless (bound-and-true-p my-python-mode)
;;     (setq my-python-mode t)

;;     (require 'pycomplete)
    
;;     (autoload 'pymacs-apply "pymacs")
;;     (autoload 'pymacs-call "pymacs")
;;     (autoload 'pymacs-eval "pymacs" nil t)
;;     (autoload 'pymacs-exec "pymacs" nil t)
;;     (autoload 'pymacs-load "pymacs" nil t)

;;     (pymacs-load "ropemacs" "rope-")
;;     ))

(require 'yasnippet-bundle)

