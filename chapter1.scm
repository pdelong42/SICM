(define
   (  (L-free-particle mass) local)
   (let
      (  (v (velocity local)))
      (* 1/2 mass (dot-product v v))
   )
)

(define q
   (up
      (literal-function 'x)
      (literal-function 'y)
      (literal-function 'z)
   )
)

(print-expression (q 't))

(print-expression ((D q) 't))

(print-expression
   (  (compose
         (L-free-particle 'm)
         (Gamma q)
      )
      't
   )
)

;(show-expression
;   (  (compose
;         (L-free-particle 'm)
;         (Gamma q)
;      )
;      't
;   )
;)

(define
   (Lagrangian-action L q t1 t2)
   (definite-integral (compose L (Gamma q)) t1 t2)
)

(define
   (test-path t)
   (up
      (+ (* 4 t) 7)
      (+ (* 3 t) 5)
      (+ (* 2 t) 1)
   )
)

(Lagrangian-action
   (L-free-particle 3.0)
   test-path
   0.0
   10.0
)
