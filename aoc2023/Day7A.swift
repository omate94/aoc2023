//
//  Day7A.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 07..
//

import Foundation

private enum Strength: Int {
    case High = 0
    case OnePair
    case TwoPair
    case Drill
    case Full
    case Poker
    case Royal
}

private struct Hand {
    let cards: [String]
    let bet: Int
    
    var strength: Strength {
        calculateStrength()
    }
    
    private let cardMap: [String: Int] = [
        "2" : 2,
        "3" : 3,
        "4" : 4,
        "5" : 5,
        "6" : 6,
        "7" : 7,
        "8" : 8,
        "9" : 9,
        "T" : 10,
        "J" : 11,
        "Q" : 12,
        "K" : 13,
        "A" : 14,
    ]
    
    private func calculateStrength() -> Strength {
        let counts = cards.reduce(into: [:]) { $0[$1, default: 0] += 1 }
        if counts.count == 5 {
            return .High
        } else if counts.count == 4 {
            return .OnePair
        } else if counts.count == 3 {
            if let _ = counts.values.first(where: { $0 == 3 }) {
                return .Drill
            }
            return .TwoPair
        } else if counts.count == 2 {
            if let _ = counts.values.first(where: { $0 == 4 }) {
                return .Poker
            }
            return .Full
        } else {
            return .Royal
        }
    }
    
    func isSmaller(than opponent: Hand) -> Bool {
        for (i, card) in self.cards.enumerated() {
            let selfVal = cardMap[card]!
            let opponentVal = cardMap[opponent.cards[i]]!
            if selfVal != opponentVal {
                return  selfVal < opponentVal
            }
        }
        fatalError("Something went wrong")
    }
}

class Day7A {
    private func run(path: String) -> String {        
        let hands = parse(path: path)
        
        let sortedStrengthGroups = hands.reduce(into: [Int: [Hand]]()) {
            if let value = $0[$1.strength.rawValue] {
                var newValue = value
                newValue.append($1)
                $0[$1.strength.rawValue] = newValue
            } else {
                $0[$1.strength.rawValue] = [$1]
            }
        }.sorted(by: { $0.key < $1.key })
        
        var result: [Int] = []
        var multiplier = 1
        
        for sortedStrengthGroup in sortedStrengthGroups {
            let sortedHands = sortedStrengthGroup.value.sorted { $0.isSmaller(than: $1) }
            for hand in sortedHands {
                result.append(hand.bet * multiplier)
                multiplier += 1
            }
        }
        
        let val = result.reduce(0, +)
        return String(val)
    }
    
    private func parse(path: String) -> [Hand] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
            .map {
                let parts = $0.components(separatedBy: " ")
                let cards = Array(parts[0]).map { String($0) }
                let bet = Int(parts[1])!
                return Hand(cards: cards, bet: bet)
            }
    }
}

extension Day7A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/7_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/7a.txt")
        }
    }
}
