;;use builtin pacckage system
(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
       package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
       package-archives)
(package-initialize)

;;use evil
(setq evil-want-C-i-jump nil)  ;for in org-mode TAB doesn't work
(setq evil-toggle-key "C-c m")
(require 'evil)
(evil-mode 1)

;;color theme, use solarized
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'solarized t)

(custom-set-variables
  '(frame-background-mode 'dark))

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

;;rainbow
(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)

