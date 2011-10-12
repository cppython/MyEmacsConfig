
;; ========================================
;; Auctex����
;; ========================================

;; (setq reftex-plug-into-AUCTeX t)
;; (setq bib-cite-use-reftex-view-crossref t)
;; (setq reftex-texpath-environment-variables '("."))
;; (setq reftex-bibpath-environment-variables '("."))

;; ;;(setq TeX-source-specials-mode t) ; ��winedtһ������Ҫ��dvi�мӵ��ϲ���֧��Yap�ķ�������
;; ;; xeLatex���Ѿ�����Ҫ�ˣ�ֱ������pdf�ļ�

;; ;; (setq outline-minor-mode-prefix "\C-c@")

(setq TeX-electric-sub-and-superscript t)
;; (setq TeX-auto-save t)
;; (setq Tex-parse-self t)
;; ;;(setq-default TeX-master nil)
;; ;;(setq TeX-electric-escape t)

;; �������Լ���tex mode
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

		;; �޸�ȱʡlatexΪxeLatex
		(add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
		(setq TeX-command-default "XeLaTeX")
		(setq TeX-save-query nil)
		(setq TeX-show-compilation t)
		;; 

		))
    ))

(my-tex-mode)

