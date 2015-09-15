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
      (  (q  (coordinate local))
         (qdot (velocity local))  )
      (let
         (  (r      (ref q    0))
            (phi    (ref q    1))
            (rdot   (ref qdot 0))
            (phidot (ref qdot 1))  )
         (- (* 1/2 m
               (+ (square rdot)
                  (square (* r phidot))  )  )
            (V r)  )  )  )  )

(define
   ((gravitational-energy G m1 m2) r)
   (- (/ (* G m1 m2) r))  )

(define
   ((L-uniform-acceleration m g) local)
   (let
      (  (q  (coordinate local))
         (v  (velocity   local))  )
      (let
         ((y (ref q 1)))
         (- (* 1/2 m (square v))
            (* m g y)  )  )  )  )

(define demo1l
   (  ((Lagrange-equations (L-uniform-acceleration 'm 'g))
      (up
         (literal-function 'x)
         (literal-function 'y)  )  ) 't  )  )

;(show-expression demo1l)

(define
   ((L-central-rectangular m U) local)
   (let
      (  (q (coordinate local))
         (v (velocity   local))  )
      (- (* 1/2 m (square v))
         (U (sqrt (square q)))  )  )  )

(define demo1m
   (  (  (Lagrange-equations (L-central-rectangular 'm (literal-function 'U)))
         (up
            (literal-function 'x)
            (literal-function 'y)  )  )
         't  )  )

;(show-expression demo1m)

(define
   ((L-central-polar m U) local)
   (let
      (  (q  (coordinate local))
         (qdot (velocity local))  )
      (let
         (  (r      (ref q    0))
            (phi    (ref q    1))
            (rdot   (ref qdot 0))
            (phidot (ref qdot 1))  )
         (- (* 1/2 m
               (+ (square rdot)
                  (square (* r phidot))  )  )
            (U r)  )  )  )  )


(define demo1n
   (  ((Lagrange-equations (L-central-polar 'm (literal-function 'U)))
      (up
         (literal-function 'r)
         (literal-function 'phi)  )  ) 't  )  )

;(show-expression demo1n)

(define
   ((F->C F) local)
   (up
      (time local)
      (F    local)
      (+    (((partial 0) F) local)
         (* (((partial 1) F) local)
            (velocity        local)  )  )  )  )

(define
   (p->r local)
   (let
      (  (polar-tuple (coordinate local)))
      (let
         (  (r   (ref polar-tuple 0))
            (phi (ref polar-tuple 0))  )
         (let
            (  (x (* r (cos phi)))
               (y (* r (sin phi)))  )
            (up x y)  )  )  )  )

(define demo1o
   (velocity
      (  (F->C p->r)
         (up 't
            (up 'r    'phi)
            (up 'rdot 'phidot)  )  )  )  )

;(show-expression demo1o)

(define
   (L-central-polar m U)
   (compose
      (L-central-rectangular m U)
      (F->C p->r)  )  )

(define demo1p
   (  (L-central-polar 'm (literal-function 'U))
      (up 't
         (up 'r    'phi)
         (up 'rdot 'phidot)  )  )  )

;(show-expression demo1p)

(define
   ((L-free-rectangular m) local)
   (let
      (  (vx (ref (velocities local) 0))
         (vy (ref (velocities local) 1))  )
      (* 1/2 m (+ (square vx) (square vy)))  )  )

(define
   (L-free-polar m)
   (compose
      (L-free-rectangular m)
      (F->C p->r)  )  )

(define
   ((F Omega) local)
   (let
      (  (t                 (time local))
         (r     (ref (coordinates local) 0))
         (theta (ref (coordinates local) 1))  )
      (up r (+ theta (* Omega t)))  )  )

(define
   (L-rotating-polar m Omega)
   (compose
      (L-free-polar m)
      (F->C (F Omega))  )  )

(define
   (L-rotating-rectangular m Omega)
   (compose
      (L-rotating-polar m Omega)
      (F->C r->p)  )  )

(define demo1q
   (  (L-rotating-rectangular 'm 'Omega)
      (up 't
         (up    'x_r    'y_r)
         (up 'xdot_r 'ydot_r)  )  )  )

(define demo1r
   (  (  (Lagrange-equations (L-rotating-rectangular 'm 'Omega))
         (up
            (literal-function 'x_r)
            (literal-function 'y_r)  )  )
      't  )  )

(define
   (  (T-pend m l g ys) local)
   (let*
      (  (t            (time local))
         (theta  (coordinate local))
         (thetadot (velocity local))
         (vys (D ys))
         (vyst (vys t))  )
      (* 1/2 m
         (+ (square (* l thetadot))
            (square vyst)
            (* 2 l vyst thetadot (sin theta))  )  )  )  )

(define
   (  (V-pend m l g ys) local)
   (let*
      (  (t           (time local))
         (theta (coordinate local))
         (yst (ys t))  )
      (* m g (- yst (* l (cos theta))))  )  )

(define L-pend (- T-pend V-pend))

(define demo1s
   (  (  (Lagrange-equations (L-pend 'm 'l 'g (literal-function 'y_s)))
         (literal-function 'theta)  )  't  )  )

;(show-expression demo1s)
