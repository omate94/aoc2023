import Foundation
import aoc2023

private struct Step: Equatable, Hashable {
    let x: Int
    let y: Int
    
    static func == (lhs: Step, rhs: Step) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
}

private enum Directions: String {
    case up
    case down
    case left
    case right
}

class Day6A {
    
    private func run(path: String) -> String {
        let input = parse(path: path)

        let start = findStart(map: input)
        var postion: Step? = start.postion
        var direction: Directions? = start.direction
        var visited = Set<Step>()
        visited.insert(postion!)
        while postion != nil {
            let step = nextStep(from: postion!, direction: direction!, map: input)
            postion = step?.postion
            direction = step?.direction
            if let pos = postion {
                visited.insert(pos)
            }
        }
        
        return String(visited.count)
    }
    
    private func nextStep(from: Step, direction: Directions, map: [[String]]) -> (postion: Step, direction: Directions)? {
        switch direction {
        case .up:
            let nextPos = Step(x: from.x, y: from.y - 1)
            if nextPos.y >= 0 {
                if map[nextPos.y][nextPos.x] == "#" {
                    return (from, .right)
                } else {
                    return (nextPos, direction)
                }
            } else {
                return nil
            }
        case .down:
            let nextPos = Step(x: from.x, y: from.y + 1)
            if nextPos.y < map.count {
                if map[nextPos.y][nextPos.x] == "#" {
                    return (from, .left)
                } else {
                    return (nextPos, direction)
                }
            } else {
                return nil
            }
        case .left:
            let nextPos = Step(x: from.x - 1, y: from.y )
            if nextPos.x >= 0 {
                if map[nextPos.y][nextPos.x] == "#" {
                    return (from, .up)
                } else {
                    return (nextPos, direction)
                }
            } else {
                return nil
            }
        case .right:
            let nextPos = Step(x: from.x + 1, y: from.y)
            if nextPos.x < map[0].count {
                if map[nextPos.y][nextPos.x] == "#" {
                    return (from, .down)
                } else {
                    return (nextPos, direction)
                }
            } else {
                return nil
            }
        }
    }
    
    private func findStart(map: [[String]]) -> (postion: Step, direction: Directions) {
        for (i,line) in map.enumerated() {
            if let idx = line.firstIndex(of: "^") {
                return (Step(x: idx, y: i), Directions.up)
            } else if let idx = line.firstIndex(of: "v") {
                return (Step(x: idx, y: i), Directions.down)
            } else if let idx = line.firstIndex(of: ">") {
                return (Step(x: idx, y: i), Directions.right)
            } else if let idx = line.firstIndex(of: "<") {
                return (Step(x: idx, y: i), Directions.left)
            }
        }
        fatalError("Something went wrong")
    }
    
    private func parse(path: String) -> [[String]] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).split(separator: "\n")
            .map { Array($0).map { String($0) } }
    }
}

extension Day6A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "6_test.txt")
        } else {
            return run(path: testPath + "6.txt")
        }
    }
}

