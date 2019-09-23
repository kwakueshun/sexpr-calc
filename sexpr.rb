#!/usr/bin/ruby

# Convert a string of characters into a list of tokens.
def tokenize(str)
    str.gsub('(', '( ').gsub(')', ' )').split
end

# Numbers become integers / floats.
# Every other token is an expression symbol.
def get_atom(token)
    Integer(token)
rescue ArgumentError
    Float(token) rescue token
end

# Read an expression from a sequence of tokens.
def read_from_token(token_list)
    if token_list.empty?
        raise EOFError
    end

    token = token_list.shift

    if token == "("
        passed = []
        while token_list[0] != ")"
            passed << read_from_token(token_list)
        end
        token_list.shift
        passed
    elsif token == ")"
        raise EOFError
    else
        get_atom(token)
    end
end

OPERATIONS = {'add' => lambda { |a,b| a + b}, 'multiply' => lambda {|a,b| a * b }}

def evaluate(expr)
    if expr.is_a? Integer or expr.is_a? Float
        expr
    else
        operation = OPERATIONS[expr.first]
        left = expr[1]
        right = expr[2]

        operation.call(evaluate(left), evaluate(right))
    end
end


if ARGV.empty?
    help = <<-EOS
    Usage: sexpr-calc <n>
    eg.sexpr.rb "(add (multiply 75 4.5) 5)"
    EOS
    puts help
else
    tokenized = tokenize(ARGV.first)
    atom = read_from_token(tokenized)
    evaluation = evaluate(atom)
    puts evaluation
end