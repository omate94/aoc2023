import Foundation

private struct Position: Hashable {
    let x: Int
    let y: Int
}

private struct Garden: Hashable {
    var tiles: Set<Position>
    var edges: Int
}

class Day12A {
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        var gardenDict = [String: [Garden]]()
        
        for i in 0..<input.count {
            for j in 0..<input.count {
                let pos = Position(x: j, y: i)
                let type = input[i][j]
                
                let neighbours = Array(checkNeighbours(map: input, position: pos))
                let newEdges = countEdges(neighboursCount: neighbours.count)
                
                if let neighbourGardens = getNeighbourGardens(gardenDict: gardenDict, type: type, neighbours: neighbours) {
                    var gardens = gardenDict[type] ?? []
                    var edges = 0
                    var tiles: Set<Position> = [pos]
                    
                    neighbourGardens.forEach { garden in
                        gardens.removeAll {$0 == garden}
                        edges += garden.edges
                        tiles.formUnion(garden.tiles)
                    }

                    gardens.append(Garden(tiles: tiles, edges: newEdges+edges))
                    gardenDict[type] = gardens
                } else {
                    var gardens = gardenDict[type] ?? []
                    gardens.append(Garden(tiles: [pos], edges: newEdges))
                    gardenDict[type] = gardens
                }
            }
        }
        
        let count = gardenDict.values.flatMap { $0 }.reduce(0) { $0 + $1.edges * $1.tiles.count }
        return String(count)
    }
    
    private func getNeighbourGardens(gardenDict: [String: [Garden]], type: String, neighbours: [Position]) -> Set<Garden>? {
        if let gardens = gardenDict[type] {
            var neigbourGardens = Set<Garden>()
            for garden in gardens {
                for neighbour in neighbours {
                    if garden.tiles.contains(neighbour) {
                        neigbourGardens.insert(garden)
                    }
                }
            }
            return neigbourGardens
        }
        
        return nil
    }
    
    func countEdges(neighboursCount: Int) -> Int {
        switch neighboursCount {
        case 0:
            return 4
        case 1:
            return 3
        case 2:
            return 2
        case 3:
            return 1
        case 4:
            return 0
        default:
            fatalError()
        }
    }
    
    private func checkNeighbours(map: [[String]], position: Position) -> Set<Position> {
        var validNeighbours: Set<Position> = []
        let val = map[position.y][position.x]
        if position.x == 0 && position.y == 0 {
            if map[position.y+1][position.x] == val {
                validNeighbours.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x+1] == val {
                validNeighbours.insert(Position(x: position.x+1, y: position.y))
            }
        } else if position.x == 0 && position.y == map.count - 1 {
            if map[position.y-1][position.x] == val {
                validNeighbours.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y][position.x+1] == val {
                validNeighbours.insert(Position(x: position.x+1, y: position.y))
            }
        } else if position.x == map.first!.count - 1 && position.y == 0 {
            if map[position.y+1][position.x] == val {
                validNeighbours.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x-1] == val {
                validNeighbours.insert(Position(x: position.x-1, y: position.y))
            }
            return validNeighbours
        } else if position.x == map.first!.count - 1 && position.y == map.count - 1 {
            if map[position.y-1][position.x] == val {
                validNeighbours.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y][position.x-1] == val {
                validNeighbours.insert(Position(x: position.x-1, y: position.y))
            }
        } else if position.x == 0 {
            if map[position.y-1][position.x] == val {
                validNeighbours.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y+1][position.x] == val {
                validNeighbours.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x+1] == val {
                validNeighbours.insert(Position(x: position.x+1, y: position.y))
            }
        } else if position.y == 0 {
            if map[position.y+1][position.x]  == val {
                validNeighbours.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x-1]  == val {
                validNeighbours.insert(Position(x: position.x-1, y: position.y))
            }
            
            if map[position.y][position.x+1] == val {
                validNeighbours.insert(Position(x: position.x+1, y: position.y))
            }
        } else if position.x == map.first!.count - 1 {
            if map[position.y-1][position.x] == val {
                validNeighbours.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y+1][position.x] == val {
                validNeighbours.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x-1] == val {
                validNeighbours.insert(Position(x: position.x-1, y: position.y))
            }
        } else if position.y == map.count - 1 {
            if map[position.y-1][position.x]  == val {
                validNeighbours.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y][position.x-1] == val {
                validNeighbours.insert(Position(x: position.x-1, y: position.y))
            }
            
            if map[position.y][position.x+1] == val {
                validNeighbours.insert(Position(x: position.x+1, y: position.y))
            }
        } else {
            if map[position.y-1][position.x] == val {
                validNeighbours.insert(Position(x: position.x, y: position.y-1))
            }
            
            if map[position.y+1][position.x] == val {
                validNeighbours.insert(Position(x: position.x, y: position.y+1))
            }
            
            if map[position.y][position.x+1] == val {
                validNeighbours.insert(Position(x: position.x+1, y: position.y))
            }
            
            if map[position.y][position.x-1] == val {
                validNeighbours.insert(Position(x: position.x-1, y: position.y))
            }
        }
        
        return validNeighbours
    }
    
    
    private func parse(path: String) -> [[String]] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8)
            .split(separator: "\n")
            .map { Array($0).map { String($0) } }
    }
}

extension Day12A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "12_test.txt")
        } else {
            return run(path: testPath + "12.txt")
        }
    }
}

