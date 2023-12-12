//
//  Day10B.swift
//  aoc2023
//
//  Created by Mate Olah on 2023. 12. 10..
//

import Foundation

private struct Step: Equatable {
    let x: Int
    let y: Int
    
    static func == (lhs: Step, rhs: Step) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
}

class Day10B {
    private func run(path: String) -> String {
        let map = extendMap(map:parse(path: path))
        let start = findStart(map: map)
        var filteredMap = drawMap(map: map)
        
        filteredMap[start.y][start.x] = getStartChar(left: map[start.y][start.x-1],
                                                     right: map[start.y][start.x+1],
                                                     top: map[start.y-1][start.x],
                                                     bottom: map[start.y+1][start.x])
        
        let pathCoordinates = getPathCoordinates(map: filteredMap)
        
        var enclosedItems = 0
        var isInside = false
        var needJ = false
        var need7 = false
        
        for (i, line) in filteredMap.enumerated() {
            for (j,_) in line.enumerated() {
                if pathCoordinates.contains(Step(x: j, y: i)) {
                    let item = filteredMap[i][j]
                    
                    if item == "|" {
                        isInside = !isInside
                    }
                    if item == "L" {
                        need7 = true
                    }
                    if item == "F" {
                        needJ = true
                    }
                    if item == "J" {
                        if needJ {
                            isInside = !isInside
                            needJ = false
                        }
                        need7 = false
                    }
                    if item == "7" {
                        if need7 {
                            isInside = !isInside
                            need7 = false
                        }
                        needJ = false
                    }
                } else {
                    if isInside {
                        enclosedItems += 1
                    }
                }
            }
        }
                
        
        return String(enclosedItems)
    }
    
    private func getPathCoordinates(map: [[String]]) -> [Step] {
        var result: [Step] = []
        for (i, line) in map.enumerated() {
            for (j,_) in line.enumerated() {
                if map[i][j] != "." {
                    result.append(Step(x: j, y: i))
                }
            }
        }
        
        return result
    }
    
    private func getStartChar(left: String,
                              right: String,
                              top: String,
                              bottom: String) -> String {
        if left != "." && top != "." {
            return "J"
        } else if left != "." && right != "." {
            return "-"
        } else if left != "." && bottom != "." {
            return "7"
        } else if top != "." && right != "." {
            return "L"
        } else if top != "." && bottom != "." {
            return "|"
        } else if right != "." && bottom != "." {
            return "F"
        }
        
        fatalError("Something went wrong")
    }
    
    private func drawMap(map: [[String]]) -> [[String]] {
        let dots = [String](repeating: ".", count: map.first!.count)
        var newMap = [[String]](repeating: dots, count: map.count)
        
        let start = findStart(map: map)
        let res = findPathStarts(map: map, start: start)
        var forward = res.forward
        var backward = res.backward
        var previousForward = start
        var previousBackward = start
        
        newMap[forward.y][forward.x] = map[forward.y][forward.x]
        newMap[backward.y][backward.x] = map[backward.y][backward.x]
        while (forward != backward) {
            let nextForward = findNext(map: map, start: forward, previousPosition: previousForward)
            let nextBackward = findNext(map: map, start: backward, previousPosition: previousBackward)
            previousForward = forward
            previousBackward = backward
            forward = nextForward
            backward = nextBackward
            newMap[forward.y][forward.x] = map[forward.y][forward.x]
            newMap[backward.y][backward.x] = map[backward.y][backward.x]
        }
        
        
        return newMap
    }
    
    private func extendMap(map: [[String]]) -> [[String]] {
        var extendedMap = map
        
        for (i,_) in map.enumerated() {
            extendedMap[i].append(".")
            extendedMap[i].insert(".", at: 0)
        }
        
        let dots = [String](repeating: ".", count: map.first!.count+2)
        extendedMap.append(dots)
        extendedMap.insert(dots, at: 0)
        return extendedMap
    }
    
    private func findStart(map: [[String]]) -> Step {
        for (i,line) in map.enumerated() {
            if let idx = line.firstIndex(of: "S") {
                return Step(x: idx, y: i)
            }
        }
        fatalError("Something went wrong")
    }
    
    private func findNext(map: [[String]], start: Step, previousPosition: Step) -> Step {
        let leftPosition = Step(x: start.x-1, y: start.y)
        let left = map[leftPosition.y][leftPosition.x]
        
        let rightPosition = Step(x: start.x+1, y: start.y)
        let right = map[rightPosition.y][rightPosition.x]
        
        let topPosition = Step(x: start.x, y: start.y-1)
        let top = map[topPosition.y][topPosition.x]
        
        let bottomPosition = Step(x: start.x, y: start.y+1)
        let bottom = map[bottomPosition.y][bottomPosition.x]
        
        let current = map[start.y][start.x]
        
        if previousPosition != leftPosition && (left == "-" || left == "L" || left == "F") && (current != "F" && current != "|" && current != "L") {
            return Step(x: start.x-1, y: start.y)
        } else if previousPosition != bottomPosition && (bottom == "|" || bottom == "L" || bottom == "J") && (current != "-" && current != "J" && current != "L") {
            return Step(x: start.x, y: start.y+1)
        } else if previousPosition != rightPosition && (right == "-" || right == "J" || right == "7") && (current != "J" && current != "|" && current != "7") {
            return Step(x: start.x+1, y: start.y)
        } else if previousPosition != topPosition && (top == "|" || top == "F" || top == "7") && (current != "F" && current != "-" && current != "7") {
            return Step(x: start.x, y: start.y-1)
        }
        
        fatalError("Something went wrong")
    }
    
    private func findPathStarts(map: [[String]], start: Step) -> (forward: Step, backward: Step) {
        let left = map[start.y][start.x-1]
        let right = map[start.y][start.x+1]
        let top = map[start.y-1][start.x]
        let bottom = map[start.y+1][start.x]
        
        var validSteps: [Step] = []
        
        if right == "-" || right == "J" || right == "7" {
            validSteps.append(Step(x: start.x+1, y: start.y))
        }
        
        if top == "|" || top == "F" || top == "7" {
            validSteps.append(Step(x: start.x, y: start.y-1))
        }
        
        if left == "-" || left == "L" || left == "F" {
            validSteps.append(Step(x: start.x-1, y: start.y))
        }
        
        if bottom == "|" || bottom == "L" || bottom == "J" {
            validSteps.append(Step(x: start.x, y: start.y+1))
        }

        if validSteps.count != 2 {
            fatalError("Something went wtong")
        }
        return (validSteps.first!, validSteps.last!)
    }
    
    private func parse(path: String) -> [[String]] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
            .map { val in
                return Array(val).map { String($0) }
            }
    }
}

extension Day10B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
//            let test1Result = run(path: "/Users/olahmate/aoc2023/tests/10b_test_1.txt")
//            let test2Result = run(path: "/Users/olahmate/aoc2023/tests/10b_test_2.txt")
//            let test3Result = run(path: "/Users/olahmate/aoc2023/tests/10b_test_3.txt")
            let test4Result = run(path: "/Users/olahmate/aoc2023/tests/10b_test_4.txt")
//            return "Test 1: \(test1Result), Test 2: \(test2Result), Test 3: \(test1Result), Test 4: \(test2Result)"
            return ""
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/10.txt")
        }
    }
}
