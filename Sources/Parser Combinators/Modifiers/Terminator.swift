//
// Terminator.swift
//
// Created by Marcel Tesch on 2021-09-15.
// Think different.
//

public extension Parser {

    /// A parser that succeeds if the input is empty.

    static var terminator: Parser<()> {
        .init { input in input.isEmpty ? ((), input) : nil }
    }

    /// Construct a parser that requires the entire input to be consumed in order to succeed.

    func terminate() -> Self {
        joinLeft(to: .terminator)
    }

}
