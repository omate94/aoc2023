import Foundation

class Day14A {
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
        
        for _ in 0..<100 {
            for i in 0..<robots.count {
                makeStep(robot: &robots[i])
            }
        }
        
        var q1Count = 0
        var q2Count = 0
        var q3Count = 0
        var q4Count = 0
        
        for robot in robots {
            if robot.position.x < 50 {
                if robot.position.y < 51 {
                    q1Count += 1
                } else if  robot.position.y > 51 {
                    q3Count += 1
                }
            } else if robot.position.x > 50 {
                if robot.position.y < 51 {
                    q2Count += 1
                } else if robot.position.y > 51 {
                    q4Count += 1
                }
            }
        }
        
        return String(q1Count * q2Count * q3Count * q4Count)
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

extension Day14A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "14_test.txt")
        } else {
            return run(path: testPath + "14.txt")
        }
    }
}

