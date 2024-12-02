//
//  Day9A.swift
//  aoc2023
//
//  Created by Mate Olah on 2023. 12. 10..
//

import Foundation

class Day9A {
    private func run(path: String) -> String {
        let histories = parse(path: path)
        
        let result = histories.map { history in
            Array(createSequences(for: history).reversed())
        }.reduce(0, { (res, sequences) in
            res + extrapolate(on: sequences)
        })
        
        return String(result)
    }
    
    private func extrapolate(on sequences: [[Int]]) -> Int {
        var mutableSequences = sequences
        mutableSequences[0].append(0)
        
        for i in 1..<mutableSequences.count {
            let last = mutableSequences[i].last!
            let prevLast = mutableSequences[i-1].last!
            let newLast = last + prevLast
            mutableSequences[i].append(newLast)
        }
        
        return mutableSequences.last!.last!
    }
    
    private func createSequences(for history: [Int]) -> [[Int]] {
        var result:[[Int]] = [history]
        while (!isEnd(values: result.last!)) {
            let line = result.last!
            var nextLine: [Int] = []
            
            for i in 0..<line.count - 1 {
                let nextItem = line[i+1] - line[i]
                nextLine.append(nextItem)
            }
            result.append(nextLine)
        }
        
        return result
    }
    
    private func isEnd(values: [Int]) -> Bool {
        for value in values {
            if value != 0 {
                return false
            }
        }
        return true
    }
    
    private func parse(path: String) -> [[Int]] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
            .map {
                $0.components(separatedBy: " ").map { Int($0)! }
            }
    }
}

extension Day9A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/9_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/9.txt")
        }
    }
}
