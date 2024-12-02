//
//  Day2A.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 04..
//

import Foundation

fileprivate struct Game {
    let id: Int
    let rounds: [Round]
}

fileprivate typealias Round = (red: Int, green: Int, blue: Int)

class Day2A {
    private func run(path: String) -> String {
        let games = parse(path: path)
        
        var okIDs: [Int] = []
        
        games.forEach {
            var ok = true
            for round in $0.rounds {
                if round.red > 12 || round.green > 13 || round.blue > 14 {
                    ok = false
                    break
                }
            }
            if ok {
                okIDs.append($0.id)
            }
            ok = true
        }
        
        return String(okIDs.reduce(0,+))
    }
    
    private func parse(path: String) -> [Game] {
        let fileURL = URL(fileURLWithPath: path)
        let input = try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
        
        var result: [Game] = []
        input.forEach {
            result.append(parse(line: $0))
        }
        
        return result
    }
    
    private func parse(line: String) -> Game {
        let tmp = line.components(separatedBy: ":")
        let gameId = Int(tmp[0].replacingOccurrences(of: "Game", with: "").trimmingCharacters(in: [" ", ":"]))!
        let game = tmp[1].components(separatedBy: ";").map { $0.components(separatedBy: ",")}
        var rounds: [Round] = []
    
        game.forEach {
            rounds.append(parse(round: $0))
        }
    
        return Game(id: gameId, rounds: rounds)
    }
    
    private func parse(round: [String]) -> Round {
        var red = 0
        var green = 0
        var blue = 0
    
        for r in round {
            if r.contains("red") {
                let num = r.replacingOccurrences(of: "red", with: "").trimmingCharacters(in: [" ", ","])
                red = Int(num)!
            } else  if r.contains("green") {
                let num = r.replacingOccurrences(of: "green", with: "").trimmingCharacters(in: [" ", ","])
                green = Int(num)!
            } else if r.contains("blue") {
                let num = r.replacingOccurrences(of: "blue", with: "").trimmingCharacters(in: [" ", ","])
                blue = Int(num)!
            }
        }
    
        return (red: red, green: green, blue: blue)
    }
}

extension Day2A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/2_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/2.txt")
        }
    }
}
