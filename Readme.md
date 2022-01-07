`ParserCombinators` provides a set of elementary building blocks for deriving structured information from unstructured string data.

## Overview

Parsers are represented by a function of the form `(Substring) throws -> (Value, Substring)?`. A substring is taken as input and a parsed result as well as the unparsed remainder of the input are returned. An error may be thrown if some kind of invalid state is encountered during parsing and `nil` is returned if the parser isn't able to parse the desired result from the given input.

The package defines a number of primitive parsers capable of matching user-defined sequences of characters (e.g. [`character` and `substring`][substring]) as well as various modifiers which can either change a parser's behavior (e.g. [`map`][map] and [`filter`][filter]) or combine multiple parsers into a single, more sophisticated parser (e.g. [`join`][join], [`fallback`][fallback], and [`chain`][chain]).

## Example

Constructing a parser to match a bracketed comma-separated list of words might look something like this:

```swift
extension Parser {

    static var listExpression: Parser<Array<String>> {
        .character("[").trailingPadding()

        .joinRight(to:
            .substring(\.isLetter)
            .chain(with: .whitespace)
            .map(String.init)

            .collection(separatedBy: .character(",").padding(), allowingTrailingSeparator: true)
        )

        .joinLeft(to: .character("]").leadingPadding())
    }

}
```

Applying the parser is straightforward and produces the desired result:

```swift
let cities = "  [ London, New York  ,  San Francisco ,] "

let parser: Parser<Array<String>> = .listExpression.padding().terminate()

if let (cities, _) = try? parser.parse(cities) {
    print(cities) // ["London", "New York", "San Francisco"]
}
```

More examples can be found [here][examples].

[substring]: https://github.com/tesch/ParserCombinators/blob/main/Sources/Parser%20Combinators/Substring.swift

[map]: https://github.com/tesch/ParserCombinators/blob/main/Sources/Parser%20Combinators/Modifiers/Map.swift
[filter]: https://github.com/tesch/ParserCombinators/blob/main/Sources/Parser%20Combinators/Modifiers/Filter.swift

[join]: https://github.com/tesch/ParserCombinators/blob/main/Sources/Parser%20Combinators/Modifiers/Join.swift
[fallback]: https://github.com/tesch/ParserCombinators/blob/main/Sources/Parser%20Combinators/Modifiers/Fallback.swift
[chain]: https://github.com/tesch/ParserCombinators/blob/main/Sources/Parser%20Combinators/Modifiers/Chain.swift

[examples]: https://github.com/tesch/ParserCombinators/tree/main/Sources/Examples/Parsers
