;; 所有的buffer都加行号
(global-linum-mode t)

;;
;; close vc
(setq vc-handled-backends nil)

;; auto complete
;; (add-to-list 'ac-dictionary-directories "~/emacs-ext/site-lisp/ac-dict/auto-complete-1.3.1/dict")
(require 'auto-complete-config)
(ac-config-default)

;; doxymacs
;;
(require 'doxymacs)
(add-hook 'font-lock-mode-hook
          (lambda ()
            (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
                (doxymacs-font-lock))
            ))

;;
;; semantic-mode
(require 'semantic)
(semantic-mode 1)
(global-semantic-highlight-func-mode 1)

;;
;; common config for all my programming mode
(setq my-programming-mode-list
      '(c-mode c++-mode python-mode emacs-lisp-mode fortran-mode))

(dolist (mode my-programming-mode-list)
  (let ((mode-hook (intern (concat (symbol-name mode) "-hook"))))
    (add-hook mode-hook
              (lambda ()
                ;;

                ))))


(dolist (mode my-programming-mode-list)
  (let ((mode-hook (intern (concat (symbol-name mode) "-hook"))))
    (add-hook mode-hook
              ;; (add-hook 'c-mode-common-hook
              (lambda ()
                ;; use space as indent
                (setq-default indent-tabs-mode nil)
                ;; (c-toggle-auto-state 1)

                ;;
                (local-set-key (kbd "RET") 'newline-and-indent)

                ;; hide and show blocks
                (hs-minor-mode 1)
                (local-set-key (kbd "C-=") 'hs-toggle-hiding)
                (local-set-key (kbd "C--") 'hs-hide-level)

                ;; (defun my-doxymacs-mode
                (doxymacs-mode 1)

                (local-set-key (kbd "C-\\") 'align-entire)

                ;; ff-find-other-file
                (local-set-key (kbd "C-c C-o") 'ff-find-other-file)


                ))))

;;
;;

;;
;; add my hook to c-mode c++-mode
;; (add-hook 'c-mode-common-hook
;;        (lambda ()

;;          ))


(add-to-list 'auto-mode-alist '("\\.ph" . c++-mode))

;; if indent-tabs-mode is off, untabify before saving

(add-hook 'write-file-hooks
          (lambda ()

            (when (member major-mode my-programming-mode-list)
              (when (not indent-tabs-mode)
                (untabify (point-min) (point-max)))
              (whitespace-cleanup)
              (indent-region (point-min) (point-max)))

            ;; the hook should return nil, otherwise the file isn't saved
            nil))

;; dired-mode and dired-x
(setq dired-listing-switches "-alhF")

(add-hook 'dired-load-hook
          (lambda ()
            (load "dired-x")
            ;; Set dired-x global variables here.  For example:
            ;; (setq dired-guess-shell-gnutar "gtar")
            ;; (setq dired-x-hands-off-my-keys nil)
            (setq dired-omit-mode t)
            (setq dired-omit-files
                  (concat dired-omit-files
                          "^#\\|\\.$|\\|^\\..+$"))

            ))

(add-hook 'dired-mode-hook
          (lambda ()
            ;; Set dired-x buffer-local variables here.  For example:
            (dired-omit-mode 1)
            ))

;;
;; turn on c++-mode for  std c++ headers (<vector> <iostream>)
(require 'cl)

(setq stdc++-include-path
      "C:/Program Files (x86)/Microsoft Visual Studio 10.0/VC/include")

(defun file-in-directory-list-p (file dirlist)
  "Returns true if the file specified is contained within one of
the directories in the list. The directories must also exist."
  (let ((dirs (mapcar 'expand-file-name dirlist))
        (filedir (expand-file-name (file-name-directory file))))
    (and
     (file-directory-p filedir)
     (member-if (lambda (x) ; Check directory prefix matches
                  (string-match (substring x 0 (min(length filedir) (length x))) filedir))
                dirs))))

(defun buffer-standard-include-p ()
  "Returns true if the current buffer is contained within one of
the directories in the INCLUDE environment variable."
  (file-in-directory-list-p buffer-file-name (split-string stdc++-include-path path-separator)))

(add-to-list 'magic-fallback-mode-alist '(buffer-standard-include-p . c++-mode))


;; ff-find-other-file
;; switch to header or source file
;; (require 'find-file)
(setq ff-always-try-to-create nil)
(setq ff-case-fold-search t)            ; ignore case
(setq ff-search-directories
      '(
        "."
        "../../export/include"
        "../../local/code"
        "C:/Program Files (x86)/Microsoft Visual Studio 10.0/VC/include"
        "C:/Program Files (x86)/Microsoft Visual Studio 10.0/VC/atlmfc/include"
        "C:/Program Files (x86)/Microsoft SDKs/Windows/v7.0A/Include"
        )
      )

(setq ff-other-file-alist
      '(
        ("\\.c$"  (".h" ".hpp" ".ph"))
        ("\\.cpp$"  (".ph" ".hpp" ".h" ".hh"))
        ("\\.cc$"  (".ph" ".hpp" ".h" ".hh"))
        ("\\.ph$"  (".cpp" ".c" ".cc"))
        ("\\.hpp" (".cpp" ".c" ".cc"))
        ("\\.h" (".c" ".cpp" ".cc"))
        )
      )

;; ;;
;; ;; open directory
;; (defun scm-open-project (project-root-path)
;;   (interactive "Dproject-directory:")
;;   (dired project-root-path)
;;   (dired-hide-subdir 1)
;;   (dired-maybe-insert-subdir "bakeup/emacs-rc" )
;;   )

(defun scm-open-project-dired (project-root-path)
  (interactive
   (list (dired-get-filename)))
  (dired project-root-path)
  (dired-hide-subdir 1)
  (dired-maybe-insert-subdir "emacs-rc" )
  )

(add-hook 'dired-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-o") 'scm-open-project-dired)
            ))

(defun scm-compile ()
  (interactive)
  )
