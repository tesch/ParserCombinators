//
// Flag.swift
//
// Created by Marcel Tesch on 2021-06-08.
// Think different.
//

public extension Parser {

    /// Construct a parser that always succeeds, returning `true` if the original parser succeeds,
    /// and returning `false` if the original parser fails.

    func flag() -> Parser<Bool> {
         map(to: true)
        .fallback(to: false)
    }

}
