//
// Chain.swift
//
// Created by Marcel Tesch on 2021-05-22.
// Think different.
//

public extension Parser {

    /// Construct a chain parser from a given combinator closure,
    /// analogous to ``Parser/chain(with:)-1z85u``.
    ///
    /// This parser is used in cases where the combining closure doesn't
    /// need to be derived from context.

    func chain(_ block: @escaping (Value, Value) throws -> Value) -> Self {
        chain(with: .constant(of: block))
    }

    /// Construct a parser that alternatingly applies the original parser and a given combinator parser.
    ///
    /// The given parser provides combinator closures which consecutively combine the
    /// return values of the original parser into a single result. Such parsers are
    /// usually constructed with ``Parser/combinator(_:)``.
    ///
    /// This parser fails in cases where the original parser doesn't succeed at least once.

    func chain(with combinator: Parser<(Value, Value) throws -> Value>) -> Self {
        .init { input in
            guard var (result, input) = try parse(input) else { return nil }

            while let (combinator, output) = try combinator.parse(input), let (value, output) = try parse(output) {
                (result, input) = try (combinator(result, value), output)
            }

            return (result, input)
        }
    }

}

public extension Parser where Value == Substring {

    /// Chain one or more instances of the original substring parser, analogous to ``Parser/join(to:)-45upj``.

    func chain() -> Self {
        chain(Substring.init)
    }

    /// Chain one or more instances of the original substring parser, interleaved with
    /// instances of the given substring parser, analogous to ``Parser/chain()``.

    func chain(with parser: Self) -> Self {
        chain(with: parser.combinator(Substring.init))
    }

}
