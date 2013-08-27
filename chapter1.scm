(define
   ((L-free-particle-mass) local)
   (let
      ((v (velocity local)))
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
