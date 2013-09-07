(define
   (d x1 y1 x2 y2)
   (sqrt
      (+
         (square (- x2 x1))
         (square (- y2 y1))
      )
   )
)

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
            (square cos)
         )
         1
      )
      'a
   )
)

(print-expression ((literal-function 'f) 'x))

(print-expression
   (  (compose
         (literal-function 'f)
         (literal-function 'g)
      )
      'x
   )
)

(define g (literal-function 'g (-> (X Real Real) Real)))

(print-expression (g 'x 'y))
