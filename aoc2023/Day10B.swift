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
            let test1Result = run(path: "/Users/olahmate/aoc2023/tests/10b_test_1.txt")
            let test2Result = run(path: "/Users/olahmate/aoc2023/tests/10b_test_2.txt")
            let test3Result = run(path: "/Users/olahmate/aoc2023/tests/10b_test_3.txt")
            let test4Result = run(path: "/Users/olahmate/aoc2023/tests/10b_test_4.txt")
            return "Test 1: \(test1Result), Test 2: \(test2Result), Test 3: \(test1Result), Test 4: \(test2Result)"
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/10.txt")
        }
    }
}
