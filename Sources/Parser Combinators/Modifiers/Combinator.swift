//
// Combinator.swift
//
// Created by Marcel Tesch on 2021-08-15.
// Think different.
//

public extension Parser {

    /// Construct a combinator parser from a given closure that defines how a pair of return values
    /// are to be combined into a single result.
    ///
    /// In cases where the original parser succeeds, the resulting parser returns an analogous closure
    /// which implicitly incorporates the return value of the original parser in between its arguments.
    ///
    /// Combinator parsers are usually used to define operators with which other parsers are chained.

    func combinator(_ block: @escaping (Value, Value) throws -> Value) -> Parser<(Value, Value) throws -> Value> {
        map { center in
            { left, right in try block(block(left, center), right) }
        }
    }

}
