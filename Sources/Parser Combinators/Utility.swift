//
// Utility.swift
//
// Created by Marcel Tesch on 2021-09-15.
// Think different.
//

extension String {

    var substring: Substring { self[startIndex ..< endIndex] }

}

extension Substring {

    init(_ left: Substring, _ right: Substring) {
        precondition(left.base == right.base)
        precondition(left.endIndex == right.startIndex)

        self = left.base[left.startIndex ..< right.endIndex]
    }

}
