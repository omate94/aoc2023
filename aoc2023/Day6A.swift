//
//  Day6A.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 06..
//

import Foundation

private struct Race {
    let time: Int
    let distance: Int
}

class Day6A {
    private func run(path: String) -> String {
        let races = parse(path: path)
        
        var result: [Int] = []
        races.forEach {
            var option: [Int] = []
            for i in 0..<$0.time+1 {
                if i * ($0.time - i) > $0.distance {
                    option.append(i)
                }
            }
            result.append(option.count)
        }
        
        return String(result.reduce(1, *))
    }
    
    private func parse(path: String) -> [Race] {
        let fileURL = URL(fileURLWithPath: path)
        let input = try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
        let times = input[0]
            .replacingOccurrences(of: "Time:", with: "")
            .trimmingCharacters(in: [" "])
            .components(separatedBy: " ")
            .filter { $0 != "" }
            .map { Int($0)! }
        let distances = input[1]
            .replacingOccurrences(of: "Distance:", with: "")
            .trimmingCharacters(in: [" "])
            .components(separatedBy: " ")
            .filter { $0 != "" }
            .map { Int($0)! }
        
        var races: [Race] = []
        
        for (i,time) in times.enumerated() {
            races.append(Race(time: time, distance: distances[i]))
        }
        
        return races
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
