I got both translation to javascript and translation to python working using Racket as the implementation language.
The input file is specified at the top of the Racket file for each translation.

The Racket code is probably aweful because this is my first time using racket so I didn't really have a feel for the syntax and available functions.
The python translation includes a helper print function so it works with Python 2 since Python 2 implements print as a statement instead of an expression. 
With python, I had issues with too much recursion so I changed the input file to print primes below 100.
The javascript worked fine even for 10000 when I pasted it into the Chrome console.