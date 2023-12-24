//
//  Day19A.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 24..
//

import Foundation

private struct Workflow {
    let id: String
    let commands: [Command]
}

private struct Command {
    let id: String?
    let isGreater: Bool?
    let value: Int?
    let result: String
    
    func test(with ratings: Rating) -> String? {
        var value: Int?
        
        if id == "x" {
            value = ratings.x
        }
        
        if id == "m" {
            value = ratings.m
        }
        
        if id == "a" {
            value = ratings.a
        }
        
        if id == "s" {
            value = ratings.s
        }
        
        guard let isGreater = isGreater, let selfValue = self.value, let _ = id else {
            return result
        }
        
        if isGreater {
            return value! < selfValue ? result : nil
        } else {
            return value! > selfValue ? result : nil
        }
    }
}

private struct Rating {
    let x: Int
    let m: Int
    let a: Int
    let s: Int
    
    func sum() -> Int {
        return x + m + a + s
    }
}

class Day19A {
    private func run(path: String) -> String {
        let (workflows, ratings)  = parse(path: path)
        var result = 0
        
        for rating in ratings {
            var currentCommand = "in"
            
            while (currentCommand != "R" && currentCommand != "A") {
                let workflow = workflows.first(where: { $0.id == currentCommand } )!
                for command in workflow.commands {
                    if let val = command.test(with: rating) {
                        currentCommand = val
                        break
                    }
                }
            }
            
            if currentCommand == "A" {
                result += rating.sum()
            }
        }
        
        return String(result)
    }
    
    private func parse(path: String) -> (workflows: [Workflow], ratings: [Rating]) {
        let fileURL = URL(fileURLWithPath: path)
        let input = try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
        
        var isWorklfows = true
        var worklfows: [Workflow] = []
        var ratings: [Rating] = []
        input.forEach {
            if $0.isEmpty {
                isWorklfows = false
            } else if isWorklfows {
                let name = getID(from: $0)
                let commnds = getCommands(from: $0)
                worklfows.append(Workflow(id: name, commands: commnds))
            } else {
                ratings.append(getRatings(string: $0))
            }
        }
        
        return (worklfows,ratings)
    }
    
    private func getRatings(string: String) -> Rating {
        var mutableString = string
        mutableString.removeFirst()
        mutableString.removeLast()
        let components = mutableString.components(separatedBy: ",")
        
        var x = 0
        var m = 0
        var a = 0
        var s = 0
        
        for component in components {
            var mutableComponent = component
            let first = mutableComponent.removeFirst()
            mutableComponent.removeFirst()
            
            if first == "x" {
                x = Int(mutableComponent)!
            }
            
            if first == "m" {
                m = Int(mutableComponent)!
            }
            
            if first == "a" {
                a = Int(mutableComponent)!
            }
            
            if first == "s" {
                s = Int(mutableComponent)!
            }
        }
        
        return Rating(x: x, m: m, a: a, s: s)
    }
    
    private func getID(from string: String) -> String {
        if let index = string.firstIndex(of: "{") {
            return String(string[..<index])
        }
        fatalError("")
    }
    
    private func getCommands(from string: String) -> [Command] {
        let index = string.firstIndex(of: "{")!
        var rawCommands = String(string[index...])
        rawCommands.removeFirst()
        rawCommands.removeLast()
        let commands = rawCommands.components(separatedBy: ",")
        
        var result: [Command] = []
        for command in commands {
            if command.contains(":") {
                let resIdx = command.firstIndex(of: ":")!
                var commandResult = String(command[resIdx...])
                commandResult.removeFirst()
                if command.contains("<") {
                    let asdIx = command.firstIndex(of: "<")!
                    var id =  String(command[...asdIx])
                    id.removeLast()
                    var value = String(command[asdIx...resIdx])
                    value.removeFirst()
                    value.removeLast()
                    result.append(Command(id: id, isGreater: true, value: Int(value)!, result: commandResult))
                } else {
                    let asdIx = command.firstIndex(of: ">")!
                    var id =  String(command[...asdIx])
                    id.removeLast()
                    var value = String(command[asdIx...resIdx])
                    value.removeFirst()
                    value.removeLast()
                    result.append(Command(id: id, isGreater: false, value: Int(value)!, result: commandResult))
                }
            } else {
                result.append(Command(id: nil, isGreater: nil, value: nil, result: command))
            }
        }
        
        return result
    }
}

extension Day19A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/19_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/19.txt")
        }
    }
}
