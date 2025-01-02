//
//  Day02.swift
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
import Algorithms

struct Report: Parsable {
    let levels: [Int]

    static func parse(raw: String) throws -> Report {
        .init(levels: raw.components(separatedBy: .whitespacesAndNewlines).compactMap(Int.init))
    }

    var isSafe: Bool {
        let increasing = levels.first! < levels.last!
        return levels.adjacentPairs().allSatisfy { a, b in
            (1...3).contains(increasing ? b - a : a - b)
        }
    }

    var isSafeWithTolerance: Bool {
        if isSafe {
            return true
        }
        return levels.combinations(ofCount: levels.count - 1).map { Report(levels: $0) }.contains(where: \.isSafe)
    }
}

@main
struct Day02: Puzzle {
    typealias Input = [Report]
    typealias OutputPartOne = Int
    typealias OutputPartTwo = Int
}

let exampleInput = """
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
"""

// MARK: - PART 1

extension Day02 {
    static var partOneExpectations: [any Expectation<Input, OutputPartOne>] {
        [
            assert(expectation: 2, fromRaw: exampleInput),
        ]
    }

    static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
        input.count(where: \.isSafe)
    }
}

// MARK: - PART 2

extension Day02 {
    static var partTwoExpectations: [any Expectation<Input, OutputPartTwo>] {
        [
            assert(expectation: 4, fromRaw: exampleInput),
        ]
    }

    static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
        input.count(where: \.isSafeWithTolerance)
    }
}
