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

((compose cube sin) 'a)

(  (- (+ (square sin)
         (square cos)  )
      1  )
   'a  )

((literal-function 'f) 'x)

(  (compose
      (literal-function 'f)
      (literal-function 'g)  )
   'x  )

(define g (literal-function 'g (-> (X Real Real) Real)))

(g 'x 'y)

(define v (up 'v^0 'v^1 'v^2))

v

(define p (down 'p_0 'p_1 'p_2))

p

(define s (up 't (up 'x 'y) (down 'p_x 'p_y)))

s

((component 0 1) (up (up 'a 'b) (up 'c 'd)))

(ref (up 'a 'b 'c) 1)

(ref (up (up 'a 'b) (up 'c 'd)) 0 1)

(* p v)

(define derivative-of-sine (D sin))

(derivative-of-sine 'x)

(((* 5 D) cos) 'x)

(  (  (* (- D I)
         (+ D I)  )
      (literal-function 'f)  )
   'x  )

((D g) 'x 'y)

(define
   (h s)
   (  g
      (ref s 0)
      (ref s 1)  )  )

(h (up 'x 'y))

((D g) 'x 'y)

(  (D h)
   (up 'x 'y)  )

(define H
   (literal-function
      'H
      (->
         (UP
            Real
            (UP Real Real)
            (DOWN Real Real)  )
         Real  )  )  )

(H s)

((D H) s)

(define
   (helix t)
   (up
      (cos t)
      (sin t)
      t  )  )

(define helix (up cos sin identity))

((D helix) 't)

(define
   (g x y)
   (up
      (square (+ x y))
      (cube   (- y x))
      (exp    (+ x y))  )  )

((D g) 'x 'y)

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
         (y (ref v 1))  )
      (*
         (square x)
         (cube y)  )  )  )

(define
   (g v)
   (let
      (  (x (ref v 0))
         (y (ref v 1))  )
      (up (f v) y)  )  )

(define h (compose f g))
