//
//  Day6A.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 06..
//

import Foundation

class Day6A {
    private func run(path: String) -> String {
        return "No Result"
    }
    
    private func parse(path: String) {
        let fileURL = URL(fileURLWithPath: path)
        try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
    }
}

extension Day6A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/6_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/6.txt")
        }
    }
}
