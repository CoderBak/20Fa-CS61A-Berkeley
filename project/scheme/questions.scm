(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement

(define (zip_first pairs)
  (cond 
    ((null? pairs) nil)
    (else (cons (car (car pairs)) (zip_first (cdr pairs))))
  )
)

(define (zip_sec pairs)
  (cond 
    ((null? pairs) nil)
    (else (cons (car (cdr (car pairs))) (zip_sec (cdr pairs))))
  )
)

(define (zip pairs)
  (list (zip_first pairs) (zip_sec pairs))
)

;; Problem 15
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 15
  (define (enumerate-helper start s)
    (if (null? s) nil
      (cons (cons start (cons (car s) nil)) (enumerate-helper (+ start 1) (cdr s)))
    )
  )
  (enumerate-helper 0 s)
)
  ; END PROBLEM 15

;; Problem 16

;; Merge two lists LIST1 and LIST2 according to COMP and return
;; the merged lists.
(define (merge comp list1 list2)
  (cond
    ((null? list1) list2)
    ((null? list2) list1)
    ((comp (car list1) (car list2)) (cons (car list1) (merge comp (cdr list1) list2)))
    (else (cons (car list2) (merge comp list1 (cdr list2))))
  )
)
  ; END PROBLEM 16


(merge < '(1 5 7 9) '(4 8 10))
; expect (1 4 5 7 8 9 10)
(merge > '(9 7 5 1) '(10 8 4 3))
; expect (10 9 8 7 5 4 3 1)

;; Problem 17

(define (longest_nondecrease s)
  (cond
    ((null? s) 0)
    ((null? (cdr s)) 1)
    ((> (car s) (car (cdr s))) 1)
    (else (+ 1 (longest_nondecrease (cdr s))))
  )
)

(define (get_longest s)
    (define (get_first_cnt s cnt)
      (cond
        ((null? s) nil)
        ((= cnt 0) nil)
        (else (cons (car s) (get_first_cnt (cdr s) (- cnt 1))))
      )
    )
    (get_first_cnt s (longest_nondecrease s))
)

(define (start_from s start)
  (cond
    ((null? s) nil)
    ((= start 0) s)
    (else (start_from (cdr s) (- start 1)))
  )
)

(define (nondecreaselist s)
    ; BEGIN PROBLEM 17
    (cond
      ((null? s) nil)
      (else (cons (get_longest s) (nondecreaselist (start_from s (longest_nondecrease s)))))
    )
)
    ; END PROBLEM 17

;; Problem EC
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM EC
          expr
         ; END PROBLEM EC
         )
        ((quoted? expr)
         ; BEGIN PROBLEM EC
          expr
         ; END PROBLEM EC
         )
        ((or (lambda? expr)   ; lambda and define should not change
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM EC
           (append (list form params) (map let-to-lambda body))
           ; END PROBLEM EC
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr))
               (form (car (zip (cadr expr))))
               (params (map let-to-lambda (cadr (zip (cadr expr))))))
           ; BEGIN PROBLEM EC
           (cons (append (list 'lambda form) (map let-to-lambda body)) params)
           ; END PROBLEM EC
           ))
        (else
         ; BEGIN PROBLEM EC
         (map let-to-lambda expr)
         ; END PROBLEM EC
         )))

