//
//  Day03.swift
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
struct Day03: Puzzle {
    typealias Input = String
    typealias OutputPartOne = Int
    typealias OutputPartTwo = Int
}

let exampleInput = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

// MARK: - PART 1

extension Day03 {
    static var partOneExpectations: [any Expectation<Input, OutputPartOne>] {
        [
            assert(expectation: 161, from: exampleInput)
        ]
    }

    static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
        let regex = #/mul\((\d{1,3}),(\d{1,3})\)/#
        return input.matches(of: regex).reduce(0) { sum, match in
            sum + Int(match.1)! * Int(match.2)!
        }
    }
}

let exampleInput2 = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

// MARK: - PART 2

extension Day03 {
    static var partTwoExpectations: [any Expectation<Input, OutputPartTwo>] {
        [
            assert(expectation: 48, from: exampleInput2)
        ]
    }

    static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
        let regex = #/(!?mul\((\d{1,3}),(\d{1,3})\))|(do\(\))|(don't\(\))/#
        var enabled = true
        return input.matches(of: regex).reduce(0) { sum, match in
            if match.0 == "do()" {
                enabled = true
                return sum
            }
            if match.0 == "don't()" {
                enabled = false
                return sum
            }
            return enabled ? sum + Int(match.2!)! * Int(match.3!)! : sum
        }
    }
}
