//
//  Day5A.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 04..
//

import Foundation

class Day5A {
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

extension Day5A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/5a_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/5a.txt")
        }
    }
}
