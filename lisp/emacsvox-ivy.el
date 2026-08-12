;;; emacsvox-ivy.el --- Speech-enable IVY  -*- lexical-binding: t; -*-
;; $Author: tv.raman.tv $
;; Description:  Speech-enable IVY An Emacs Interface to ivy
;; Keywords: Emacsvox,  Audio Desktop ivy
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
;; MERCHANTABILITY or FITNIVY FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; Commentary:
;; IVY ==  One More Smart Completion Technique 
;; Speech-enable ivy-style completion.
;; This is still experimental and preliminary.
;; 
;;; Code:

;;   Required modules:

(eval-when-compile (require 'cl-lib))
(cl-declaim  (optimize  (safety 0) (speed 3)))
(require 'emacsvox-preamble)

;;;  Map Faces:

(voice-setup-add-map 
 '(
   (ivy-action voice-animate)
   (ivy-confirm-face voice-bolden)
   (ivy-current-match voice-lighten)
   (ivy-cursor voice-smoothen)
   (ivy-match-required-face voice-bolden-extra)
   (ivy-minibuffer-match-face-1 voice-monotone-extra)
   (ivy-minibuffer-match-face-2 voice-monotone-medium)
   (ivy-minibuffer-match-face-3 voice-monotone-medium)
   (ivy-minibuffer-match-face-4 voice-monotone-extra)
   (ivy-modified-buffer voice-bolden-and-animate)
   (ivy-remote voice-lighten)
   (ivy-subdir voice-smoothen)
   (ivy-virtual voice-animate)))

;;;  Interactive Commands:

(defun ems--ivy-switch-buffer-other-window-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (with-current-buffer (window-buffer (selected-window))
         (emacsvox-speak-mode-line))))

(cl-loop
 for f in
 '(ivy-switch-buffer-other-window ivy-switch-buffer)
 do
 (advice-add f :after #'ems--ivy-switch-buffer-other-window-after))

(defun ems--ivy-done-after (&rest _)
  "speak."
  (when (ems-interactive-p)
       (emacsvox-icon 'close-object)))

(cl-loop
 for f in
 '(ivy-done ivy-alt-done ivy-immediate-done)
 do
 (advice-add f :after #'ems--ivy-done-after))

(defun emacsvox-ivy-speak-selection ()
  "Speak current ivy selection."
  
  (dtk-speak
   (format
    "%d: %s"
    ivy--length
    (elt ivy--old-cands ivy--index))))

(defun ems--ivy-beginning-of-buffer-after (&rest _)
  "Speak selection."
  (when (ems-interactive-p)
       (emacsvox-ivy-speak-selection)
       (emacsvox-icon 'select-object)))

(cl-loop
 for f in
 '(ivy-beginning-of-buffer ivy-end-of-buffer ivy-next-line ivy-previous-line)
 do
 (advice-add f :after #'ems--ivy-beginning-of-buffer-after))

(defun ems--ivy--exhibit-after (&rest _)
  "Speak updated Ivy list." (emacsvox-ivy-speak-selection)
  (sit-for 5) (emacsvox-speak-rest-of-buffer))

(advice-add 'ivy--exhibit :after #'ems--ivy--exhibit-after)

(defun ems--ivy-read-before (prompt &rest _)
  "Speak prompt" (emacsvox-icon 'open-object)
  (dtk-speak prompt))

(advice-add 'ivy-read :before #'ems--ivy-read-before)

(provide 'emacsvox-ivy)
;;;  end of file

