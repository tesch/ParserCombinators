//
// Transform.swift
//
// Created by Marcel Tesch on 2021-05-21.
// Think different.
//

public extension Parser {

    /// Construct a parser by applying a given transform closure to the original parser.

    func transform<Result>(_ block: @escaping (Parser<Value>) throws -> Parser<Result>) rethrows -> Parser<Result> {
        try block(self)
    }

}
