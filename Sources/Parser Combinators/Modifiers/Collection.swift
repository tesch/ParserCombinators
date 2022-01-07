//
// Collection.swift
//
// Created by Marcel Tesch on 2021-05-20.
// Think different.
//

public extension Parser {

    /// Construct a parser that repeatedly applies the original parser, analogous
    /// to ``Parser/collection(separatedBy:allowingTrailingSeparator:)``.
    ///
    /// This parser is used for collections that don't require an explicit separator.

    func collection() -> Parser<Array<Value>> {
        collection(separatedBy: .nothing)
    }

    /// Construct a parser that alternatingly applies the original parser and a given separator parser.
    ///
    /// The resulting parser returns a collection of all return values of the original parser.
    /// This parser always succeeds, returning an empty collection if the original parser never succeeds.

    func collection<Separator>(separatedBy separator: Parser<Separator>, allowingTrailingSeparator: Bool = false) -> Parser<Array<Value>> {
        .init { input in
            guard let (value, output) = try parse(input) else { return ([], input) }

            var result = [value]

            var input = output

            while let (_, output) = try separator.parse(input) {
                guard let (value, output) = try parse(output) else {
                    if allowingTrailingSeparator { input = output }

                    break
                }

                result.append(value)

                input = output
            }

            return (result, input)
        }
    }

}
