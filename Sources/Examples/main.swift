//
// main.swift
//
// Created by Marcel Tesch on 2021-11-27.
// Think different.
//

import ParserCombinators

do {
    let input = "1 * (2 + 3) - 4 / 5"

    if let (result, _) = try? Parser<Double>.arithmeticExpression.parse(input) {
        print("\(input) = \(result)") // 1 * (2 + 3) - 4 / 5 = 4.2
    }
}

do {
    let input = "[a, [b, [c, d], e], [f, g], foo bar]"

    if let (result, _) = try? Parser<Tree>.treeExpression.parse(input) {
        print(result) // ["a", ["b", ["c", "d"], "e"], ["f", "g"], "foo bar"]
    }
}
