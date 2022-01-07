//
// Join.swift
//
// Created by Marcel Tesch on 2021-05-20.
// Think different.
//

public extension Parser {

    /// Construct a parser that consecutively applies the original parser and a parser constructed
    /// by a given closure as a function of the original parser's return value.
    ///
    /// The resulting parser returns the return value of the latter parser, if both parsers succeed.

    func join<Result>(_ block: @escaping (Value) throws -> Parser<Result>) -> Parser<Result> {
        .init { input in
            guard let (value, input) = try parse(input) else { return nil }

            let parser = try block(value)

            return try parser.parse(input)
        }
    }

    /// Join to a given parser, using a given closure to combine the respective return values into a single result.

    func join<Other, Result>(to parser: Parser<Other>, _ block: @escaping (Value, Other) throws -> Result) -> Parser<Result> {
        join { value in
            parser.map { other in try block(value, other) }
        }
    }

    /// Join to a given parser, using an appropriate combining closure returned by the original parser.

    func join<Other, Result>(to parser: Parser<Other>) -> Parser<Result> where Value == (Other) throws -> Result {
        join { block in
            parser.map(block)
        }
    }

    /// Join to a given parser, using an appropriate combining closure returned by the given parser.

    func join<Result>(to parser: Parser<(Value) throws -> Result>) -> Parser<Result> {
        join { value in
            parser.map { block in try block(value) }
        }
    }

}

public extension Parser {

    /// Join to a given parser, combining the respective return values into a tuple.

    func join<Other>(to parser: Parser<Other>) -> Parser<(Value, Other)> {
        join(to: parser) { left, right in (left, right) }
    }

    /// Join to a given parser, ignoring the return value of the given parser.

    func joinLeft<Other>(to parser: Parser<Other>) -> Self {
        join(to: parser) { left, _ in left }
    }

    /// Join to a given parser, ignoring the return value of the original parser.

    func joinRight<Result>(to parser: Parser<Result>) -> Parser<Result> {
        join(to: parser) { _, right in right }
    }

}

public extension Parser where Value == Substring {

    /// Join to a given substring parser, combining both individual substrings into a single substring.
    ///
    /// Failing to ensure that both substrings are consecutive will result in a precondition failure at run-time.

    func join(to parser: Self) -> Self {
        join(to: parser, Substring.init)
    }

}
