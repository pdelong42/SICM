(define
   (  (L-free-particle mass) local)
   (let
      (  (v (velocity local)))
      (* 1/2 mass (dot-product v v))  )  )

(define q
   (up
      (literal-function 'x)
      (literal-function 'y)
      (literal-function 'z)  )  )

(define demo1a (q 't))

(define demo1b ((D q) 't))

(define demo1c ((Gamma q) 't))

(define demo1d
   (  (compose
         (L-free-particle 'm)
         (Gamma q)  )
      't  )  )

;(show-expression demo1d)

(define
   (Lagrangian-action L q t1 t2)
   (definite-integral (compose L (Gamma q)) t1 t2)  )

(define
   (test-path t)
   (up
      (+ (* 4 t) 7)
      (+ (* 3 t) 5)
      (+ (* 2 t) 1)  )  )

(define demo1e (Lagrangian-action (L-free-particle 3.0) test-path 0.0 10.0))

(define
   (  (make-eta nu t1 t2) t)
   (*
      (- t t1)
      (- t t2)
      (nu t)  )  )

(define
   (  (varied-free-particle-action mass q nu t1 t2) eps  )
   (let
      (  (eta (make-eta nu t1 t2)))
      (Lagrangian-action
         (L-free-particle mass)
         (+ q (* eps eta))
         t1
         t2  )  )  )

(define demo1f
   (  (varied-free-particle-action 3.0 test-path (up sin cos square) 0.0 10.0) 0.001  )  )

(define demo1g
   (minimize (varied-free-particle-action 3.0 test-path (up sin cos square) 0.0 10.0) -2.0 1.0)  )

(define
   (  (parametric-path-action Lagrangian t0 q0 t1 q1) qs)
   (let
      (  (path (make-path t0 q0 t1 q1 qs)))
      (Lagrangian-action Lagrangian path t0 t1)  )  )

(define
   (find-path Lagrangian t0 q0 t1 q1 n)
   (let
      (  (initial-qs (linear-interpolants q0 q1 n)))
      (let
         (  (minimizing-qs (multidimensional-minimize (parametric-path-action Lagrangian t0 q0 t1 q1) initial-qs)))
         (make-path t0 q0 t1 q1 minimizing-qs)  )  )  )

(define
   (  (L-harmonic m k) local)
   (let
      (  (q (coordinate local))
         (v (velocity   local))  )
      (- (* 1/2 m (square v))
         (* 1/2 k (square q))  )  )  )

(define q (find-path (L-harmonic 1.0 1.0) 0. 1. :pi/2 0. 3))

; ToDo: take the following definitions, up to and including demo1h,
; and encapsulate them into a single variable such that none of the
; code gets evaulated unless that variable is.

(define win2 (frame 0. :pi/2 0. 1.2))

(define
   (  (parametric-path-action Lagrangian t0 q0 t1 q1) intermediate-qs)
   (let
      (  (path (make-path t0 q0 t1 q1 intermediate-qs)))
      (graphics-clear win2)
      (plot-function win2 path t0 t1 (/ (- t1 t0) 100))
      (Lagrangian-action Lagrangian path t0 t1)  )  )

(define demo1h
  (find-path (L-harmonic 1. 1.) 0. 1. :pi/2 0. 2)  )

(define
   ((Lagrange-equations Lagrangian) q)
   (- (D (compose ((partial 2) Lagrangian) (Gamma q)))
         (compose ((partial 1) Lagrangian) (Gamma q))  )  )

(define
   (test-path t)
   (up
      (+ (* 'a t) 'a0)
      (+ (* 'b t) 'b0)
      (+ (* 'c t) 'c0)  )  )

(define demo1i (((Lagrange-equations (L-free-particle 'm)) test-path) 't))

;(print-expression demo1i)

(define demo1j
   (  (  (Lagrange-equations (L-free-particle 'm))
         (literal-function 'x)  ) 't  )  )

;(show-expression demo1j)

(define
   (proposed-solution t)
   (* 'A (cos (+ (* 'omega t) 'phi)))  )

(define demo1k
   (((Lagrange-equations (L-harmonic 'm 'k)) proposed-solution) 't)  )

;(show-expression demo1k)

(define
   ((L-central-polar m V) local)
   (let
      (  (q (coordinate local))
         (qdot (velocity local))  )
      (let
         (  (r (ref q 0))
            (phi (ref q 1))
            (rdot (ref qdot 0))
            (phidot (ref qdot 1))  )
         (- (* 1/2 m
               (+ (square rdot)
                  (square (* r phidot))  )  )
            (V r)  )  )  )  )

(define
   ((gravitational-energy G m1 m2) r)
   (- (/ (* G m1 m2) r))  )
