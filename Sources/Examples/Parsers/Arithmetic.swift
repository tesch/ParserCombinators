//
// Arithmetic.swift
//
// Created by Marcel Tesch on 2021-05-20.
// Think different.
//

import ParserCombinators

private extension Character {

    var isDigit: Bool { "0" ... "9" ~= self }

}

private extension Parser {

    typealias Operator = (Double, Double) throws -> Double

    static var addition: Parser<Operator> { .character("+").map(to: +) }

    static var subtraction: Parser<Operator> { .character("-").map(to: -) }

    static var multiplication: Parser<Operator> { .character("*").map(to: *) }

    static var division: Parser<Operator> { .character("/").map(to: /) }

    static var digits: Parser<Substring> { .substring(\.isDigit) }

}

extension Parser {

    private static var numericExpression: Parser<Double> {
        .character("-").orEmpty()
        .join(to: .digits)

        .join(to:
            .character(".")
            .join(to: .digits.orEmpty())
            .orEmpty()
        )

        .compactMap(Double.init)
    }

    static var arithmeticExpression: Parser<Double> {
        .numericExpression

        .fallback(to:
            .character("(").trailingPadding()
            .joinRight(to: .lazy { .arithmeticExpression })
            .joinLeft(to: .character(")").leadingPadding())
        )

        .chain(with:
            .multiplication
            .fallback(to: .division)
            .padding()
        )

        .chain(with:
            .addition
            .fallback(to: .subtraction)
            .padding()
        )
    }

}
