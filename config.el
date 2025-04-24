;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;;
(setq doom-font (font-spec :family "IosevkaTermSlab Nerd Font Mono" :size 28 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Ubuntu Sans" :size 32))
(setq user-full-name "Akim"
      user-mail-address "akimjedi@yandex.kz")
(add-hook 'window-setup-hook #'toggle-frame-maximized)
(setq doom-theme 'modus-vivendi)

(global-display-fill-column-indicator-mode)

(defun my/enable-auto-revert-if-file ()
  "Enable auto-revert-mode only if the buffer is visiting a file."
  (when buffer-file-name
    (auto-revert-mode 1)))
(add-hook 'find-file-hook #'my/enable-auto-revert-if-file)

(setq org-directory "~/org/")

(after! go-mode
  (setq gofmt-command "goimports"))

(after! smartparens
  (dolist (brace '("(" "{" "[" "'" "\"" "\\\""))
    (sp-pair brace nil
             :post-handlers '(("||\n[i]" "RET"))
             :unless (mapcar #'symbol-function '(sp-point-before-word-p sp-point-before-same-p sp-in-string-quotes-p)))))

(use-package! breadcrumb
  :hook (prog-mode . breadcrumb-mode)
  :config
  (setq breadcrumb-imenu-max-depth 4
        breadcrumb-project-max-length 30))

(setq display-line-numbers-width-start t
      display-line-numbers-grow-only t
      display-line-numbers-type 'relative)

(setq window-divider-default-bottom-width 8
      window-divider-default-right-width 8)

(window-divider-mode)

(after! evil
  (setq avy-keys '(?f ?j ?k ?d ?s ?l)
        avy-style 'at-full
        avy-all-windows t
        avy-single-candidate-jump t)

  (evil-define-command +evil:swiper-backward (&optional search)
    "Invoke `swiper' with SEARCH, otherwise with the symbol at point."
    (interactive "<a>")
    (swiper-isearch-backward search)
    (setq evil-ex-search-direction 'backward))
  (evil-ex-define-cmd "Sw[iper]" #'+evil:swiper-backward)
  (require 'evil-ex)
  (setq evil-want-C-d-scroll nil)
  (map! :nv "C-d" #'evil-end-of-line
        :nv "/" #'+evil:swiper
        :nv "?" #'+evil:swiper-backward)
  (setq evil-move-beyond-eol t)
  (map! :leader :nv "v" 'ace-window)
  (map! :n "RET" #'newline-and-indent
        "M-p" #'yank-pop)
  (map! :map evil-snipe-mode-map :nv "s" #'evil-avy-goto-char-timer))

(after! lsp
  (add-hook 'before-save-hook #'lsp-organize-imports))
