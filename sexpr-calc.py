import sys

args = sys.argv[1]

def transform_to_array(my_str):
    return my_str.replace("(", "( ").replace(")", " )").split(" ")

def extract(transformed_array):
    if len(transformed_array) == 0:
        raise EOFError

    first_member = transformed_array.pop(0)

    if first_member == "(":
        passed = []
        while transformed_array[0] != ")":
            passed.append(extract(transformed_array))
        transformed_array.pop(0)
        return passed
    elif first_member == ")":
        raise EOFError
    else:
        return get_atom(first_member)


def get_atom(any_object):
    try:
        a = int(any_object)
        return a
    except ValueError:
        return any_object


operations = dict({'add': lambda a,b: a + b, 'multiply': lambda a,b: a * b })

def evaluate(any_object):

    if type(any_object) is int:
        return any_object

    print(len(any_object))
    func = operations[any_object[0]]
    left = any_object[1]
    right = any_object[2]

    return func(evaluate(left), evaluate(right))



str_list = transform_to_array(my_str=args)

extracted = extract(str_list)

result = evaluate(extracted)
print(result)
