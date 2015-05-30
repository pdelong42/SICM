; In this file are exercises added by me, to help me clarify the
; concepts for myself (and refer back to when I'm feeling fuzzy on the
; concepts).

; These two expressions are equivalent:

(((partial 0) square) (up 'x))

((D square) 'x)

; Both expressions should produce the output "(* 2 x)"
