S-expression calculator
=======================

Command line program that acts as a simple calculator: it takes a
single argument as an expression and prints out the integer result of
evaluating it. Run like this

```console
foo@bar:~$ swift run sexpr-calc 123
123

foo@bar:~$ swift run sexpr-calc "(add 12 12)"
24

foo@bar:~$ swift run sexpr-calc "(multiply 75 4.5)"
375
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

Installation
--------

If you want to run sexpr-calc using SwiftPM, it's as simple as cloning the repository and invoking swift run:
```shell
git clone https://github.com/kwakueshun/sexpr-calc.git
cd sexpr-calc
swift run sexpr-calc
```