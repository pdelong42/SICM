;
; Functional Differential Geometry

; Prologue

(define
   (  (Lagrange-equations Lagrangian) w  )
      (- (D (compose ((partial 2) Lagrangian) (Gamma w)))
         (compose ((partial 1) Lagrangian) (Gamma w))))

(define
   (  (Gamma w) t  )
   (up t (w t) ((D w) t))  )

(define
   (  (L-harmonic m k) local  )
   (let
      (  (q (coordinate local))
         (v (velocity local))  )
      (- (* 1/2 m (square v))
         (* 1/2 k (square q))  )  )  )

(define
   (proposed-solution t)
   (* 'a (cos (+ (* 'omega t) 'phi)))  )

(define demo0a
   (((Lagrange-equations (L-harmonic 'm 'k)) proposed-solution) 't)  )

(define demo0b
   (  (  (Lagrange-equations (L-harmonic 'm 'k))
         (literal-function 'x)  )
      't  )  )

; Chapter 1

(define
   (  (Lfree mass) state  )
   (* 1/2 mass (square (velocity state)))  )

(define
   (  (sphere->R3 R) state  )
   (let
      (  (q (coordinate state)))
      (let
         (  (theta (ref q 0))
            (phi   (ref q 1))  )
         (up
            (* R (sin theta) (cos phi))
            (* R (sin theta) (sin phi))
            (* R (cos theta))  )  )  )  )

(define
   (  (F->C F) state  )
   (up
      (time state)
      (F state)
      (+ (((partial 0) F) state)
         (* (((partial 1) F) state)
            (velocity state)  )  )  )  )

(define
   (Lsphere m R)
   (compose (Lfree m) (F->C (sphere->R3 R)))  )

(define demo1a (up 't (up 'theta 'phi) (up 'thetadot 'phidot)))

(define temp1a (((partial 1) (sphere->R3 'R)) demo1a))

(define temp1b (define temp1b (* temp1a (velocity demo1a))))

(define demo1b ((Lsphere 'm 'R) demo1a))

(define
   ((L2 mass metric) place velocity)
   (* 1/2 mass ((metric velocity velocity) place))  )

(define
   (  (Lc mass metric coordsys) state  )
   (let
      (  (x (coordinates state))
         (v (velocities  state))
         (e (coordinate-system->vector-basis coordsys))  )
      (  (L2 mass metric)
         ((point coordsys) x)
         (* e v)  )  )  )

(define the-metric (literal-metric 'g R2-rect))

(define L (Lc 'm the-metric R2-rect))

(define demo1c (L (up 't (up 'x 'y) (up 'vx 'vy))))

(define gamma (literal-manifold-map 'q R1-rect R2-rect))

(define demo1d
   (  (chart R2-rect)
      (gamma ((point R1-rect) 't))  )  )

(define coordinate-path
   (compose
      (chart R2-rect)
      gamma
      (point R1-rect)  )  )

(define demo1e (coordinate-path 't))

(define Lagrange-residuals
   (((Lagrange-equations L) coordinate-path) 't)  )

(define-coordinates t R1-rect)

(define Cartan
   (Christoffel->Cartan (metric->Christoffel-2 the-metric (coordinate-system->basis R2-rect)))  )

(define geodesic-equation-residuals
   (  (  (  ((covariant-derivative Cartan gamma) d/dt)
            ((differential gamma) d/dt)  )
         (chart R2-rect)  )
      (  (point R1-rect) 't)  )  )

(define metric-components
   (metric->components the-metric (coordinate-system->basis R2-rect))  )

(define demo1f
   (- Lagrange-residuals
      (* (* 'm (metric-components (gamma ((point R1-rect) 't)))) geodesic-equation-residuals)  )  )

; Chapter 2

(define R2 (make-manifold R^n 2))

(define U (patch 'origin R2))

(define R2-rect  (coordinate-system 'rectangular       U))
(define R2-polar (coordinate-system 'polar/cylindrical U))

(define R2-rect-chi          (chart R2-rect))
(define R2-rect-chi-inverse  (point R2-rect))
(define R2-polar-chi         (chart R2-polar))
(define R2-polar-chi-inverse (point R2-polar))
