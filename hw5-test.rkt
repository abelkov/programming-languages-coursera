#lang racket

(require rackunit
         "hw5.rkt")

; a test case that uses problems 1, 2, and 4
; should produce (list (int 10) (int 11) (int 16))
;(define test1
;  (mupllist->racketlist
;   (eval-exp (call (call mupl-mapAddN (int 7))
;                   (racketlist->mupllist 
;                    (list (int 3) (int 4) (int 9)))))))



; 1
(define mlist (apair (int 1) (apair (int 2) (aunit))))
(define rlist (list (int 1) (int 2)))
(check-equal? (mupllist->racketlist mlist) rlist)
(check-equal? (racketlist->mupllist rlist) mlist)
