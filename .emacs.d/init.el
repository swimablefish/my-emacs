;;use builtin pacckage system
(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
       package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
       package-archives)
(package-initialize)

(setq inhibit-startup-message t)
(setq initial-frame-alist (quote ((fullscreen . maximized))))
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
;; highlight the line
(global-hl-line-mode 1)
;; close auto save
(setq auto-save-default nil)
(global-auto-revert-mode 1)

;;use evil
(setq evil-want-C-i-jump nil)  ;for in org-mode TAB doesn't work
(setq evil-toggle-key "C-c m")
(require 'evil)
(evil-mode 1)

;;color theme, use solarized
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'solarized t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(frame-background-mode (quote dark))
 '(package-selected-packages
   (quote
    (emamux yaml-mode which-key weibo twittering-mode solarized-theme smartparens scala-mode2 scala-mode scad-mode sbt-mode rainbow-delimiters rainbow-blocks org-pomodoro org-mobile-sync org-magit org-mac-link org-mac-iCal org-dropbox markdown-mode latex-preview-pane jinja2-mode jdee javadoc-lookup groovy-mode gradle-mode google-c-style go-stacktracer go-guru go-errcheck go-eldoc go-dlv go-direx go-autocomplete evil-tabs evil-swap-keys evil-surround evil-paredit evil-org evil-numbers evil-nerd-commenter evil-god-state evil-escape evil-commentary ein-mumamo csv-mode company-web company-go company-emoji company-cmake company-ansible company-anaconda color-theme cider-spy cider-profile cider-eval-sexp-fu cider-decompile auctex ahungry-theme 0blayout))))

;;line number
(global-linum-mode 1)
(eval-after-load 'linum
  '(progn
     (defface linum-leading-zero
       `((t :inherit 'linum
            :foreground ,(face-attribute 'linum :background nil t)))
       "Face for displaying leading zeroes for line numbers in display margin."
       :group 'linum)

      (defun linum-format-func (line)
        (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
          (propertize (format (format "%%%dd " w) line) 'face 'linum)))
      (setq linum-format 'linum-format-func)))

;;magit      
(global-set-key (kbd "C-x g") 'magit-status)

;;twitter
(setq twittering-icon-mode t)
(setq twittering-number-of-tweets-on-retrieval 100)

;;org-mode
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c i") 'org-iswitchb)
(setq org-agenda-files (list "~/Documents/org"))
(setq org-startup-folded 0)
(setq org-log-done 'time)

(setq org-capture-templates
  '(("t" "Todo" entry (file+headline "~/Documents/org/todo.org" "Tasks")
    "* TODO %?\n %i\n")
    ("j" "Journal" entry (file+datetree "~/Documents/org/journal.org")
    "* %?\nEntered on %U\n %i\n %a")))

(org-babel-do-load-languages
  'org-babel-load-languages
   '((python . t)
     (sh . t)
     (R . t)
     (ruby . t)
     (ditaa . t)
     (dot . t)
     (octave . t)
     (sqlite . t)
     (latex . t)
     (clojure . t)
     (perl . t)))

;;org-pomodoro  
;;play tick sound
(setq org-pomodoro-ticking-sound-p t)

;; Set to the location of your Org files on your local system
(setq org-directory "~/Documents/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Documents/org/todo.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

(add-hook 'after-init-hook 'global-company-mode)
(eval-after-load "company"
  '(progn
     (add-to-list 'company-backends 'company-anaconda)))
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)
(setq
  python-shell-interpreter "ipython"
  python-shell-interpreter-args "--pylab"
  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
  python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
  python-shell-completion-setup-code
  "from IPython.core.completerlib import module_completion"
  python-shell-completion-module-string-code
  "';'.join(module_completion('''%s'''))\n"
  python-shell-completion-string-code
  "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

;;enable pgp
(require 'epa-file)

;;set picture width
(setq org-image-actual-width '(300)) 

;; ipython notebook
(require 'ein)

;;cider
(add-hook 'cider-mode-hook #'eldoc-mode)
(setq cider-auto-mode nil)
(add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)
(add-hook 'clojure-mode-hook #'smartparens-strict-mode)

(add-hook 'cider-mode-hook
 '(lambda () (add-hook 'after-save-hook
         '(lambda ()
             (if (and (boundp 'cider-mode) cider-mode)
              (cider-namespace-refresh))))))
 
(defun cider-namespace-refresh ()
  (interactive)
  (cider-interactive-eval
   "(require 'clojure.tools.namespace.repl)
   (clojure.tools.namespace.repl/refresh)"))

;;rainbow
(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)

;;for latex
;(setenv "PATH" (concat "/Library/TeX/texbin" ":" (getenv "PATH")))
(setenv "PATH" (concat "/Library/TeX/texbin:/usr/local/bin:" 
               (getenv "PATH")))
(setq preview-gs-command "/usr/local/bin/gs")

;; gradle
(require 'gradle-mode)

(add-to-list 'auto-mode-alist '("\\Jenkinsfile\\'" . groovy-mode))
(add-hook 'groovy-mode-hook (lambda () (c-set-offset 'label 4)))

;;go
(setenv "GOPATH" "/Users/jinyu/code/golib")
(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)
(with-eval-after-load 'go-mode
  (require 'go-guru)
  (add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)
  (local-set-key (kbd "M-j") 'godef-jump)
  (require 'go-autocomplete))


;;yml or yaml
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

(require 'evil-surround)
(global-evil-surround-mode)
(evilnc-default-hotkeys)
(define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
(define-key evil-visual-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)

(which-key-mode 1)

;;ignore some noise error message
(setq ad-redefinition-action 'accept)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
