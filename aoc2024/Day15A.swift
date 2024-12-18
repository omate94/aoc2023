import Foundation

class Day15A {
    private struct Position: Hashable {
        let x: Int
        let y: Int
    }
    
    private enum Direction: Hashable {
        case up, right, down, left
    }
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        var map = input.0
        let directions = input.1
        
        var currentPostion: Position!
        for i in 0..<map.count {
            for j in 0..<map[i].count {
                if map[i][j] == "@" {
                    currentPostion = Position(x: j, y: i)
                }
            }
        }
        
        for direction in directions {
            if direction == .up || direction == .down {
                let newState = move(position: currentPostion, direction: direction, line: map.getColumn(column: currentPostion.x))
                map.replaceColumn(at: currentPostion.x, with: newState.0)
                map[currentPostion.y][currentPostion.x] = "."
                map[newState.1.y][newState.1.x] = "@"
                currentPostion = newState.1
            } else {
                let newState = move(position: currentPostion, direction: direction, line: map[currentPostion.y])
                map[currentPostion.y] = newState.0
                map[currentPostion.y][currentPostion.x] = "."
                map[newState.1.y][newState.1.x] = "@"
                currentPostion = newState.1
            }

        }
        
        var count = 0
        for i in 0..<map.count {
            for j in 0..<map[i].count {
                if map[i][j] == "O" {
                    count += 100 * i + j
                }
            }
        }
        
        return String(count)
    }
    
    private func move(position: Position, direction: Direction, line: [String]) -> ([String], Position) {
        switch direction {
        case .up:
            let part = line[0..<position.y]
            let moved = pushBox(row: Array(part.reversed()))
            if moved.1 {
                return (moved.0.reversed() + line[position.y..<line.count], Position(x: position.x, y: position.y-1))
            } else {
                return (line, Position(x: position.x, y: position.y))
            }
        case .left:
            let part = line[0..<position.x]
            let moved = pushBox(row: Array(part).reversed())
            if moved.1 {
                return (moved.0.reversed() + line[position.x..<line.count], Position(x: position.x-1, y: position.y))
            } else {
                return (line, Position(x: position.x, y: position.y))
            }
        case .down:
            let part = line[position.y+1..<line.count]
            let moved = pushBox(row: Array(part))
            if moved.1 {
                return (line[0..<position.y+1] + moved.0, Position(x: position.x, y: position.y+1))
            } else {
                return (line, Position(x: position.x, y: position.y))
            }
        case .right:
            let part = line[position.x+1..<line.count]
            let moved = pushBox(row: Array(part))
            if moved.1 {
                return (line[0..<position.x+1] + moved.0, Position(x: position.x+1, y: position.y))
            } else {
                return (line, Position(x: position.x, y: position.y))
            }
        }
    }
    
    private func pushBox(row: [String]) -> ([String], Bool) {
        if row[0] == "." {
            return (row, true)
        }
        
        if row[0] == "#" {
            return (row, false)
        }
        
        var index = 0
        
        while row[index] == "O" {
            index += 1
        }
        
        if row[index] == "."  {
            var newRow = ["."]
            for _ in 1...index {
                newRow.append("O")
            }
            newRow = newRow + row[index+1..<row.count]
            return (newRow, true)
        } else {
            return (row, false)
        }
    }
    
    private func parse(path: String) -> ([[String]], [Direction]) {
        let fileURL = URL(fileURLWithPath: path)
        let input = try! String(contentsOf: fileURL, encoding: .utf8)
            .split(separator: "\n\n")
        
        let map = input[0]
            .split(separator: "\n")
            .map {
                $0.split(separator: "")
                  .map { String($0) }
            }
        
        var directions = [Direction]()
        
        input[1]
            .split(separator: "")
            .forEach { item in
                switch item {
                case "^":
                    directions.append(.up)
                case ">":
                    directions.append(.right)
                case "v":
                    directions.append(.down)
                case "<":
                    directions.append(.left)
                default:
                    fatalError()
                }
            }
        
        return (map, directions)
    }
}

extension Day15A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "15_test.txt")
        } else {
            return run(path: testPath + "15.txt")
        }
    }
}

