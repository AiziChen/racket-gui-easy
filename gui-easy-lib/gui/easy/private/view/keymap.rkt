#lang racket/base

(require racket/class
         (prefix-in gui: racket/gui))

(provide
 the-default-keymap)

(define the-default-keymap
  (new gui:keymap%))

(define (add&map keyname name proc [k the-default-keymap])
  (define name-str (symbol->string name))
  (send k add-function name-str proc)
  (send k map-function keyname name-str))

(when (eq? 'macosx (system-type 'os))
  (add&map "c:a" 'goto-start (λ (editor _event)
                               (send editor set-position 0)))
  (add&map "c:e" 'goto-end (λ (editor _event)
                             (send editor set-position (send editor last-position))))
  (add&map "d:a" 'select-all (λ (editor _event)
                               (send editor do-edit-operation 'select-all)))
  (add&map "d:c" 'copy-selection (λ (editor _event)
                                   (send editor do-edit-operation 'copy)))
  (add&map "d:x" 'cut-selection (λ (editor _event)
                                   (send editor do-edit-operation 'cut)))
  (add&map "d:v" 'paste-all (λ (editor _event)
                              (send editor do-edit-operation 'paste)))
  (add&map "d:z" 'undo (λ (editor _event)
                              (send editor do-edit-operation 'undo)))
  (add&map "d:y" 'redo (λ (editor _event)
                              (send editor do-edit-operation 'redo))))
(when (or (eq? 'windows (system-type 'os))
          (eq? 'unix (system-type 'os)))
  (add&map "c:a" 'select-all (λ (editor _event)
                               (send editor do-edit-operation 'select-all)))
  (add&map "c:c" 'copy-selection (λ (editor _event)
                                   (send editor do-edit-operation 'copy)))
  (add&map "c:x" 'cut-selection (λ (editor _event)
                                   (send editor do-edit-operation 'cut)))
  (add&map "c:v" 'paste-all (λ (editor _event)
                              (send editor do-edit-operation 'paste)))
  (add&map "c:z" 'undo (λ (editor _event)
                              (send editor do-edit-operation 'undo)))
  (add&map "c:y" 'redo (λ (editor _event)
                              (send editor do-edit-operation 'redo))))
