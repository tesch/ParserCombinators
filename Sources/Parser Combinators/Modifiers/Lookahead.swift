//
// Lookahead.swift
//
// Created by Marcel Tesch on 2021-06-25.
// Think different.
//

public extension Parser {

    /// Construct a parser that performs a lookahead. The resulting parser's behavior is identical
    /// to the original parser, except that it consumes no input.

    func lookahead() -> Parser<Value> {
        .init { input in
            guard let (value, _) = try parse(input) else { return nil }

            return (value, input)
        }
    }

}
