(define (split-at-front lst n)
  (if (or (null? lst) (= n 0)) nil
    (cons (car lst) (split-at-front (cdr lst) (- n 1)))
  )
)

(define (split-at-end lst n)
  (if (null? lst) nil
    (if (= n 0) lst
      (split-at-end (cdr lst) (- n 1))
    )
  )
)

(define (split-at lst n) (cons (split-at-front lst n) (split-at-end lst n)))

(define (compose-all funcs)
  (if (null? funcs) (lambda (x) x)
    (lambda (x) ((compose-all (cdr funcs)) ((car funcs) x)))
  )
)