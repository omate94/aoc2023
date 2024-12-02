//
//  Day21A.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 24..
//

import Foundation

private struct Position: Hashable {
    let x: Int
    let y: Int
}

class Day21A {
    private var map: [[String]] = []
    private func run(path: String) -> String {
        map = parse(path: path)
        var start: Position?
        var cache: [Position:Set<Position>] = [:]
        
        for (i, line) in map.enumerated() {
            for (j, element) in line.enumerated() {
                if element == "S" {
                    start = Position(x: j, y:i)
                }
            }
        }
        
        guard let start = start else { fatalError() }
        
        var currentSteps: Set<Position> = [start]
        
        for i in 0..<10 {
            var nextSteps: Set<Position> = []
            for currentStep in currentSteps {
                if let cachedSteps = cache[currentStep] {
                    nextSteps = cachedSteps.union(nextSteps)
                } else {
                    let newSteps = makeStep(from: currentStep)
                    cache[currentStep] = nextSteps
                    nextSteps = newSteps.union(nextSteps)
                }
            }
            currentSteps = nextSteps
        }
            
        
        return String(currentSteps.count)
    }
    
    private func makeStep(from position: Position) -> Set<Position> {
        var nextSteps: Set<Position> = []
        if position.x == 0 && position.y == 0 {
            if map[position.y+1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.insert(Position(x: position.x+1, y: position.y))
            }
        } else if position.x == 0 && position.y == map.count - 1 {
            if map[position.y-1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.insert(Position(x: position.x+1, y: position.y))
            }
        } else if position.x == map.first!.count - 1 && position.y == 0 {
            if map[position.y+1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.insert(Position(x: position.x-1, y: position.y))
            }
            return nextSteps
        } else if position.x == map.first!.count - 1 && position.y == map.count - 1 {
            if map[position.y-1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.insert(Position(x: position.x-1, y: position.y))
            }
        } else if position.x == 0 {
            if map[position.y-1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y+1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.insert(Position(x: position.x+1, y: position.y))
            }
        } else if position.y == 0 {
            if map[position.y+1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.insert(Position(x: position.x-1, y: position.y))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.insert(Position(x: position.x+1, y: position.y))
            }
        } else if position.x == map.first!.count - 1 {
            if map[position.y-1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y+1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.insert(Position(x: position.x-1, y: position.y))
            }
        } else if position.y == map.count - 1 {
            if map[position.y-1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.insert(Position(x: position.x-1, y: position.y))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.insert(Position(x: position.x+1, y: position.y))
            }
        } else {
            if map[position.y-1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y+1][position.x] != "#" {
                nextSteps.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.insert(Position(x: position.x+1, y: position.y))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.insert(Position(x: position.x-1, y: position.y))
            }
        }
        
        return nextSteps
    }
    
    private func parse(path: String) -> [[String]] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
            .map { Array($0).map { String($0) } }
    }
}

extension Day21A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/21_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/21.txt")
        }
    }
}
