import Foundation

private struct Position: Hashable {
    let x: Int
    let y: Int
}

private struct Garden: Hashable {
    var tiles: Set<Position>
}

class Day12B {
    private func run(path: String) -> String {
        let input = parse(path: path)
        var gardenDict = [String: [Garden]]()
        
        for i in 0..<input.count {
            for j in 0..<input[i].count {
                let pos = Position(x: j, y: i)
                let type = input[i][j]
                
                let neighbours = Array(checkNeighbours(map: input, position: pos))
//                let isEdge = neighbours.count < 4
                
                if let neigbourGardens = getNeighbourGardens(gardenDict: gardenDict, type: type, neighbours: neighbours) {
                    var gardens = gardenDict[type] ?? []
                    var tiles: Set<Position> = []
//                    
//                    if isEdge {
                        tiles.insert(pos)
//                    } 
                    
                    neigbourGardens.forEach { garden in
                        gardens.removeAll {$0 == garden}
                        tiles.formUnion(garden.tiles)
                    }
                    
                    gardens.append(Garden(tiles: tiles))
                    gardenDict[type] = gardens
                } else {
                    var gardens = gardenDict[type] ?? []
                    gardens.append(Garden(tiles: [pos]))
                    gardenDict[type] = gardens
                }
            }
        }
        
        let count = gardenDict.values.flatMap { $0 }.reduce(0) { $0 + calculateSides(garden: $1) * $1.tiles.count }
        
        return String(count)
    }
    
    private func calculateSides(garden: Garden) -> Int {
        if garden.tiles.count < 3 {
            return 4
        }
        
        var minX = Int.max
        var minY = Int.max
        var maxX = 0
        var maxY = 0
        
        for tile in garden.tiles {
            if tile.x < minX {
                minX = tile.x
            }
            
            if tile.y < minY {
                minY = tile.y
            }
            
            if tile.x > maxX {
                maxX = tile.x
            }
            
            if tile.y > maxY {
                maxY = tile.y
            }
        }
        
        if maxX == minX || maxY == minY {
            return 4
        }
        
        let map = createMap(size: (h: maxY-minY+1, w: maxX-minX+1), offsetX: minX, offsetY: minY, positons: garden.tiles)
        
        return findCorners(map: map)
    }
    
    private func findCorners(map: [[String]]) -> Int {
        let directions = [[(0,-1), (-1,-1), (-1,0)],
                          [(0,-1), (1,-1), (1,0)],
                          [(0,1), (-1,1), (-1,0)],
                          [(0,1), (1,1), (1,0)]]
        var corners = 0
        
        for i in 0..<map.count {
            for j in 0..<map[i].count {
                if map[i][j] == "#" {
                    for direction in directions {
                        let n1 = map[i+direction[0].0][j+direction[0].1]
                        let n2 = map[i+direction[1].0][j+direction[1].1]
                        let n3 = map[i+direction[2].0][j+direction[2].1]
                        
                        if (n1 == "." && n3 == ".") || (n1 == "#" && n2 == "." && n3 == "#") {
                            corners += 1
                        }
                    }
                }
            }
        }
        
        return corners
    }
    
    private func createMap(size: (h: Int, w: Int), offsetX: Int, offsetY: Int, positons: Set<Position>) -> [[String]] {
        var map = Array(repeating: Array(repeating: ".", count: size.w+2), count: size.h+2)
        
        for positon in positons {
            map[positon.y-offsetY+1][positon.x-offsetX+1] = "#"
        }
        
        return map
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

extension Day12B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "12_test.txt")
        } else {
            return run(path: testPath + "12.txt")
        }
    }
}

