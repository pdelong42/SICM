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

;; This works in MacOS X, but not in Linux
(show-expression
   (  (compose
         (L-free-particle 'm)
         (Gamma q)
      )
      't
   )
)

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

; this works in Linux, but not in MacOS X, and I don't know why
(Lagrangian-action
   (L-free-particle 3.0)
   test-path
   0.0
   10.0
)

(define
   (  (make-eta nu t1 t2) t)
   (*
      (- t t1)
      (- t t2)
      (nu t)
   )
)

(define
   (  (varied-free-particle-action mass q nu t1 t2) epsilon)
   (let
      (  (eta (make-eta nu t1 t2)))
      (Lagrangian-action
         (L-free-particle mass)
         (+ q (* epsilon eta))
         t1
         t2
      )
   )
)

(  (varied-free-particle-action 3.0 test-path (up sin cos square) 0.0 10.0) 0.001)

(minimize (varied-free-particle-action 3.0 test-path (up sin cos square) 0.0 10.0) -2.0 1.0)
