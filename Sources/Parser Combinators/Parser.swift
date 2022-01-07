//
// Parser.swift
//
// Created by Marcel Tesch on 2021-05-20.
// Think different.
//

/// A parser encapsulates the logic required to retrieve structured information from unstructured inputs
/// and affords the facilities to define said logic in terms of elementary building blocks.

public struct Parser<Value> {

    private let block: (Substring) throws -> (Value, Substring)?

    public init(_ block: @escaping (Substring) throws -> (Value, Substring)?) {
        self.block = block
    }

}

public extension Parser {

    func parse(_ input: Substring) throws -> (Value, Substring)? {
        try block(input)
    }

    func parse(_ input: String) throws -> (Value, Substring)? {
        try parse(input.substring)
    }

}
