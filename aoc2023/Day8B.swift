//
//  Day8B.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 08..
//

import Foundation

private typealias LeftRight = (left: String, right: String)

class Day8B {
    private func run(path: String) -> String {
        let (commands, graph) = parse(path: path)
        let initalKeys = graph.keys.filter { $0.hasSuffix("A") }
        
        let result = initalKeys.map {
            calculateSteps(_key: $0, graph: graph, commands: commands)
        }.reduce(1, {(res, num) in
            return lcm(res, num)
        })

        return String(result)
    }
    
    private func calculateSteps(_key: String, graph:  [String: LeftRight], commands: [String]) -> Int {
        var commandIdx = 0
        var key = _key
        var inProgress = true
        while(inProgress) {
            let command = commands[(commandIdx % commands.count)]
            let val = graph[key]!
            let nextval = command == "L" ? val.left : val.right
            if nextval.hasSuffix("Z") {
                inProgress = false
            }
            key = nextval
            commandIdx += 1
        }
        return commandIdx
    }
    
    private func parse(path: String) -> (commands: [String], graph: [String: LeftRight]) {
        let fileURL = URL(fileURLWithPath: path)
        var input = try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n").filter { $0 != "" }
        
        let commands = String(input[0]).map { String($0) }
        input.removeFirst()
        var graph: [String: LeftRight] = [:]
        for line in input {
            let tmp = line.components(separatedBy: "=").map { $0.trimmingCharacters(in: [" ", "(", ")"])}
            let start = tmp[0]
            let leftRight = tmp[1].components(separatedBy: ", ")
            graph[start] = LeftRight(leftRight[0], leftRight[1])
        }
        
        return (commands, graph)

    }
    
    private func gcd(_ x: Int, _ y: Int) -> Int {
        var a = 0
        var b = max(x, y)
        var r = min(x, y)
        
        while r != 0 {
            a = b
            b = r
            r = a % b
        }
        return b
    }

    private func lcm(_ x: Int, _ y: Int) -> Int {
        return x / gcd(x, y) * y
    }
}

extension Day8B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/8b_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/8.txt")
        }
    }
}
