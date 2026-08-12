;;; emacsvox-cider.el --- Speech-enable CIDER -*- lexical-binding: t; -*-
;; $Author: tv.raman.tv $
;; Description:  Speech-enable CIDER An Emacs Interface to cider
;; Keywords: Emacsvox,  Audio Desktop, cider
;;;   LCD Archive entry:

;; LCD Archive Entry:
;; emacsvox| T. V. Raman |tv.raman.tv@gmail.com
;; A speech interface to Emacs |
;; 
;;  $Revision: 4532 $ |
;; Location https://github.com/tvraman/emacsvox
;; 

;;;   Copyright:
;; Copyright (C) 1995 -- 2007, 2011, T. V. Raman
;; Copyright (c) 1994, 1995 by Digital Equipment Corporation.
;; All Rights Reserved.
;; 
;; This file is not part of GNU Emacs, but the same permissions apply.
;; 
;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;; 
;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNCIDER FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; Commentary:
;; Speech-Enable CIDER --- Clojure IDE

;;; Code:

;;   Required modules:

(eval-when-compile (require 'cl-lib))
(cl-declaim  (optimize  (safety 0) (speed 3)))
(require 'emacsvox-preamble)

;;;  Map Faces:

(voice-setup-add-map
 '(
   (cider-debug-code-overlay-face voice-monotone-extra)
   (cider-debug-prompt-face voice-animate)
   (cider-deprecated-face voice-monotone-extra)
   (cider-docview-emphasis-face voice-lighten)
   (cider-docview-literal-face voice-monotone-medium)
   (cider-docview-strong-face voice-monotone-medium)
   (cider-enlightened-face voice-lighten)
   (cider-enlightened-local-face voice-lighten-extra)
   (cider-error-highlight-face voice-animate)
   (cider-fragile-button-face voice-annotate)
   (cider-instrumented-face voice-monotone-medium)
   (cider-repl-input-face voice-animate)
   (cider-repl-prompt-face voice-annotate)
   (cider-repl-result-face voice-bolden)
   (cider-repl-stderr-facevoice-animate)
   (cider-repl-stdout-face voice-bolden-medium)
   (cider-result-overlay-face voice-bolden)
   (cider-stacktrace-error-class-face voice-animate)
   (cider-stacktrace-error-message-face voice-animate-extra)
   (cider-stacktrace-face voice-bolden)
   (cider-stacktrace-filter-hidden-face voice-smoothen)
   (cider-stacktrace-filter-shown-face voice-bolden-and-animate)
   (cider-stacktrace-fn-face voice-bolden)
   (cider-stacktrace-ns-face voice-smoothen)
   (cider-stacktrace-promoted-button-face voice-animate)
   (cider-stacktrace-suppressed-button-face voice-smoothen-extra)
   (cider-test-error-face voice-animate)
   (cider-test-failure-face voice-animate-extra)
   (cider-test-success-face voice-bolden-medium)
   (cider-traced-face voice-bolden)
   (cider-warning-highlight-face voice-animate-extra)
   ))

;;;  Apropos:

(defun ems--cider-visit-error-buffer-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (emacsvox-speak-mode-line)
       (emacsvox-icon 'open-object)))

(cl-loop
 for f in
 '(cider-visit-error-buffer cider-selector cider-scratch cider-switch-to-last-clojure-buffer cider-switch-to-repl-buffer cider-apropos cider-apropos-documentation cider-apropos-documentation-select cider-apropos-select)
 do
 (advice-add f :after #'ems--cider-visit-error-buffer-after))

;;;  Associate Connection:

(defun ems--cider-assoc-buffer-with-connection-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (emacsvox-icon 'task-done)))

(cl-loop
 for f in
 '(cider-assoc-buffer-with-connection cider-assoc-project-with-connection cider-format-buffer cider-format-region cider-format-edn-region cider-format-edn-buffer cider-undef)
 do
 (advice-add f :after #'ems--cider-assoc-buffer-with-connection-after))

;;;  Browse:

(defun ems--cider-browse-instrumented-defs-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (with-current-buffer (window-buffer (selected-window))
         (emacsvox-icon 'open-object)
         (emacsvox-speak-line))))

(cl-loop
 for f in
 '(cider-browse-instrumented-defs cider-browse-ns cider-browse-ns-all cider-browse-ns-operate-at-point cider-browse-ns-doc-at-point cider-classpath-operate-on-point cider-browse-ns-find-at-point cider-classpath cider-doc)
 do
 (advice-add f :after #'ems--cider-browse-instrumented-defs-after))

;;;  Speech-enable Eval:

(defun ems--cider-eval-defun-at-point-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (emacsvox-icon 'task-done)))

(cl-loop
 for f in
 '(cider-eval-defun-at-point cider-eval-defun-to-comment cider-eval-file cider-eval-last-sexp cider-eval-last-sexp-and-replace cider-eval-last-sexp-to-repl cider-eval-ns-form cider-eval-print-last-sexp cider-eval-buffer cider-eval-region cider-eval-sexp-at-point)
 do
 (advice-add f :after #'ems--cider-eval-defun-at-point-after))

;;;  cider-repl:

;;; Navigators:

(defun ems--cider-repl-previous-prompt-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (emacsvox-icon 'large-movement)
       (emacsvox-speak-line)))

(cl-loop
 for f in
 '(cider-repl-previous-prompt cider-repl-previous-matching-input cider-repl-previous-input cider-repl-next-prompt cider-repl-next-matching-input cider-repl-next-input cider-repl-forward-input cider-repl-backward-input cider-repl-end-of-defun cider-repl-beginning-of-defun)
 do
 (advice-add f :after #'ems--cider-repl-previous-prompt-after))
(defun ems--cider-repl-closing-return-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (save-excursion
         (goto-char
          (previous-single-property-change (point)   'face nil (point-min)))
         (emacsvox-speak-range))
       (emacsvox-icon 'close-object)))

(cl-loop
 for f in
 '(cider-repl-closing-return cider-repl-return)
 do
 (advice-add f :after #'ems--cider-repl-closing-return-after))

(defun ems--cider-clear-compilation-highlights-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (emacsvox-icon 'delete-object)))

(cl-loop
 for f in
 '(cider-clear-compilation-highlights cider-repl-kill-input cider-scratch-reset cider -repl-clear-banners cider-repl-clear-buffer cider-find-and-clear-repl-output cider-repl-clear-help-banner cider-repl-clear-output)
 do
 (advice-add f :after #'ems--cider-clear-compilation-highlights-after))

(defun ems--cider-repl-tab-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (emacsvox-speak-line)
       (emacsvox-icon 'select-object)))

(cl-loop
 for f in
 '(cider-repl-tab cider-repl-indent-and-complete-symbol cider-repl-newline-and-indent cider-repl-bol-mark)
 do
 (advice-add f :after #'ems--cider-repl-tab-after))

(defun ems--cider-repl-switch-to-other-after (&rest _)
  "speak."
  (when (ems-interactive-p)
    (emacsvox-speak-mode-line) (emacsvox-icon 'select-object)))

(advice-add 'cider-repl-switch-to-other :after
            #'ems--cider-repl-switch-to-other-after)

(defun ems--cider-repl-set-ns-after (&rest _)
  "speak."
  (when (ems-interactive-p)
    (emacsvox-speak-line) (emacsvox-icon 'select-object)))

(advice-add 'cider-repl-set-ns :after #'ems--cider-repl-set-ns-after)

(defun ems--cider-repl-toggle-pretty-printing-after (&rest _)
  "speak."
  (when (ems-interactive-p)
    (emacsvox-icon (f cider-repl-use-pretty-printing 'on 'off))
    (message "Turned  %s pretty printing."
             (if cider-repl-use-pretty-printing 'on 'off))))

(advice-add 'cider-repl-toggle-pretty-printing :after
            #'ems--cider-repl-toggle-pretty-printing-after)

;;;  find:

(defun ems--cider-find-var-after (&rest _)
  "speak."
  (when (ems-interactive-p)
               (emacsvox-speak-line)))

(cl-loop
 for f in
 '(cider-find-var cider-find-resource cider-find-ns)
 do
 (advice-add f :after #'ems--cider-find-var-after))

;;;  misc commands:
(defun ems--cider-popup-buffer-quit-function-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (with-current-buffer (window-buffer (selected-window))
         (emacsvox-icon 'close-object)
         (emacsvox-speak-mode-line))))

(cl-loop
 for f in
 '(cider-popup-buffer-quit-function cider-popup-buffer-quit)
 do
 (advice-add f :after #'ems--cider-popup-buffer-quit-function-after))

(defun ems--cider-connections-goto-connection-after (&rest _)
  "speak."
  (when (ems-interactive-p)
    (emacsvox-speak-mode-line) (emacsvox-icon 'open-object)))

(advice-add 'cider-connections-goto-connection :after
            #'ems--cider-connections-goto-connection-after)

(defun ems--cider-connect-after (&rest _)
  "speak."
  (when (ems-interactive-p)
    (emacsvox-speak-mode-line) (emacsvox-icon 'open-object)))

(advice-add 'cider-connect :after #'ems--cider-connect-after)

(defun ems--cider-close-nrepl-session-after (&rest _)
  "speak."
  (when (ems-interactive-p)
    (emacsvox-icon 'close-object) (message "Closed Repl Session")))

(advice-add 'cider-close-nrepl-session :after
            #'ems--cider-close-nrepl-session-after)

(defun ems--cider-close-ancillary-buffers-after (&rest _)
  "speak."
  (when (ems-interactive-p)
    (emacsvox-icon 'close-object)
    (message "Closed ancillary buffers")))

(advice-add 'cider-close-ancillary-buffers :after
            #'ems--cider-close-ancillary-buffers-after)

(defun ems--cider-describe-nrepl-session-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (emacsvox-icon 'open-object)
       (message "Displayed in other window.")))

(cl-loop
 for f in
 '(cider-describe-nrepl-session cider-connection-browser cider-display-connection-info)
 do
 (advice-add f :after #'ems--cider-describe-nrepl-session-after))

;;;  Speech-enable Debug:
(defun ems--cider-debug-defun-at-point-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (emacsvox-speak-line)
       (emacsvox-icon 'button)))

(cl-loop
 for f in
 '(cider-debug-defun-at-point cider-debug-move-here cider-debug-toggle-locals)
 do
 (advice-add f :after #'ems--cider-debug-defun-at-point-after))

;;;  Speech-enable Insert:

(defun ems--cider-insert-defun-in-repl-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (emacsvox-speak-line)
       (emacsvox-icon 'yank-object)))

(cl-loop
 for f in
 '(cider-insert-defun-in-repl cider-insert-last-sexp-in-repl cider-insert-ns-form-in-repl cider-insert-region-in-repl)
 do
 (advice-add f :after #'ems--cider-insert-defun-in-repl-after))

;;;  Inspect And Inspector:

(defun ems--cider-inspector-refresh-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (emacsvox-icon 'open-object)
       (emacsvox-speak-mode-line)))

(cl-loop
 for f in
 '(cider-inspector-refresh cider-inspect cider-inspect-defun-at-point cider-inspect-expr cider-inspect-last-result cider-inspect-last-sexp cider-inspect-read-and-inspect cider-inspector-pop)
 do
 (advice-add f :after #'ems--cider-inspector-refresh-after))
(defun ems--cider-inspector-next-inspectable-object-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (emacsvox-icon 'select-object)
       (emacsvox-speak-line)))

(cl-loop
 for f in
 '(cider-inspector-next-inspectable-object cider-inspector-next-page cider-inspector-operate-on-click cider-inspector-operate-on-point cider-inspector-prev-page cider-inspector-previous-inspectable-object cider-stacktrace-cycle-current-cause cider-stacktrace-cycle-all-causes cider-stacktrace-cycle-cause-1 cider-stacktrace-cycle-cause-2 cider-stacktrace-cycle-cause-3 cider-stacktrace-cycle-cause-4 cider-stacktrace-cycle-cause-5 cider-stacktrace-next-cause cider-stacktrace-previous-cause cider-stacktrace-jump)
 do
 (advice-add f :after #'ems--cider-inspector-next-inspectable-object-after))

(provide 'emacsvox-cider)
;;;  end of file

