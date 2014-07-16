
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file


; 1
(define (sequence low high stride)
  (if (<= low high)
    (cons low (sequence (+ low stride) high stride))
    null))


; 2
(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))


; 3
(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [else (list-ref xs (remainder n (length xs)))]))
        