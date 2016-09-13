; These are some examples from Chapter 5 of "Calculus of Variations", by Lev D.
; Elsgolc (ISBN 978-0486457994).
;
; ToDo: indicate exactly which example this is.
;
; I'm doing this in scmutils, because after the sixth or seventh time
; of working through the tedious algebra myself, and getting a new
; wrong answer each time, I decided such mechanical manipulations are
; best left to a computer (and doing such things does nothing to
; further my understanding).
;
; Much of what you see below is unpolished, and I plan to fill-in some
; more exposition as I clean it up.

(define
   (y_2 x a_1 a_2)
   (* (square (- x 1))
      (+ a_1 (* a_2 x))  )  )

(define
   (F x a b)
   (- (* a
         (cube x)
         (square (D (D y_2)))  )
      (* b x (square y_2))  )  )

(define
   (v_2 x a b a_1 a_2)
   (+ (* (expt x 8)  -1/8 b a_2 a_2)
      (* (expt x 7)  -2/7 b a_1 a_2)
      (* (expt x 7)   4/7 b a_2 a_2)
      (* (expt x 6)   6   a a_2 a_2)
      (* (expt x 6)  -1/6 b a_1 a_1)
      (* (expt x 6)   4/3 b a_1 a_2)
      (* (expt x 6)  -1   b a_2 a_2)
      (* (expt x 5)  24/5 a a_1 a_2)
      (* (expt x 5) -48/5 a a_2 a_2)
      (* (expt x 5)   4/5 b a_1 a_1)
      (* (expt x 5) -12/5 b a_1 a_2)
      (* (expt x 5)   4/5 b a_2 a_2)
      (* (expt x 4)       a a_1 a_1)
      (* (expt x 4)  -4   a a_1 a_2)
      (* (expt x 4)   4   a a_2 a_2)
      (* (expt x 4)  -3/2 b a_1 a_1)
      (* (expt x 4)   2   b a_1 a_2)
      (* (expt x 4)  -1/4 b a_2 a_2)
      (* (expt x 3)   4/3 b a_1 a_1)
      (* (expt x 3)  -2/3 b a_1 a_2)
      (* (expt x 2)  -1/2 b a_1 a_1)  )  )

(define integrand1 ((F 'x 'a 'b) 'x 'a_1 'a_2))

(define integrand2 (((partial 0) v_2) 'x 'a 'b 'a_1 'a_2))

(define
   (v_3 a b a_1 a_2)
   (v_2 1 a b a_1 a_2)  )

;(((partial 2) v_3) 'a 'b 'a_1 'a_2)
;#|
;(+ (* 2 a a_1) (* 4/5 a a_2) (* -1/15 a_1 b) (* -2/105 a_2 b))
;|#

;(((partial 3) v_3) 'a 'b 'a_1 'a_2)
;#|
;(+ (* 4/5 a a_1) (* 4/5 a a_2) (* -2/105 a_1 b) (* -1/140 a_2 b))
;|#

;(print-expression integrand2)
