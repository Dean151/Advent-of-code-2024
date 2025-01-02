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

struct List: Parsable {
    let left: [Int]
    let right: [Int]

    static func parse(raw: String) throws -> List {
        var left: [Int] = []
        var right: [Int] = []
        for line in raw.components(separatedBy: .newlines) {
            let numberStrings = line.components(separatedBy: "   ").compactMap(Int.init)
            guard numberStrings.count == 2 else {
                throw InputError.couldNotCast(target: Int.self)
            }
            left.append(numberStrings[0])
            right.append(numberStrings[1])
        }
        return .init(left: left, right: right)
    }

    var distance: Int {
        let left = left.sorted()
        let right = right.sorted()
        return zip(left, right).reduce(0) { distance, pair in
            distance + abs(pair.0 - pair.1)
        }
    }

    var similarity: Int {
        let amounts = right.reduce(into: [Int: Int]()) { amounts, number in
            amounts[number, default: 0] += 1
        }
        return left.reduce(0) { similarity, number in
            similarity + number * amounts[number, default: 0]
        }
    }
}

@main
struct Day01: Puzzle {
    typealias Input = List
    typealias OutputPartOne = Int
    typealias OutputPartTwo = Int
}

let exampleInput = """
3   4
4   3
2   5
1   3
3   9
3   3
"""

// MARK: - PART 1

extension Day01 {
    static var partOneExpectations: [any Expectation<Input, OutputPartOne>] {
        [
            assert(expectation: 11, fromRaw: exampleInput)
        ]
    }

    static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
        return input.distance
    }
}

// MARK: - PART 2

extension Day01 {
    static var partTwoExpectations: [any Expectation<Input, OutputPartTwo>] {
        [
            assert(expectation: 31, fromRaw: exampleInput)
        ]
    }

    static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
        input.similarity
    }
}
