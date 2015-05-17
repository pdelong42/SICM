(define
   (d x1 y1 x2 y2)
   (sqrt
      (+
         (square (- x2 x1))
         (square (- y2 y1))  )  )  )

(define h (compose cube sin))

(h 2)

(cube (sin 2))

(define g (* cube sin))

(g 2)

(* (cube 2) (sin 2))

(print-expression ((compose cube sin) 'a))

(print-expression
   (  (-
         (+
            (square sin)
            (square cos)  )
         1  )
      'a  )  )

(print-expression ((literal-function 'f) 'x))

(print-expression
   (  (compose
         (literal-function 'f)
         (literal-function 'g)  )
      'x  )  )

(define g (literal-function 'g (-> (X Real Real) Real)))

(print-expression (g 'x 'y))

(define v (up 'v^0 'v^1 'v^2))

(print-expression v)

(define p (down 'p_0 'p_1 'p_2))

(print-expression p)

(define s (up 't (up 'x 'y) (down 'p_x 'p_y)))

(print-expression s)

((component 0 1) (up (up 'a 'b) (up 'c 'd)))

(ref (up 'a 'b 'c) 1)

(ref (up (up 'a 'b) (up 'c 'd)) 0 1)

(print-expression (* p v))

(define derivative-of-sine (D sin))

(print-expression (derivative-of-sine 'x))

(print-expression
   (  (  (*
            (- D 1)
            (+ D 1)
         )
         (literal-function 'f)  )
      'x  )  )

(print-expression ((D g) 'x 'y))

(define
   (h s)
   (  g
      (ref s 0)
      (ref s 1)  )  )

(print-expression (h (up 'x 'y)))

(print-expression ((D g) 'x 'y))

(print-expression
   (  (D h)
      (up 'x 'y)  )  )

(define H
   (literal-function
      'H
      (->
         (UP
            Real
            (UP Real Real)
            (DOWN Real Real)  )
         Real  )  )  )

(print-expression (H s))

(print-expression ((D H) s))

(define
   (helix t)
   (up
      (cos t)
      (sin t)
      t  )  )

(define helix (up cos sin identity))

(print-expression ((D helix) 't))

(define
   (g x y)
   (up
      (square (+ x y))
      (cube   (- y x))
      (exp    (+ x y))  )  )

(print-expression ((D g) 'x 'y))

(define
   (f x y)
   (*
      (square x)
      (cube y)  )  )

(define
   (g x y)
   (up (f x y) y)  )

(define
   (h x y)
   (f (f x y) y)  )

(define
   (f v)
   (let
      (  (x (ref v 0))
         (y (ref v 1))
      )
      (*
         (square x)
         (cube y)  )  )  )

(define
   (g v)
   (let
      (  (x (ref v 0))
         (y (ref v 1))
      )
      (up (f v) y)  )  )

(define h (compose f g))
