//
// Empty.swift
//
// Created by Marcel Tesch on 2021-09-15.
// Think different.
//

public extension Parser {

    /// A substring parser that always succeeds, returning the empty substring from the start of the input.
    /// The resulting parser consumes no input.

    static var empty: Parser<Substring> {
        .init { input in
            (input[input.startIndex ..< input.startIndex], input)
        }
    }

}

public extension Parser where Value == Substring {

    /// Construct a substring parser that always succeeds, falling back to returning an empty substring
    /// in cases where the original parser fails.

    func orEmpty() -> Parser<Substring> {
        fallback(to: .empty)
    }

}
