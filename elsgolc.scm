; These are some examples from "Calculus of Variations",
; by Lev D. Elsgolc (ISBN 978-0486457994).
;

; Chapter 5: Direct Methods
; Section 3: Ritz's Method
; Example 1
;
; I'm doing this in scmutils, because after the sixth or seventh time
; of working through the tedious algebra myself, and getting a new
; wrong answer each time, I decided such mechanical manipulations are
; best left to a computer (and doing such things myself does nothing to
; further my understanding).
;
; Much of what you see below is unpolished, and I plan to fill-in some
; more exposition as I clean it up.

; This example problem involves approximating the solution with a
; trial function.  The author doesn't explain the motivation, but the
; approach looks familiar.  He implies that the coefficients a_1 and
; a_2 could continue indefinitely, but that he chose to stop at 2 (for
; illustration purposes).  I'm guessing all the terms are mutually
; orthogonal, but I haven't verified this myself.

; y_2 is the candidate function:

(define
   (y_2 x a_1 a_2)
   (* (square (- x 1))
      (+ a_1 (* a_2 x))  )  )

; F is the function being minimized:

(define
   (F x a b)
   (- (* a
         (cube x)
         (square (D (D y_2)))  )
      (* b x (square y_2))  )  )

; v_2 is the functional.  Below, I've integrated the integrand
; manually, an integrand which I've found by evaluating F when
; substituting y_2 into it.

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

; Note: I integrated manually, because there isn't a general way to do
; symbolic integration of closed-form expressions.  I'm 99% sure of
; this, but it took me a while to remember this fact from basic calc
; 1.  In other words, differentiation is always easier than
; integration.  Hence integral tables.

(define integrand1 ((F 'x 'a 'b) 'x 'a_1 'a_2))

(define integrand2 (((partial 0) v_2) 'x 'a 'b 'a_1 'a_2))

; Here, I evaluate the integral from x=0 to x=1 (I need a better name
; for the result than v_3).

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
