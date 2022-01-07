//
// Tree.swift
//
// Created by Marcel Tesch on 2021-05-20.
// Think different.
//

import ParserCombinators

enum Tree {

    case leaf(Substring)

    case branch(Array<Tree>)

}

extension Tree: CustomStringConvertible {

    var description: String {
        switch self {
        case .leaf(let value):
            return "\"" + value + "\""

        case .branch(let values):
            return "[" + values.map(\.description).joined(separator: ", ") + "]"
        }
    }

}

extension Parser {

    private static var leafExpression: Parser<Tree> {
        .substring { character in
            (["[", ",", "]", "\\"].contains(character) == false) && (character.isWhitespace == false)
        }
        .fallback(to: .escapedCharacter)

        .chain()
        .chain(with: .whitespace)

        .map(Tree.leaf)
    }

    private static var branchExpression: Parser<Tree> {
        .character("[").trailingPadding()

        .joinRight(to:
            .lazy { .treeExpression }
            .collection(separatedBy: .character(",").padding(), allowingTrailingSeparator: true)
        )

        .joinLeft(to: .character("]").leadingPadding())

        .map(Tree.branch)
    }

    static var treeExpression: Parser<Tree> {
        .leafExpression
        .fallback(to: .branchExpression)
    }

}
