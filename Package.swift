// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "S-Expr-Calculator",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(
            name: "sexpr-calc",
            targets: ["S-Expr-Calculator"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/apple/swift-argument-parser", .exact("0.0.6")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "S-Expr-Calculator",
            dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")],
            path: "Source"
            ),
        .testTarget(
            name: "S-Expr-CalculatorTests",
            dependencies: ["S-Expr-Calculator"]),
    ]
)
