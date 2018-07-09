S-expression calculator
=======================

 Command line program that acts as a simple calculator: it takes a
single argument as an expression and prints out the integer result of
evaluating it. Run like this

    $ ./sexpr-calc.swift 123
    123

    $ ./sexpr-calc.swift "(add 12 12)"
    24


Examples
--------

Besides the examples already provided above, it should be possible to mix and
match integers and function calls to build arbitrary calculations:

    "(add 1 (multiply 2 3))"
    => 7

    "(multiply 2 (add (multiply 2 3) 8))"
    => 28
    
    "(multiply 2 (add (subtract 4 3) 8))"
    => 18

