;; -*-Emacs-Lisp-*-
;; use melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; set font and theme
;; doom-dark+ requires doom-themes package
(add-to-list 'default-frame-alist
	     '(font . "Source Code Pro for Powerline"))
(load-theme 'doom-dark+ t)

;; enable highlighting matching parens/brackets
(show-paren-mode 1)

;; prevent org from including section numbers when exporting
(setq org-export-with-section-numbers nil)

;; indent of 2 for json-mode
;; requires the json-mode package
(setq js-indent-level 2)

;; enable ivy
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)

;; enable swiper
(global-set-key "\C-s" 'swiper)

;; enable jumping to windows by number using M-<Window Number>
;; requires the window-numbering package
(window-numbering-mode 1)

;; prevent startup screen from showing
(setq inhibit-startup-screen t)

;; enable global highlighting of TODOs
(global-hl-todo-mode)

;; enable column numbers
(column-number-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("5846b39f2171d620c45ee31409350c1ccaddebd3f88ac19894ae15db9ef23035" default)))
 '(global-hl-todo-mode t)
 '(org-export-backends (quote (ascii html icalendar latex md odt)))
 '(package-selected-packages
   (quote
    (evil pyvenv yaml-mode fish-mode highlight-numbers highlight-operators hl-todo ivy swiper magit doom-themes window-numbering groovy-mode git-gutter json-mode monokai-pro-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
