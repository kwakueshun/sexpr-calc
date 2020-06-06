
// S-Expression Calculator
// Samuel Eshun
// 5th July, 2018

import Cocoa
import ArgumentParser

enum RuntimeError: String, Error, CustomStringConvertible {
    case endOfFileError = "unexpected EOF"
    var description: String { rawValue }
}

typealias Operation = (Int, Int) -> Int
let operations: [String: Operation] = [
    "add": (+), "subtract": (-), "multiply": (*), "divide": (/)
]

struct ExpressionParser: ParsableCommand {
    static var configuration = CommandConfiguration(
      commandName: "sexpr-calc",
      abstract: ExpressionParser.abstract,
      discussion: ExpressionParser.discussion
    )

    /// String that makes up the expression to be parsed
    @Argument(help: "S-Expression input string")
    var expression: String

    func run() throws {
        guard CommandLine.argc == 2 else { throw CleanExit.helpRequest() }
        var tokenised = tokenize(chars: CommandLine.arguments[1])

        let value = try readFromToken(tokens: &tokenised)
        print("------------------")
        print(evaluate(value))
    }

    func validate() throws {
        if expression.isEmpty {
            throw ValidationError("Expression cannot be an empty string")
        }
    }

    func tokenize(chars: String) -> [String] {
        let s = chars.replacingOccurrences(of: "(", with: " ( ").replacingOccurrences(of: ")", with: " ) ")
        let array = s.components(separatedBy: " ").filter { $0 != ""}
        return array
    }

    /// Read an expression from a sequence of tokens.
    func readFromToken(tokens: inout [String]) throws -> Any {
        if tokens.isEmpty { throw RuntimeError.endOfFileError }

        let token = tokens.remove(at: 0)
        if token == "(" {
            var parts: [Any] = []
            while tokens[0] != ")" {
                _ = try? parts.append(readFromToken(tokens: &tokens))
            }
            // remove )
            tokens.remove(at: 0)
            return parts
        }
        else if token == ")" { throw RuntimeError.endOfFileError }
        else { return atom(token: token) }
    }

    /// Numbers become integers and every other token is an expression symbol.
    func atom(token: String) -> Any {
        if let intValue = Int(token) {
            return intValue
        }
        /// Restricting use to integers
        else if let floatValue = Float(token) {
            return Int(floatValue)
        }
        else { return token }
    }

    func evaluate(_ x: Any) -> Int {
        if let x = x as? Int { return x }
        let list = x as! [Any]
        let left = list[1], right = list[2]
        let operation = operations[list[0] as! String]
        return operation!(evaluate(left), evaluate(right))
    }
}

extension ExpressionParser {
    static let discussion = """
    Command line program that acts as a simple calculator: it takes a single argument as an expression
    and prints out the integer result of evaluating it.
    """

    static let abstract = "S-expression Calculator"
}

ExpressionParser.main()
