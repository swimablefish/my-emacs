;use builtin pacckage system
(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
       package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
       package-archives)
(package-initialize)

;use evil
(setq evil-toggle-key "C-c m")
(require 'evil)
(evil-mode 1)

;color theme, use solarized
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'solarized t)

(custom-set-variables
  '(frame-background-mode 'dark))

;line number
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

;magit      
(global-set-key (kbd "C-x g") 'magit-status)
