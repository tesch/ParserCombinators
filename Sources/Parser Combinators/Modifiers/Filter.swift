//
// Filter.swift
//
// Created by Marcel Tesch on 2021-06-02.
// Think different.
//

public extension Parser {

    /// Construct a parser that requires the return value of the original parser
    /// to fullfill a given predicate in order to succeed.

    func filter(_ predicate: @escaping (Value) throws -> Bool) -> Self {
        join { value in
            try predicate(value) ? .constant(of: value) : .failure
        }
    }

}
