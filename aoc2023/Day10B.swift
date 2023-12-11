//
//  Day10B.swift
//  aoc2023
//
//  Created by Mate Olah on 2023. 12. 10..
//

import Foundation

class Day10B {
    private func run(path: String) -> String {
        return "no result"
    }
}

extension Day10B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/10_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/10.txt")
        }
    }
}
