//
// Fallback.swift
//
// Created by Marcel Tesch on 2021-05-21.
// Think different.
//

public extension Parser {

    /// Construct a parser that always succeeds, returning a given value in cases where the original parser fails.

    func fallback(to value: Value) -> Self {
        fallback(to: .constant(of: value))
    }

    /// Construct a parser that applies a given parser in cases where the original parser fails.
    /// This parser fails in cases where both the original and the given parser fail.

    func fallback(to parser: Self) -> Self {
        .init { input in
            try parse(input) ?? parser.parse(input)
        }
    }

}
