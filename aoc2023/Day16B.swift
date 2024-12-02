import Foundation

private enum Direction {
    case left, right, up, down
}

private struct Position: Hashable {
    let x: Int
    let y: Int
}

private struct Beam {
    let position: Position
    let direction: Direction
}

class Day16B {
    private func run(path: String) -> String {
        let map = parse(path: path)
        var currentMax = 0
        
        for i in 0..<map.first!.count {
            let topRowItemVal = calculateTiles(map: map, startPosition: Position(x: i, y: 0), direction: .down)
            let bottomRowItemVal = calculateTiles(map: map, startPosition: Position(x: i, y: map.count - 1), direction: .up)
            currentMax = max(topRowItemVal, bottomRowItemVal, currentMax)
        }
        
        for i in 0..<map.count {
            let leftRowItemVal = calculateTiles(map: map, startPosition: Position(x: 0, y: i), direction: .right)
            let rightRowItemVal = calculateTiles(map: map, startPosition: Position(x: map.first!.count - 1, y: i), direction: .left)
            currentMax = max(leftRowItemVal, rightRowItemVal, currentMax)
        }
        
        return String(currentMax)
    }
    
    private func calculateTiles(map: [[String]], startPosition: Position, direction: Direction) -> Int {
        var beams: [Beam] = []
        var visitedTiles: [Position: [Direction]] = [:]
        let initialBeam = Beam(position: startPosition, direction: direction)
        beams.append(initialBeam)
        visitedTiles[initialBeam.position] = [initialBeam.direction]
        
        while !beams.isEmpty {
            var tmpBeams: [Beam] = []
            
            for beam in beams {
                let nextSteps = makeStep(map: map, beam: beam)
                
                for nextStep in nextSteps {
                    if let directions = visitedTiles[nextStep.position] {
                        if !directions.contains(nextStep.direction) {
                            tmpBeams.append(nextStep)
                            var tmpDirections = directions
                            tmpDirections.append(nextStep.direction)
                            visitedTiles[nextStep.position] = tmpDirections
                        }
                    } else {
                        tmpBeams.append(nextStep)
                        visitedTiles[nextStep.position] = [nextStep.direction]
                    }
                }
            }
            
            beams = tmpBeams
        }
        
        return visitedTiles.keys.count
    }
    
    private func makeStep(map: [[String]], beam: Beam) -> [Beam] {
        let currentTileType = map[beam.position.y][beam.position.x]
        
        if currentTileType == "-" && beam.direction != .left && beam.direction != .right {
            let leftPos = getNextPostion(map: map, position: beam.position, direction: .left)
            let rightPos = getNextPostion(map: map, position: beam.position, direction: .right)
            
            var result: [Beam] = []
            
            if let leftPos = leftPos {
                result.append(Beam(position: leftPos, direction: .left))
            }
            
            if let rightPos = rightPos {
                result.append(Beam(position: rightPos, direction: .right))
            }
            
            return result
        } else if currentTileType == "|" && beam.direction != .up && beam.direction != .down {
            let upPos = getNextPostion(map: map, position: beam.position, direction: .up)
            let downPos = getNextPostion(map: map, position: beam.position, direction: .down)
            
            var result: [Beam] = []
            
            if let upPos = upPos {
                result.append(Beam(position: upPos, direction: .up))
            }
            
            if let downPos = downPos {
                result.append(Beam(position: downPos, direction: .down))
            }
            
            return result
        } else if currentTileType == "\\" {
            let nextDir: Direction = {
                switch beam.direction {
                case .down:
                    return .right
                case.up:
                    return .left
                case .left:
                    return .up
                case .right:
                    return .down
                }
            }()
            guard let nextTilePos = getNextPostion(map: map, position: beam.position, direction: nextDir) else { return [] }
            return [Beam(position: nextTilePos, direction: nextDir)]
        } else if currentTileType == "/" {
            let nextDir: Direction = {
                switch beam.direction {
                case .down:
                    return .left
                case.up:
                    return .right
                case .left:
                    return .down
                case .right:
                    return .up
                }
            }()
            guard let nextTilePos = getNextPostion(map: map, position: beam.position, direction: nextDir) else { return [] }
            return [Beam(position: nextTilePos, direction: nextDir)]
        } else {
            guard let nextTilePos = getNextPostion(map: map, position: beam.position, direction: beam.direction) else { return [] }
            return [Beam(position: nextTilePos, direction: beam.direction)]
        }
    }
    
    private func getNextPostion(map: [[String]], position: Position, direction: Direction) -> Position? {
        var nextTilePos: Position?
        switch direction {
        case .left:
            if position.x > 0 {
                nextTilePos = Position(x: position.x-1, y: position.y)
            }
            
            break
        case .right:
            if position.x < map.first!.count - 1  {
                nextTilePos = Position(x: position.x+1, y: position.y)
            }
            break
        case .up:
            if position.y > 0 {
                nextTilePos = Position(x: position.x, y: position.y-1)
            }
            
            break
        case .down:
            if position.y < map.count - 1   {
                nextTilePos = Position(x: position.x, y: position.y+1)
            }
            break
        }
        
        return nextTilePos
    }
    
    private func parse(path: String) -> [[String]] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
            .map { val in
                return Array(val).map { String($0) }
            }
    }
}

extension Day16B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/16_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/16.txt")
        }
    }
}

