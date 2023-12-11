//
//  Day8A.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 08..
//

import Foundation

private typealias LeftRight = (left: String, right: String)

class Day8A {
    private func run(path: String) -> String {
        let (commands, graph) = parse(path: path)
        var commandIdx = 0
        
        let res = findNext(key: "AAA")
        
        func findNext(key: String) -> Int {
            if key == "ZZZ" {
                return commandIdx
            }
            
            let command = commands[(commandIdx % commands.count)]
            let val = graph[key]!
            let nextval = command == "L" ? val.left : val.right
            commandIdx += 1
            
            
            let newValue = findNext(key: nextval)
            return newValue
        }
        
        return String(res)
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
}

extension Day8A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/8a_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/8.txt")
        }
    }
}
