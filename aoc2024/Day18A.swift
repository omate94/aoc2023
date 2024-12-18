import Foundation

class Day18A {
    struct Position: Hashable {
        let x: Int
        let y: Int
    }
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        
        let map = createMap(bytes: Array(input[0..<1024]))
        
        let start = Position(x: 0, y: 0)
        let destination = Position(x: 70, y: 70)
        
        var currentSteps: [Position] = [start]
        var prices: [Position: Int] = [start: 0]
        
        while !currentSteps.isEmpty {
            var nextSteps: [Position] = []
            for currentStep in currentSteps {
                let newSteps = makeStep(from: currentStep, map: map)
                var validSteps: [Position] = []
                for newStep in newSteps {
                    let currentPrice = prices[currentStep]!
                    if let newStepPrice = prices[newStep] {
                        if newStepPrice > currentPrice + 1 {
                            validSteps.append(newStep)
                            prices[newStep] = currentPrice + 1
                        }
                    } else {
                        validSteps.append(newStep)
                        prices[newStep] = currentPrice + 1
                    }
                }
                nextSteps.append(contentsOf: validSteps)
            }
            currentSteps = nextSteps
        }
        
        return String(prices[destination]!)
    }
    
    private func createMap(bytes: [Position]) -> [[String]] {
        var map = Array(repeating: Array(repeating: ".", count: 71), count: 71)
        
        for byte in bytes {
            map[byte.y][byte.x] = "#"
        }

        return map
    }
    
    private func parse(path: String) -> [Position] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8)
            .split(separator: "\n")
            .map {
                String($0).split(separator: ",").map { Int($0)! }
            }
            .map {
                Position(x: $0.first!, y: $0.last!)
            }
    }
    
    private func makeStep(from position: Position, map: [[String]]) -> Set<Position> {
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
    
}

extension Day18A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "18_test.txt")
        } else {
            return run(path: testPath + "18.txt")
        }
    }
}

