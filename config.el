;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Akimzhan"
      user-mail-address "akimjedi@yandex.kz")
(add-hook 'window-setup-hook #'toggle-frame-maximized)
(setq doom-theme 'modus-operandi)
(global-auto-revert-mode 1)
(setq org-directory "~/org/")

(after! smartparens
  (dolist (brace '("(" "{" "[" "'" "\"" "\\\""))
    (sp-pair brace nil
             :post-handlers '(("||\n[i]" "RET"))
             :unless (mapcar #'symbol-function '(sp-point-before-word-p sp-point-before-same-p sp-in-string-quotes-p)))))

(setq display-line-numbers-width-start t
      display-line-numbers-grow-only t
      display-line-numbers-type 'relative)

(setq window-divider-default-bottom-width 8
      window-divider-default-right-width 8)

(window-divider-mode)

(after! persp-mode
  (setq persp-auto-resume-time 10))

(after! evil
  (setq evil-want-C-d-scroll nil)
  (evil-declare-motion #'swiper-isearch)
  (map! :nv "C-d" #'evil-end-of-line
        :nv "/" #'swiper-isearch)
  (setq evil-move-beyond-eol t)
  (map! :leader :nv "v" 'ace-window)
  (map! :n "RET" #'newline-and-indent)
  (map! :map evil-snipe-local-mode-map :nv "s" #'evil-avy-goto-char-2))
