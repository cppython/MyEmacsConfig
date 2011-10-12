
;; ========================================
;; Auctex特性
;; ========================================

;; (setq reftex-plug-into-AUCTeX t)
;; (setq bib-cite-use-reftex-view-crossref t)
;; (setq reftex-texpath-environment-variables '("."))
;; (setq reftex-bibpath-environment-variables '("."))

;; ;;(setq TeX-source-specials-mode t) ; 和winedt一样，需要在dvi中加点料才能支持Yap的反向搜索
;; ;; xeLatex中已经不需要了，直接生成pdf文件

;; ;; (setq outline-minor-mode-prefix "\C-c@")

(setq TeX-electric-sub-and-superscript t)
;; (setq TeX-auto-save t)
;; (setq Tex-parse-self t)
;; ;;(setq-default TeX-master nil)
;; ;;(setq TeX-electric-escape t)

;; 设置我自己的tex mode
(defun my-tex-mode ()
  (interactive)
  (unless (bound-and-true-p my-tex-mode)
    (setq my-tex-mode t)

    (require 'tex-site)
    (require 'tex-mik)

    (autoload 'cdlatex-mode "cdlatex" "CDLaTeX Mode" t)

    (add-hook 'LaTeX-mode-hook
	      (lambda ()
		(reftex-mode)

		(outline-minor-mode)

		(LaTeX-math-mode)

		(turn-on-auto-fill)

		(TeX-fold-mode)

		(define-key LaTeX-mode-map '[C-tab] 'TeX-complete-symbol)

		(cdlatex-mode)

		;; 修改缺省latex为xeLatex
		(add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
		(setq TeX-command-default "XeLaTeX")
		(setq TeX-save-query nil)
		(setq TeX-show-compilation t)
		;; 

		))
    ))

(my-tex-mode)

