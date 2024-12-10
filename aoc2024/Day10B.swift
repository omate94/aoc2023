import Foundation

private struct Position: Hashable {
    let x: Int
    let y: Int
}

class Day10B {
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        
        var startPositions = [Position]()
        
        for i in 0..<input.count {
            for j in 0..<input[i].count {
                if input[i][j] == 0 {
                    startPositions.append(Position(x: j, y: i))
                }
            }
        }
        
        var count = 0
        
        for startPosition in startPositions {
            var currentSteps: Array<Position> = [startPosition]

            while !currentSteps.isEmpty {
                var nextSteps: Array<Position> = []
                for currentStep in currentSteps {
                    if input[currentStep.y][currentStep.x] == 9 {
                        count += 1
                    }
                    let newSteps = makeStep(from: currentStep, map: input)
                    nextSteps.append(contentsOf: newSteps)
                }
                currentSteps = nextSteps
            }
        }

        return String(count)
    }
    
    private func makeStep(from position: Position, map: [[Int]]) -> Set<Position> {
        var nextSteps: Set<Position> = []
        let val = map[position.y][position.x]
        if position.x == 0 && position.y == 0 {
            if map[position.y+1][position.x] == val + 1 {
                nextSteps.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x+1] == val + 1 {
                nextSteps.insert(Position(x: position.x+1, y: position.y))
            }
        } else if position.x == 0 && position.y == map.count - 1 {
            if map[position.y-1][position.x] == val + 1 {
                nextSteps.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y][position.x+1] == val + 1 {
                nextSteps.insert(Position(x: position.x+1, y: position.y))
            }
        } else if position.x == map.first!.count - 1 && position.y == 0 {
            if map[position.y+1][position.x] == val + 1 {
                nextSteps.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x-1] == val + 1 {
                nextSteps.insert(Position(x: position.x-1, y: position.y))
            }
            return nextSteps
        } else if position.x == map.first!.count - 1 && position.y == map.count - 1 {
            if map[position.y-1][position.x] == val + 1 {
                nextSteps.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y][position.x-1] == val + 1 {
                nextSteps.insert(Position(x: position.x-1, y: position.y))
            }
        } else if position.x == 0 {
            if map[position.y-1][position.x] == val + 1 {
                nextSteps.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y+1][position.x] == val + 1 {
                nextSteps.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x+1] == val + 1 {
                nextSteps.insert(Position(x: position.x+1, y: position.y))
            }
        } else if position.y == 0 {
            if map[position.y+1][position.x]  == val + 1 {
                nextSteps.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x-1]  == val + 1 {
                nextSteps.insert(Position(x: position.x-1, y: position.y))
            }
            
            if map[position.y][position.x+1] == val + 1 {
                nextSteps.insert(Position(x: position.x+1, y: position.y))
            }
        } else if position.x == map.first!.count - 1 {
            if map[position.y-1][position.x] == val + 1 {
                nextSteps.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y+1][position.x] == val + 1 {
                nextSteps.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x-1] == val + 1 {
                nextSteps.insert(Position(x: position.x-1, y: position.y))
            }
        } else if position.y == map.count - 1 {
            if map[position.y-1][position.x]  == val + 1 {
                nextSteps.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y][position.x-1] == val + 1 {
                nextSteps.insert(Position(x: position.x-1, y: position.y))
            }
            
            if map[position.y][position.x+1] == val + 1 {
                nextSteps.insert(Position(x: position.x+1, y: position.y))
            }
        } else {
            if map[position.y-1][position.x] == val + 1 {
                nextSteps.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y+1][position.x] == val + 1 {
                nextSteps.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x+1] == val + 1 {
                nextSteps.insert(Position(x: position.x+1, y: position.y))
            }
            
            if map[position.y][position.x-1] == val + 1 {
                nextSteps.insert(Position(x: position.x-1, y: position.y))
            }
        }
        
        return nextSteps
    }
    
    
    private func parse(path: String) -> [[Int]] {
        let fileURL = URL(fileURLWithPath: path)
        let tmp = try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
            .map { Array($0).map { String($0) } }
        
        return tmp.map {
            $0.map {
                if $0 == "." {
                    return -1
                } else {
                    return Int($0)!
                }
            }
        }
    }
}

extension Day10B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "10_test.txt")
        } else {
            return run(path: testPath + "10.txt")
        }
    }
}

