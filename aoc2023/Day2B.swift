//
//  Day2B.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 04..
//

import Foundation

fileprivate struct Game {
    let id: Int
    let rounds: [Round]
}

fileprivate typealias Round = (red: Int, blue: Int, green: Int)

class Day2B {
    private func run(path: String) -> String {
        let games = parse(path: path)
        var result: [Int] = []
        
        games.forEach {
            var maxR = 0
            var maxG = 0
            var maxB = 0
            
            $0.rounds.forEach {
                if $0.green > maxG {
                    maxG = $0.green
                }
                
                if $0.red > maxR {
                    maxR = $0.red
                }
                
                if $0.blue > maxB {
                    maxB = $0.blue
                }
            }
            
            result.append(maxB*maxG*maxR)
        }

        return String(result.reduce(0,+))
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
        let round = tmp[1].components(separatedBy: ";").map { $0.components(separatedBy: ",")}
        var rounds: [Round] = []
    
        round.forEach {
            rounds.append(parseRond(round: $0))
        }
    
        return Game(id: gameId, rounds: rounds)
    }
    
    private func parseRond(round: [String]) -> Round {
        var red = 0
        var blue = 0
        var green = 0
    
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
    
        return (red: red, blue: blue, green: green)
    }
}

extension Day2B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/2_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/2.txt")
        }
    }
}
