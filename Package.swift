// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "ParserCombinators",

    products: [
        .library(name: "ParserCombinators", targets: ["ParserCombinators"])
    ],

    dependencies: [

    ],

    targets: [
        .target(name: "ParserCombinators", dependencies: [], path: "Sources/Parser Combinators"),

        .executableTarget(name: "Examples", dependencies: ["ParserCombinators"], path: "Sources/Examples"),
    ]
)
