#!/usr/bin/swift

// S-Expression Calculator
// Samuel Eshun
// 5th July, 2018

import Foundation

//PARSING

/// Convert a string of characters into a list of tokens.
///adds spaces around each parentheses so as to get
///distinct pairs of character sets to split
func tokenize(chars: String) -> Array<String> {
  let s = chars.replacingOccurrences(of: "(", with: " ( ").replacingOccurrences(of: ")", with: " ) ")
  let array = s.components(separatedBy: " ").filter {$0 != ""}
  return array
}


enum SESyntaxError: Error {
    case syntaxError(String)
}

///Read an expression from a sequence of tokens.
func readFromToken(tokens: inout [String]) throws -> Any {

  if tokens.count == 0 {
    throw SESyntaxError.syntaxError("unexpected EOF")
  }
  let token = tokens.remove(at: 0)

  if token == "(" {
    var L = [Any]()
    while tokens[0] != ")" {
      do {
        try L.append(readFromToken(tokens: &tokens))
      }
      catch {

      }
    }
    // remove )
    tokens.remove(at: 0)
    return L
  }
  else if token == ")" {
    throw SESyntaxError.syntaxError("unexpected EOF")
  }
  else {
    return atom(token: token)
  }
}

///Numbers become integers
/// every other token is an expression symbol.
func atom(token: String) -> Any {
  if let intValue = Int(token) {
    return intValue
  }
  /// Restricting use to integers
  else if let floatValue = Float(token) {
    return Int(floatValue)
  }
  else {
    return token
  }
}

// EVALUATION

// Custom function signature for generic binary operation
typealias Operation = (Int, Int) -> Int

let operations: Dictionary<String, Operation> = [
    "add": (+),
    "subtract": (-),
    "multiply": (*),
    "divide": (/)
]

func evaluate(_ x: Any) -> Int {
    if let x = x as? Int {
        return x
    }
    
    let list = x as! [Any]
    let left = list[1]
    let right = list[2]
    let operation = operations[list[0] as! String]
    
    return operation!(evaluate(left), evaluate(right))
}


if CommandLine.argc < 2 {
  let help = """
  Usage: sexpr-calc <n>
    eg.sexpr-calc.swift "(add (multiply 75 4.5) 5)"
  """
  print(help)
  print("\n")
}
else {
print("Parsing...")
print("Result of parsing...")
var tokenised = tokenize(chars: CommandLine.arguments[1])

do {
  let value = try readFromToken(tokens: &tokenised)
  print(value)
  print("Evaluating...")
  print("Result is...")
  print(evaluate(x: value))
}
catch {
  print(error.localizedDescription)
  }
}



