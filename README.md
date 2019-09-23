S-expression calculator
=======================

Command line program that acts as a simple calculator: it takes a
single argument as an expression and prints out the integer result of
evaluating it. Run like this

```console
foo@bar:~$ ./sexpr-calc.swift 123
123

foo@bar:~$ ./sexpr-calc.py "(add 12 12)"
123

foo@bar:~$ ./sexpr.rb "(multiply 75 4.5)"
123
```

Examples
--------

Besides the examples already provided above, it should be possible to mix and
match integers and function calls to build arbitrary calculations:
```console
foo@bar:~$ "(add 1 (multiply 2 3))"
7

foo@bar:~$ "(multiply 2 (add (multiply 2 3) 8))"
28

foo@bar:~$ "(multiply 2 (add (subtract 4 3) 8))"
18
```