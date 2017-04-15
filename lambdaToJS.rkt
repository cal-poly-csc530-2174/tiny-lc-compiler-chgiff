#lang racket

(define inputFile "primes-below-ten-thousand.rkt")

(define (parseToJS exp)
(match exp 
   [(list 'λ id lc) (begin
                        (display "(function " outJS)
                        (display id outJS)
                        (display "{ \nreturn " outJS)
                        (parseToJS lc)
                        (display "\n})\n" outJS)                        
                          )]
  [(list 'println lc) (begin
                         (display "(function (){\nconsole.log(" outJS)
                         (parseToJS lc)
                         (display "); \nreturn 0\n}()\n)" outJS)
                           )]
   [(list lc1 lc2) (begin
                   (parseToJS lc1)
                   (display "(" outJS)
                   (parseToJS lc2)
                   (display ")" outJS)
                   )]
   [(list '+ lc1 lc2) (begin
                       (display "(" outJS)
                       (parseToJS lc1)
                       (display " + " outJS)
                       (parseToJS lc2)
                       (display ")" outJS)
                       )
                       ]
   [(list '* lc1 lc2) (begin
                       (display "(" outJS)
                       (parseToJS lc1)
                       (display " * " outJS)
                       (parseToJS lc2)
                       (display ")" outJS)
                       )
                       ]
   [(list 'ifleq0 cond if else) (begin
                                  (display "(" outJS)
                                  (parseToJS cond)
                                  (display " <= 0 ? " outJS)
                                  (parseToJS if)
                                  (display " : " outJS)
                                  (parseToJS else)
                                  (display ")" outJS)
                                    )]
   [(list term) (parseToJS term)]
   [term (display term outJS)]
)
  )

(define outJS (open-output-file (string-append inputFile ".js") #:exists 'replace))
(parseToJS (file->value inputFile))
(close-output-port outJS)
