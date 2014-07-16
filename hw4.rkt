
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file


; 1
(define (sequence low high stride)
  (if (<= low high)
    (cons low (sequence (+ low stride) high stride))
    null))
