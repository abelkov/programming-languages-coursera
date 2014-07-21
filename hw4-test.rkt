#lang racket

(require rackunit
         "hw4.rkt") 

;; A simple library for displaying a 2x3 grid of pictures: used
;; for fun in the tests below (look for "Tests Start Here").

(require (lib "graphics.rkt" "graphics"))

(open-graphics)

(define window-name "Programming Languages, Homework 4")
(define window-width 700)
(define window-height 500)
(define border-size 100)

(define approx-pic-width 200)
(define approx-pic-height 200)
(define pic-grid-width 3)
(define pic-grid-height 2)

(define (open-window)
  (open-viewport window-name window-width window-height))

(define (grid-posn-to-posn grid-posn)
  (when (>= grid-posn (* pic-grid-height pic-grid-width))
    (error "picture grid does not have that many positions"))
  (let ([row (quotient grid-posn pic-grid-width)]
        [col (remainder grid-posn pic-grid-width)])
    (make-posn (+ border-size (* approx-pic-width col))
               (+ border-size (* approx-pic-height row)))))

(define (place-picture window filename grid-posn)
  (let ([posn (grid-posn-to-posn grid-posn)])
    ((clear-solid-rectangle window) posn approx-pic-width approx-pic-height)
    ((draw-pixmap window) filename posn)))

(define (place-repeatedly window pause stream n)
  (when (> n 0)
    (let* ([next (stream)]
           [filename (cdar next)]
           [grid-posn (caar next)]
           [stream (cdr next)])
      (place-picture window filename grid-posn)
      (sleep pause)
      (place-repeatedly window pause stream (- n 1)))))

;; Tests Start Here

; These definitions will work only after you do some of the problems
; so you need to comment them out until you are ready.
; Add more tests as appropriate, of course.

(check-equal? (sequence 0 3 1) '(0 1 2 3) "1a")
(check-equal? (sequence 3 8 3) '(3 6) "1b")
(check-equal? (sequence 3 2 1) '() "1c")

(check-equal? (string-append-map '["not" "quite" "pig" "latin"] "ey") '["notey" "quiteey" "pigey" "latiney"] "2a")

(check-equal? (list-nth-mod '["she" "loves" "you"] 7) "loves" "3a")

(define ones (lambda () (cons 1 ones)))

(check-equal? (stream-for-n-steps ones 5) '(1 1 1 1 1))

(check-equal? (stream-for-n-steps funny-number-stream 11) '(1 2 3 4 -5 6 7 8 9 -10 11))

(check-equal? (stream-for-n-steps dan-than-dog 4) '("dan.jpg" "dog.jpg" "dan.jpg" "dog.jpg"))

(check-equal? (stream-for-n-steps (stream-add-zero ones) 2) '((0 . 1) (0 . 1)))
(check-equal? (stream-for-n-steps (stream-add-zero dan-than-dog) 2) '((0 . "dan.jpg") (0 . "dog.jpg")))

(define x '(1 2 3))
(define y '('a 'b))
(check-equal? (stream-for-n-steps (cycle-lists x y) 4) '((1 . 'a) (2 . 'b) (3 . 'a) (1 . 'b)))

(define vec #((1 . 'a) (2 . 'b) 'c 'd (3 . e) (4 . f)))
(check-equal? (vector-assoc 3 vec) '(3 . e))

; 10
(define cache-test (cached-assoc (list (cons 1 2) (cons 2 4) (cons 3 8) (cons 4 16) (cons 5 32) (cons 6 64)) 3))
(check-equal? (cache-test 3) (cons 3 8))
(check-equal? (cache-test 1) (cons 1 2))
(check-equal? (cache-test 2) (cons 2 4))
(check-equal? (cache-test 4) (cons 4 16))
(check-equal? (cache-test 5) (cons 5 32))
(check-equal? (cache-test 4) (cons 4 16))


;(define files (string-append-map 
;               (list "dan" "dog" "curry" "dog2") 
;               ".jpg"))
;
;(define funny-test (stream-for-n-steps funny-number-stream 16))
;
;; a zero-argument function: call (one-visual-test) to open the graphics window, etc.
;(define (one-visual-test)
;  (place-repeatedly (open-window) 0.5 (cycle-lists nums files) 27))
;
;; similar to previous but uses only two files and one position on the grid
;(define (visual-zero-only)
;  (place-repeatedly (open-window) 0.5 (stream-add-zero dan-then-dog) 27))
