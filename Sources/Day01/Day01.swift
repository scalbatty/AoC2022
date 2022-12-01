//
//  Day01.swift
//  AoC-Swift-Template
//  Forked from https://github.com/Dean151/AoC-Swift-Template
//
//  Created by Thomas DURAND.
//  Follow me on Twitter @deanatoire
//  Check my computing blog on https://www.thomasdurand.fr/
//

import Foundation

import AoC
import Common

@main
struct Day01: Puzzle {
    typealias Input = String
    typealias OutputPartOne = Int
    typealias OutputPartTwo = Int
}

// MARK: - PART 1

extension Day01 {
    static var partOneExpectations: [any Expectation<Input, OutputPartOne>] {
        [
            assert(expectation: 2000, from: "2000"),
            assert(expectation: 3000, from:
"""
2000
1000
"""
                  ),
            assert(expectation: 3000, from:
"""
2000
1000

1000
"""
                   ),
            assert(expectation: 5000, from:
"""
1000
2000

2000
1000
2000
"""
                   ),
        ]
    }

    static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
        (input + ["\n"])
            .components(separatedBy: .newlines)
            .reduce(into: (best: 0, current: 0)) { acc, new in
                if let intValue = Int(new) {
                    acc.current += intValue
                    print(acc.current)
                } else {
                    if acc.current > acc.best {
                        acc.best = acc.current
                    }
                    acc.current = 0
                }
            }
            .best
    }
}

// MARK: - PART 2

extension Day01 {
    static var partTwoExpectations: [any Expectation<Input, OutputPartTwo>] {
        [
            assert(expectation: 11000, from:
"""
1000
2000

2000
1000
2000

3000
"""
                   ),
            assert(expectation: 11000, from:
"""
1000
2000

1000

2000
1000
2000

3000
"""
                   ),
        ]
    }

    static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
        (input + ["\n"])
            .components(separatedBy: .newlines)
            .reduce(into: (tops: [], current: Int(0))) { acc, new in
                if let intValue = Int(new) {
                    acc.current += intValue
                    print(acc.current)
                } else {
                    tryInsert(acc.current, in: &acc.tops)
                    acc.current = 0
                }
            }
            .tops
            .reduce(0, +)
    }

    static func tryInsert(_ candidate: Int, in tops: inout [Int]) {
        let maxTops = 3

        guard tops.count < maxTops || candidate > tops[0] else { return }

        tops.append(candidate)
        tops.sort()
        tops = Array(tops.suffix(maxTops))
    }
}
