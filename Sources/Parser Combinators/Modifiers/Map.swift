//
// Map.swift
//
// Created by Marcel Tesch on 2021-10-18.
// Think different.
//

public extension Parser {

    /// Construct a parser that applies a given transform closure to the return value of the original parser.

    func map<Result>(_ block: @escaping (Value) throws -> Result) -> Parser<Result> {
        join { value in
            let result = try block(value)

            return .constant(of: result)
        }
    }

    /// Construct a parser that returns a given value in cases where the original parser succeeds.

    func map<Result>(to result: Result) -> Parser<Result> {
        map { _ in result }
    }

}

public extension Parser {

    /// Analogous to ``Parser/map(_:)``. The resulting parser fails if the given transform closure returns `nil`.

    func compactMap<Result>(_ block: @escaping (Value) throws -> Result?) -> Parser<Result> {
        join { value in
            guard let result = try block(value) else { return .failure }

            return .constant(of: result)
        }
    }

    /// Analogous to ``Parser/map(to:)``. The resulting parser always fails if the given value is `nil`.

    func compactMap<Result>(to result: Result?) -> Parser<Result> {
        compactMap { _ in result }
    }

}
