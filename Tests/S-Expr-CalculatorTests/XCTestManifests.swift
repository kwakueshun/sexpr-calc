import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(S_Expr_CalculatorTests.allTests),
    ]
}
#endif
