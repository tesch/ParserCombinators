//
// Lazy.swift
//
// Created by Marcel Tesch on 2021-09-15.
// Think different.
//

public extension Parser {

    /// Construct a parser that defers its work to a parser returned by a given closure.
    /// The closure is re-evaluated for each invocation of the resulting parser.
    ///
    /// Lazy parsers are usually used in cases where a parser's definition requires recursion.

    static func lazy<Value>(_ block: @escaping () throws -> Parser<Value>) -> Parser<Value> {
        .init { input in
            let parser = try block()

            return try parser.parse(input)
        }
    }

}
