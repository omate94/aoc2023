//
//  Day4A.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 04..
//

import Foundation

fileprivate struct Card {
    let winners: [Int]
    let nums: [Int]
}

class Day4A {
    private func run(path: String) -> String {
        let cards = parse(path: path)
        
        var points = 0
        for card in cards {
            var count = 0
            for num in card.nums {
                if card.winners.contains(num) {
                    count = count + 1
                }
            }
            if count > 0 {
                points += Int(pow(Double(2), Double(count-1)))
            }
            
            count = 0
        }
        
        return String(points)
    }
    
    private func parse(path: String) -> [Card] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
            .map {
                guard let index = $0.firstIndex(of: ":") else {
                    return $0
                }
                
                var mySubstring = $0[index...]
                mySubstring.removeFirst(2)
                return String(mySubstring)
            }
            .map {
                $0.components(separatedBy: "|")
            }
            .map {
                let winners = $0[0].trimmingCharacters(in: [" "]).components(separatedBy: " ").filter { $0 != "" }.map {Int($0)!}.sorted()
                let nums = $0[1].trimmingCharacters(in: [" "]).components(separatedBy: " ").filter { $0 != "" }.map {Int($0)!}.sorted()
                return Card(winners: winners, nums: nums)
            }
    }
}

extension Day4A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/4_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/4.txt")
        }
    }
}
