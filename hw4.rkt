
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
        
; 4
(define (stream-for-n-steps s n)
  (if (<= n 0)
      null
      (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))))

; 5
(define (funny-number-stream)
  (define (stream x)
    (cons (if (= (remainder x 5) 0) (- x) x)
          (lambda () (stream (+ x 1)))))
  (stream 1))

; 6
(define (dan-than-dog)
  (define (stream x)
    (cons x
          (lambda ()
            (stream (if (equal? x "dan.jpg") "dog.jpg" "dan.jpg")))))
  (stream "dan.jpg"))

; 7
(define (stream-add-zero s)
  (lambda ()
    (cons (cons 0 (car (s)))
          (stream-add-zero (cdr (s))))))

; 8
(define (cycle-lists xs ys)
  (define (stream n)
    (lambda ()
      (cons (cons (list-ref xs (remainder n (length xs)))
                  (list-ref ys (remainder n (length ys))))
            (stream (+ n 1)))))
  (stream 0))
