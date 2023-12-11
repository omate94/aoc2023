//
//  Day1A.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 04..
//

import Foundation

class Day1A {
    private func run(path: String) -> String {
        let numbers = parse(path: path)
        
        var result: [Int] = []
        
        numbers.forEach {
            let firstDigit = $0.first!!
            let lastDigit = $0.last!!
            let number =  Int(String(firstDigit) + String(lastDigit))!
            result.append(number)
        }
        
        return String(result.reduce(0,+))
    }
    
    private func parse(path: String) -> [[Int?]] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
            .compactMap { Array($0) }
            .map {
                $0.map { Int(String($0)) }
                    .filter { $0 != nil }
            }
    }
}

extension Day1A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/1a_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/1.txt")
        }
    }
}
