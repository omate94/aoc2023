//
//  Day10A.swift
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

class Day10A {
    private func run(path: String) -> String {
        let map = extendMap(map:parse(path: path))
        let start = findStart(map: map)
        let res = findPathStarts(map: map, start: start)
        var forward = res.forward
        var backward = res.backward
        var result = 1
        var previousForward = start
        var previousBackward = start
        
        while (forward != backward) {
            result += 1
            let nextForward = findNext(map: map, start: forward, previousPosition: previousForward)
            let nextBackward = findNext(map: map, start: backward, previousPosition: previousBackward)
            previousForward = forward
            previousBackward = backward
            forward = nextForward
            backward = nextBackward
        }
        
        return String(result)
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
        
        var forward: Step?
        var backward: Step?
        
        if right == "-" || right == "J" || right == "7" {
            forward = Step(x: start.x+1, y: start.y)
        } else if top == "|" || top == "F" || top == "7" {
            forward = Step(x: start.x, y: start.y-1)
        } else {
            fatalError("Something went wrong")
        }
        
        if left == "-" || left == "L" || left == "F" {
            backward = Step(x: start.x-1, y: start.y)
        } else if bottom == "|" || bottom == "L" || bottom == "J" {
            backward = Step(x: start.x, y: start.y+1)
        } else {
            fatalError("Something went wrong")
        }
        
        return (forward!, backward!)
    }
    
    private func parse(path: String) -> [[String]] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
            .map { val in
                return Array(val).map { String($0) }
            }
    }
}

extension Day10A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            let test1Result = run(path: "/Users/olahmate/aoc2023/tests/10a_test_1.txt")
            let test2Result = run(path: "/Users/olahmate/aoc2023/tests/10a_test_2.txt")
            return "Test 1: \(test1Result), Test 2: \(test2Result)"
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/10.txt")
        }
    }
}
