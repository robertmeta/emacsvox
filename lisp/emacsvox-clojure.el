;;; emacsvox-clojure.el --- Speech-enable CLOJURE -*- lexical-binding: t; -*-
;; $Author: tv.raman.tv $
;; Description:  Speech-enable CLOJURE-mode
;; Keywords: Emacsvox,  Audio Desktop clojure
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
;; MERCHANTABILITY or FITNCLOJURE FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; Commentary:
;; CLOJURE-mode: Specialized mode for Clojure programming.

;;; Code:

;;   Required modules:

(eval-when-compile (require 'cl-lib))
(cl-declaim  (optimize  (safety 0) (speed 3)))
(require 'emacsvox-preamble)

;;;  Map Faces:

(voice-setup-add-map
 '(
   (clojure-interop-method-face  voice-lighten)
   (clojure-character-face voice-bolden-medium)
   (clojure-keyword-face voice-animate)))

;;;  Speech-enable Editing:

(defun ems--clojure-toggle-keyword-string-after (&rest _)
  "speak."
  (when (ems-interactive-p)
    (emacsvox-speak-line) (emacsvox-icon 'button)))

(advice-add 'clojure-toggle-keyword-string :after
            #'ems--clojure-toggle-keyword-string-after)

(defun ems--clojure-cycle-not-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (emacsvox-icon 'button)
       (emacsvox-speak-line)))

(cl-loop
 for f in
 '(clojure-cycle-not clojure-cycle-when)
 do
 (advice-add f :after #'ems--clojure-cycle-not-after))

(defun ems--clojure-view-cheatsheet-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (emacsvox-icon 'open-object)
       (emacsvox-speak-buffer)))

(cl-loop
 for f in
 '(clojure-view-cheatsheet clojure-view-grimoire clojure-view-guide clojure-view-reference-section clojure-view-style-guide)
 do
 (advice-add f :after #'ems--clojure-view-cheatsheet-after))

(defun ems--clojure-forward-logical-sexp-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (emacsvox-icon 'large-movement)
       (emacsvox-speak-line)))

(cl-loop
 for f in
 '(clojure-forward-logical-sexp clojure-backward-logical-sexp)
 do
 (advice-add f :after #'ems--clojure-forward-logical-sexp-after))

(defun ems--clojure-align-after (&rest _)
  "speak." (when (ems-interactive-p) (emacsvox-icon 'fill-object)))

(advice-add 'clojure-align :after #'ems--clojure-align-after)

(defun ems--clojure-insert-ns-form-at-point-after (&rest _)
  "Provide Auditory feedback."
  (when (ems-interactive-p)
       (emacsvox-speak-line)
       (emacsvox-icon 'select-object)))

(cl-loop
 for f in
 '(clojure-insert-ns-form-at-point clojure-insert-ns-form)
 do
 (advice-add f :after #'ems--clojure-insert-ns-form-at-point-after))
(defun ems--clojure-cycle-if-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (emacsvox-speak-line)))

(cl-loop
 for f in
 '(clojure-cycle-if clojure-cycle-privacy clojure-introduce-let clojure-move-to-let clojure-let-backward-slurp-sexp clojure-let-forward-slurp-sexp)
 do
 (advice-add f :after #'ems--clojure-cycle-if-after))
;; Catch-all for now:

(defun ems--clojure-thread-after (&rest _)
  "Provide place-holder auditory feedback."
  (when (ems-interactive-p)
       (emacsvox-speak-line)))

(cl-loop
 for f in
 '(clojure-thread clojure-thread-first-all clojure-thread-last-all clojure-unwind clojure-unwind-all)
 do
 (advice-add f :after #'ems--clojure-thread-after))

;;;  Speech-Enable Refactoring:

(defun ems--clojure-convert-collection-to-list-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (let ((begin (point)))
         (forward-sexp)
         (dtk-speak(buffer-substring begin (point))))))

(cl-loop
 for f in
 '(clojure-convert-collection-to-list clojure-convert-collection-to-map clojure-convert-collection-to-quoted-list clojure-convert-collection-to-set clojure-convert-collection-to-vector)
 do
 (advice-add f :after #'ems--clojure-convert-collection-to-list-after))

(provide 'emacsvox-clojure)
;;;  end of file

