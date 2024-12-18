import Foundation

class Day16A {
    private struct Position: Hashable {
        let x: Int
        let y: Int
    }
    
    private struct Deer: Hashable {
        let position: Position
        let direction: Direction
    }
    
    private enum Direction: Hashable {
        case north, east, south, west
    }

    private func run(path: String) -> String {
        let input = parse(path: path)
        
        var startPosition: Position!
        for i in 0..<input.count {
            for j in 0..<input[i].count {
                if input[i][j] == "S" {
                    startPosition = Position(x: j, y: i)
                }
            }
        }
        
        var endPosition: Position!
        for i in 0..<input.count {
            for j in 0..<input[i].count {
                if input[i][j] == "E" {
                    endPosition = Position(x: j, y: i)
                }
            }
        }
        
        var currentSteps: [Deer] = [Deer(position: startPosition, direction: .east)]
        var prices: [Position: Int] = [startPosition: 0]
        
        while !currentSteps.isEmpty {
            var nextSteps: [Deer] = []
            for currentStep in currentSteps {
                let newSteps = makeStep(from: currentStep.position, map: input)
                var validSteps: [Deer] = []
                for newStep in newSteps {
                    let newPos = newStep.0
                    let newDir = newStep.1
                    let newDirPrice = newDir == currentStep.direction ? 0 : 1000
                    let currentPrice = prices[currentStep.position]!
                    if let newStepPrice = prices[newPos] {
                        if newStepPrice > currentPrice + 1 {
                            validSteps.append(Deer(position: newPos, direction: newDir))
                            prices[newPos] = currentPrice + 1 + newDirPrice
                        }
                    } else {
                        validSteps.append(Deer(position: newPos, direction: newDir))
                        prices[newPos] = currentPrice + 1 + newDirPrice
                    }
                }
                nextSteps.append(contentsOf: validSteps)
            }
            currentSteps = nextSteps
        }
        
        return String(prices[endPosition]!)
    }
    
    private func parse(path: String) -> [[String]] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8)
            .split(separator: "\n")
            .map {
                return Array($0)
                    .map { String($0) }
            }

    }
    
    private func makeStep(from position: Position, map: [[String]]) -> [(Position, Direction)] {
        var nextSteps: [(Position, Direction)] = []
        
        if map[position.y][position.x] == "E" {
            return []
        }
        
        if position.x == 0 && position.y == 0 {
            if map[position.y+1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y+1), .south))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.append((Position(x: position.x+1, y: position.y), .east))
            }
        } else if position.x == 0 && position.y == map.count - 1 {
            if map[position.y-1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y-1), .north))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.append((Position(x: position.x+1, y: position.y), .east))
            }
        } else if position.x == map.first!.count - 1 && position.y == 0 {
            if map[position.y+1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y+1), .south))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.append((Position(x: position.x-1, y: position.y), .west))
            }
            return nextSteps
        } else if position.x == map.first!.count - 1 && position.y == map.count - 1 {
            if map[position.y-1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y-1), .north))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.append((Position(x: position.x-1, y: position.y), .west))
            }
        } else if position.x == 0 {
            if map[position.y-1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y-1), .north))
            }
            
            if map[position.y+1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y+1), .south))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.append((Position(x: position.x+1, y: position.y), .east))
            }
        } else if position.y == 0 {
            if map[position.y+1][position.x]  != "#" {
                nextSteps.append((Position(x: position.x, y: position.y+1), .south))
            }
            
            if map[position.y][position.x-1]  != "#" {
                nextSteps.append((Position(x: position.x-1, y: position.y), .west))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.append((Position(x: position.x+1, y: position.y), .east))
            }
        } else if position.x == map.first!.count - 1 {
            if map[position.y-1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y-1), .north))
            }
            
            if map[position.y+1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y+1), .south))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.append((Position(x: position.x-1, y: position.y), .west))
            }
        } else if position.y == map.count - 1 {
            if map[position.y-1][position.x]  != "#" {
                nextSteps.append((Position(x: position.x, y: position.y-1), .north))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.append((Position(x: position.x-1, y: position.y), .west))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.append((Position(x: position.x+1, y: position.y), .east))
            }
        } else {
            if map[position.y-1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y-1), .north))
            }
            
            if map[position.y+1][position.x] != "#" {
                nextSteps.append((Position(x: position.x, y: position.y+1), .south))
            }
            
            if map[position.y][position.x+1] != "#" {
                nextSteps.append((Position(x: position.x+1, y: position.y), .east))
            }
            
            if map[position.y][position.x-1] != "#" {
                nextSteps.append((Position(x: position.x-1, y: position.y), .west))
            }
        }
        
        return nextSteps
    }
}

extension Day16A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "16_test.txt")
        } else {
            return run(path: testPath + "16.txt")
        }
    }
}

