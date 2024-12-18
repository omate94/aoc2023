import Foundation

class Day14B {
    struct Point {
        var x: Int
        var y: Int
    }
    
    struct Robot {
        var position: Point
        var velocity: Point
    }

    private func run(path: String) -> String {
        var robots = parse(path: path)
        
        var found = false
        var j = 0
        while !found {
            for i in 0..<robots.count {
                makeStep(robot: &robots[i])
            }

            found = printMap(robots: robots)
            j += 1
        }
        
        
        return String(j)
    }
    
    private func makeStep(robot: inout Robot) {
        var newPos = Point(x: robot.position.x + robot.velocity.x,
                           y: robot.position.y + robot.velocity.y)
        
        if newPos.x < 0 {
            newPos.x = 101 + newPos.x
        } else if newPos.x > 100 {
            newPos.x =  newPos.x - 101
        }
        
        if newPos.y < 0 {
            newPos.y = 103 + newPos.y
        } else if newPos.y > 102 {
            newPos.y = newPos.y - 103
        }
        
        robot.position = newPos
    }
    
    private func printMap(robots: [Robot]) -> Bool {
        var map = Array(repeating: Array(repeating: ".", count: 101), count: 103)
        
        for robot in robots {
            map[robot.position.y][robot.position.x] = "#"
        }
        
        var c = 0
        for row in map {
            for item in row {
                if item == "#" {
                    c += 1
                } else {
                    c = 0
                }
                
                if c == 10 {
                    map.forEach {
                        print($0.joined())
                    }
                    return true
                }
            }
        }
        
        return false
    }
    
    private func parse(path: String) -> [Robot] {
        let fileURL = URL(fileURLWithPath: path)
        let rows = try! String(contentsOf: fileURL, encoding: .utf8)
            .split(separator: "\n")
            .map { $0.split(separator: " ").map { String($0) }}
        
        var robots = [Robot]()
        
        for row in rows {
            let positoin = row[0]
                .replacingOccurrences(of: "p=", with: "")
                .split(separator: ",")
                .map { Int($0)! }
            let velocity = row[1]
                .replacingOccurrences(of: "v=", with: "")
                .split(separator: ",")
                .map { Int($0)! }
            
            robots.append(Robot(position: Point(x: positoin.first!,
                                                y: positoin.last!),
                                velocity: Point(x: velocity.first!,
                                                y: velocity.last!)))
        }
        
        return robots
    }
}

extension Day14B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "14_test.txt")
        } else {
            return run(path: testPath + "14.txt")
        }
    }
}

