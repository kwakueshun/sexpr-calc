import sys

def tokenize(str_arg):
    """
    Convert a string of characters into a list of tokens. Adds spaces around each parentheses so as to get distinct pairs of character sets to split
    """
    return str_arg.replace("(", "( ").replace(")", " )").split(" ")


def read_from_token(token_list):
    """
    Read an expression from a sequence of tokens.
    """
    if len(token_list) == 0:
        raise EOFError

    token = token_list.pop(0)

    if token == "(":
        passed = []
        while token_list[0] != ")":
            passed.append(read_from_token(token_list))
            # remove )
        token_list.pop(0)
        return passed
    elif token == ")":
        raise EOFError
    else:
        return get_atom(token)


def get_atom(token):
    """
    Numbers become integers.
    Every other token is an expression symbol.
    """
    try:
        a = int(token)
        return a
    except ValueError:
        return token


operations = dict({'add': lambda a,b: a + b, 'multiply': lambda a,b: a * b })

def evaluate(expr):
     """
     We either get an int if argument is int or from result of evaluating list or we get a list/array
     """


    if type(expr) is int:
        return expr

    # evaluate left and right with operation as array's first string value key in operations dictionary/map
    func = operations[expr[0]]
    left = expr[1]
    right = expr[2]

    return func(evaluate(left), evaluate(right))


if len(sys.argv) < 2:
    help = """
  Usage: sexpr-calc <n>
    eg.sexpr-calc.py "(add (multiply 75 4.5) 5)"
  """
    print(help)
else:
    tokenized = tokenize(str_arg = sys.argv[1])
    atom = read_from_token(token_list = tokenized)
    print(evaluate(expr=atom))

