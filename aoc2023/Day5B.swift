//
//  Day5B.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 04..
//

import Foundation

class Day5B {
    private func run(path: String) -> String {
        let result = parse(path: path)
        return "No result"
    }
    
    private func parse(path: String) -> String {
        let fileURL = URL(fileURLWithPath: path)
        let input = try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
        return ""
    }
}

extension Day5B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/5b_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/5b.txt")
        }
    }
}
