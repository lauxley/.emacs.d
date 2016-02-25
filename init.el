;;; install required packages
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives 
             '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar packages-list '(js2-mode
                        ; json-mode
                        ; web-mode
                        django-mode
                        flycheck
                        auto-complete
                        markdown-mode
                        yasnippet
                        yafolding)
  "A list of packages to install at launch (if needed).")

(dolist (p packages-list)
  (when (not (package-installed-p p))
    (package-install p)))

;;; 
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(current-language-environment "English")
 '(font-lock-global-modes t)
 '(font-lock-maximum-decoration t)
 '(global-font-lock-mode t nil (font-lock))
 '(query-user-mail-address nil)
 '(show-paren-mode t)
 '(text-mode-hook (quote (text-mode-hook-identify)))
 '(python-check-command "pycheckers")
)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(setq-default indent-tabs-mode nil)
(setq display-warning-minimum-level 'error
        log-warning-minimal-level 'info)
(setq default-tab-width 4)
(setq fill-column 80)
(setq-default truncate-lines 1)

(setq python-shell-interpreter "/usr/local/lib/python3.4")

(put 'upcase-region 'disabled nil)

;; colored #hexa
(defvar hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{6\\}"
     (0 (put-text-property
         (match-beginning 0)
         (match-end 0)
         'face (list :background
                     (match-string-no-properties 0)))))))
(defun hexcolour-add-to-font-lock ()
  (font-lock-add-keywords nil hexcolour-keywords))
(add-hook 'css-mode-hook 'hexcolour-add-to-font-lock)
(add-hook 'html-mode-hook 'hexcolour-add-to-font-lock)


(setq next-line-add-newlines nil)
(font-lock-mode t)
 ; Make all "yes or no" prompts show "y or n" instead
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-splash-screen t)
(setq-default indent-tabs-mode nil)

(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [C-prior] 'beginning-of-buffer)
(global-set-key [C-next] 'end-of-buffer) 

; turn off the tool and menu bars
(tool-bar-mode -1)
(menu-bar-mode -1)
;(set-frame-font "Ubuntu Mono-8")

(prefer-coding-system 'mule-utf-8)

(require 'ido)
(ido-mode t)
(add-to-list 'ido-ignore-files "\\.pyc")

(add-to-list 'load-path
             "~/.emacs.d/plugins")

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins//ac-dict")
(ac-config-default)

(add-to-list 'load-path
             "~/.emacs.d/plugins/js2-mode")

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

(yas/load-directory "~/.emacs.d/plugins/snippets")

;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path
              "~/.emacs.d/plugins/django-mode")
;(require 'django-html-mode)
(require 'django-mode)
(yas/load-directory "~/.emacs.d/plugins/django-mode/snippets")
;(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mode))

(add-hook 'html-helper-mode-hook
          '(lambda ()
             (yas/minor-mode-on))) 

; (require 'json-mode)

;(load-library "~/.emacs.d/init_python")
;(add-to-list 'load-path
;              "~/.emacs.d/plugins/web-mode")
;(require 'web-mode)
;(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))

;; django template mode
;; (autoload 'django-html-mumamo-mode "~/.emacs.d/nxhtml/autostart.el")
;; (setq auto-mode-alist
;;       (append '(("\\.html?$" . django-html-mumamo-mode)) auto-mode-alist))
;; (setq mumamo-background-colors nil) 
;; (add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))

(add-hook 'after-init-hook #'global-flycheck-mode)

;(require 'mercurial)
(require 'tramp)

(defvar yafolding-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<C-S-return>") #'yafolding-hide-parent-element)
    (define-key map (kbd "<C-M-return>") #'yafolding-toggle-all)
    (define-key map (kbd "<C-return>") #'yafolding-toggle-element)
    map))
