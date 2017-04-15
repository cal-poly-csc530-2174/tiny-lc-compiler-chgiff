#lang racket

(define inputFile "primes-below-one-hundred.rkt")

(define (parseToPy exp)
(match exp 
   [(list 'λ id lc) (begin
                        (display "(lambda " outPy)
                        (display id outPy)
                        (display ": " outPy)
                        (parseToPy lc)
                        (display " )" outPy)                        
                          )]
  [(list 'println lc) (begin
                         (display "println(" outPy)
                         (parseToPy lc)
                         (display ")" outPy)
                           )]
   [(list lc1 lc2) (begin
                   (parseToPy lc1)
                   (display "(" outPy)
                   (parseToPy lc2)
                   (display ")" outPy)
                   )]
   [(list '+ lc1 lc2) (begin
                       (display "(" outPy)
                       (parseToPy lc1)
                       (display " + " outPy)
                       (parseToPy lc2)
                       (display ")" outPy)
                       )
                       ]
   [(list '* lc1 lc2) (begin
                       (display "(" outPy )
                       (parseToPy lc1)
                       (display " * " outPy)
                       (parseToPy lc2)
                       (display ")" outPy)
                       )
                       ]
   [(list 'ifleq0 cond if else) (begin
                                  (display "(" outPy)
                                  (parseToPy if)
                                  (display " if " outPy)
                                  (parseToPy cond)
                                  (display " <= 0 else " outPy)
                                  (parseToPy else)
                                  (display ")" outPy)
                                    )]
   [(list term) (parseToPy term)]
   [term (display term outPy)]
)
  )

;open python output file
(define outPy (open-output-file (string-append inputFile ".py") #:exists 'replace))
;helper print function so it works with python 2
;print is a statement in py 2 and doesn't work in ternary
(display "def println(x): print(x); return 0;\n" outPy) 
(parseToPy (file->value inputFile))
(close-output-port outPy)

