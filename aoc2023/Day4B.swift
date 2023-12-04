//
//  Day4B.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 04..
//

import Foundation

fileprivate struct Card {
    let id: Int
    let winers: [Int]
    let nums: [Int]
}

class Day4B {
    private func run(path: String) -> String {
        let cards = parse(path: path)

        var cardsCopyCounter: [Int: Int] = [:]
        for i in 1...cards.count {
            cardsCopyCounter[i] = 1
        }
        
        for card in cards {
            var count = 0
            card.nums.forEach {
                if card.winers.contains($0) {
                    count = count + 1
                }
            }
            
            if count == 0 {
                continue
            }
            
            let newCopies = cardsCopyCounter[card.id]!
            for idx in (card.id + 1)...(count + card.id) {
                let cardCopies = cardsCopyCounter[idx]!
                cardsCopyCounter[idx] = cardCopies + newCopies
            }
        }
        
        return String(cardsCopyCounter.values.reduce(0, +))
    }
    
    private func parse(path: String) -> [Card] {
        let fileURL = URL(fileURLWithPath: path)
        var cardID = 1
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
                let winers = $0[0].trimmingCharacters(in: [" "]).components(separatedBy: " ").filter { $0 != "" }.map {Int($0)!}.sorted()
                let nums = $0[1].trimmingCharacters(in: [" "]).components(separatedBy: " ").filter { $0 != "" }.map {Int($0)!}.sorted()
                let card = Card(id: cardID, winers: winers, nums: nums)
                cardID = cardID + 1
                return card
            }
    }
}

extension Day4B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/4_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/4b.txt")
        }
    }
}
