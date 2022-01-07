//
// Optional.swift
//
// Created by Marcel Tesch on 2021-06-03.
// Think different.
//

public extension Parser {

    /// Construct a parser with an optional return type. The resulting parser always succeeds,
    /// returning a `nil` value and consuming no input in cases where the original parser fails.

    func optional() -> Parser<Value?> {
        .init { input in
            try parse(input) ?? (nil, input)
        }
    }

    /// Construct a parser with a non-optional return type. The resulting parser fails
    /// in cases where the original parser returns a `nil` value.

    func require<Result>() -> Parser<Result> where Value == Result? {
        .init { input in
            guard let (value, input) = try parse(input), let value = value else { return nil }

            return (value, input)
        }
    }

}
