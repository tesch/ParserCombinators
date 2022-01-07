//
// Failure.swift
//
// Created by Marcel Tesch on 2021-09-15.
// Think different.
//

public extension Parser {

    /// A parser that always fails.

    static var failure: Self {
        .init { _ in nil }
    }

}
