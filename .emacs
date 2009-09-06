;; no splash screen
(setq inhibit-splash-screen t)

;; highlighting
(global-font-lock-mode t)

;; add to the load-path
(setq load-path (cons "~/.emacs.d/lisp/" load-path))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backups"))))
 '(c-basic-offset 4)
 '(c-default-style (quote ((objc-mode . "") (java-mode . "java") (awk-mode . "awk") (other . "gnu"))))
 '(indent-tabs-mode nil)
 '(js2-allow-keywords-as-property-names nil)
 '(js2-idle-timer-delay 0.4)
 '(nxml-child-indent 4)
 '(nxml-outline-child-indent 4)
 '(paren-match-face (quote paren-face-match-light))
 '(paren-sexp-mode t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tramp-auto-save-directory "~/.emacs.d/auto_saves")
 '(tramp-backup-directory-alist (quote ((".*" . "~/.emacs.d/backup"))))
 '(tramp-copy-size-limit 40720)
 '(tramp-encoding-shell "/bin/bash")
 '(transient-mark-mode t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; php-mode
(autoload 'php-mode "php-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

;; js2-mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; nxml-mode
(load "~/.emacs.d/lisp/nxml-mode-20041004/rng-auto.elc")

(add-to-list 'auto-mode-alist
              (cons (concat "\\." (regexp-opt '("xml" "xsd" "sch" "rng" "xslt" "svg" "rss" "tal") t) "\\'")
                    'nxml-mode))

(unify-8859-on-decoding-mode)

(setq magic-mode-alist
      (cons '("<＼＼?xml " . nxml-mode)
            magic-mode-alist))

(fset 'xml-mode 'nxml-mode)
(fset 'html-mode 'nxml-mode)

;; markdown-mode
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.\\(md\\|markdown\\|mdown\\|mkd\\|mkdn\\)$" . markdown-mode))

;; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.\\(yml\\|yaml\\)$" . yaml-mode))

;; yasnippets
(setq load-path (cons "~/.emacs.d/lisp/yasnippet" load-path))
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/lisp/yasnippet/snippets/")
;; (setq yas/extra-mode-hooks '(js2-mode))
;; (setq yas/extra-mode-hooks '(php-mode))
;; (setq yas/extra-mode-hooks '(nxml-mode))

;; dired enhancements
(load "dired+.elc")

;; Enable badass buffer switching
(iswitchb-mode t)

(define-key global-map [ns-drag-file] 'ns-find-file)
(define-key global-map (kbd "s-w") 'delete-region)
(define-key global-map (kbd "s-h") 'hippie-expand)
(global-set-key "\M-g" 'goto-line)

;; Set hippie-expand functions
(setq hippie-expand-try-functions-list '( yas/hippie-try-expand 
                                          try-expand-all-abbrevs
                                          ;;try-expand-list
                                          try-expand-dabbrev
                                          try-expand-dabbrev-all-buffers
                                          try-expand-dabbrev-from-kill
                                          try-complete-file-name-partially
                                          try-complete-file-name
                                          try-complete-lisp-symbol-partially 
                                          try-complete-lisp-symbol))

;; Line-break unborking
(defun dos-unix ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))
(defun unix-dos ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t) (replace-match "\r\n")))

;; turn on mouse wheel scrolling
(defun sd-mousewheel-scroll-up (event)
  "Scroll window under mouse up by five lines."
  (interactive "e")
  (let ((current-window (selected-window)))
    (unwind-protect
        (progn 
          (select-window (posn-window (event-start event)))
          (scroll-up 2))
      (select-window current-window))))

(defun sd-mousewheel-scroll-down (event)
  "Scroll window under mouse down by five lines."
  (interactive "e")
  (let ((current-window (selected-window)))
    (unwind-protect
        (progn 
          (select-window (posn-window (event-start event)))
          (scroll-down 2))
      (select-window current-window))))
 
(if (load "mwheel" t)
    (mwheel-install)
  ((global-set-key (kbd "<wheel-up>") 'sd-mousewheel-scroll-up)
   (global-set-key (kbd "<wheel-down>") 'sd-mousewheel-scroll-down)))
