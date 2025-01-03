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

private let cardMap: [String: Int] = [
    "J" : 1,
    "2" : 2,
    "3" : 3,
    "4" : 4,
    "5" : 5,
    "6" : 6,
    "7" : 7,
    "8" : 8,
    "9" : 9,
    "T" : 10,
    "Q" : 11,
    "K" : 12,
    "A" : 13,
]

private struct Hand {
    let cards: [String]
    let bet: Int
    var strength: Strength {
        calculateStrength()
    }
    
    private func calculateStrength() -> Strength {
        let counts = cards.reduce(into: [:]) { $0[$1, default: 0] += 1 }
        let numOfJ = counts["J"] ?? 0
        if counts.count == 5 {
            if numOfJ == 1 {
                return .OnePair
            }
            return .High
        } else if counts.count == 4 {
            if numOfJ == 2 || numOfJ == 1 {
                return .Drill
            }
            return .OnePair
        } else if counts.count == 3 {
            if numOfJ == 3 {
                return .Poker
            }
            
            if let _ = counts.values.first(where: { $0 == 3 }) {
                if numOfJ == 1 {
                    return .Poker
                }
                return .Drill
            }
            
            if numOfJ == 2 {
                return .Poker
            }
            
            if numOfJ == 1 {
                return .Full
            }
            
            return .TwoPair
        } else if counts.count == 2 {
            if numOfJ == 4 {
                return .Royal
            }
            
            if let _ = counts.values.first(where: { $0 == 4 }) {
                if numOfJ == 1 {
                    return .Royal
                }
                return .Poker
            }
            
            if numOfJ == 3 || numOfJ == 2 {
                return .Royal
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

class Day7B {
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

extension Day7B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/7_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/7.txt")
        }
    }
}
