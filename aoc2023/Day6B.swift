//
//  Day6B.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 06..
//

import Foundation

private struct Race {
    let time: Int
    let distance: Int
}

class Day6B {
    private func run(path: String) -> String {
        let race = parse(path: path)
        var result: [Int] = []
        
        var isOver = false
        for i in 0..<race.time+1 {
            if i * (race.time - i) > race.distance {
                isOver = true
                result.append(i)
            } else if isOver {
                break
            }
        }
        
        return String(result.count)
    }
    
    private func parse(path: String) -> Race {
        let fileURL = URL(fileURLWithPath: path)
        let input = try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
        let timeStr = input[0]
            .replacingOccurrences(of: "Time:", with: "")
            .trimmingCharacters(in: [" "])
            .replacingOccurrences(of: " ", with: "")

        let distanceStr = input[1]
            .replacingOccurrences(of: "Distance:", with: "")
            .trimmingCharacters(in: [" "])
            .replacingOccurrences(of: " ", with: "")
        
        let time = Int(timeStr)!
        let distance = Int(distanceStr)!
        
        return Race(time: time, distance: distance)
    }
}

extension Day6B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/6_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/6.txt")
        }
    }
}
