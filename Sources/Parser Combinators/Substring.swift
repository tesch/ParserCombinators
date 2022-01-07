//
// Substring.swift
//
// Created by Marcel Tesch on 2022-01-07.
// Think different.
//

public extension Parser {

    /// A substring parser that matches a single character fullfilling a given predicate.

    static func character(_ predicate: @escaping (Character) throws -> Bool) -> Parser<Substring> {
        .init { input in
            guard let character = input.first, try predicate(character) else { return nil }

            let index = input.index(after: input.startIndex)

            return (input[input.startIndex ..< index], input[index ..< input.endIndex])
        }
    }

    /// A substring parser that matches a single instance of a given character.

    static func character(_ character: Character) -> Parser<Substring> {
        .character { value in value == character }
    }

}

public extension Parser {

    /// A substring parser that matches a single arbitrary character.

    static var character: Parser<Substring> { .character { _ in true } }

    /// A substring parser that matches an escaped character, i.e. a backslash character
    /// followed by an arbitrary character.

    static var escapedCharacter: Parser<Substring> { .character("\\").join(to: .character) }

}

public extension Parser {

    /// A substring parser that matches one or more characters fullfilling a given predicate.

    static func substring(_ predicate: @escaping (Character) throws -> Bool) -> Parser<Substring> {
        .init { input in
            var index = input.startIndex

            while index < input.endIndex {
                guard try predicate(input[index]) else { break }

                index = input.index(after: index)
            }

            guard index > input.startIndex else { return nil }

            return (input[input.startIndex ..< index], input[index ..< input.endIndex])
        }
    }

    /// A substring parser that matches one or more instances of a given character.

    static func substring(repeating character: Character) -> Parser<Substring> {
        .substring { value in value == character }
    }

}

public extension Parser {

    /// A substring parser that matches one or more whitespace characters.

    static var whitespace: Parser<Substring> { .substring(\.isWhitespace) }

    /// A substring parser that matches zero or more whitespace characters.

    static var padding: Parser<Substring> { .whitespace.orEmpty() }

}

public extension Parser {

    func leadingPadding() -> Self {
        .padding.joinRight(to: self)
    }

    func trailingPadding() -> Self {
        joinLeft(to: .padding)
    }

    func padding() -> Self {
         leadingPadding()
        .trailingPadding()
    }

}
