import XCTest
@testable import S_Expr_Calculator

final class S_Expr_CalculatorTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(S_Expr_Calculator().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
