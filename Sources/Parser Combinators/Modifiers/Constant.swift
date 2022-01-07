//
// Constant.swift
//
// Created by Marcel Tesch on 2021-09-07.
// Think different.
//

public extension Parser {

    /// Construct a parser that returns a given value and consumes no input.
    /// The resulting parser always succeeds.

    static func constant<Value>(of value: Value) -> Parser<Value> {
        .init { input in (value, input) }
    }

    /// A constant parser that returns an empty tuple.
    ///
    /// This parser is intended to be used in places where a no-op placeholder is required,
    /// for example as a separator for collections that don't explicitly separate their elements.
    ///
    /// The only purpose of this parser is to succeed and pass on control to subsequent parsers.

    static var nothing: Parser<()> {
        .constant(of: ())
    }

}
