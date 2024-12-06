import Foundation
import aoc2023

class Day5A {
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        let rulesDict = input.rules
        let updates = input.updates
        
        var count = 0

        for i in 0..<updates.count {
            var isInTheRightOrder = true
            let update = updates[i]
            outerLoop: for j in 0..<update.count {
                if let rules = rulesDict[update[j]] {
                    for rule in rules {
                        if let idx = update.firstIndex(of: rule) {
                            if j > idx {
                                isInTheRightOrder = false
                                break outerLoop
                            }
                        }
                    }
                }
            }
            if isInTheRightOrder {
                let middle = (update.count-1) / 2
                count += update[middle]
            }
            isInTheRightOrder = true
        }
        
        return String(count)
    }
    
    private func parse(path: String) -> (rules: [Int: Set<Int>], updates: [[Int]]) {
        let fileURL = URL(fileURLWithPath: path)
        let lines = try! String(contentsOf: fileURL, encoding: .utf8).split(separator: "\n")
        
        var rules = [Int: Set<Int>]()
        var updates = [[Int]]()
        
        for line in lines {
            if line.contains("|") {
                let numbers = line.split(separator: "|").map { Int($0)! }
                if var rule = rules[numbers[0]] {
                    rule.insert(numbers[1])
                    rules[numbers[0]] = rule
                } else {
                    rules[numbers[0]] = [numbers[1]]
                }
            } else if !line.isEmpty {
                let numbers = line.split(separator: ",").map { Int($0)! }
                updates.append(numbers)
            }
        }
        
        return (rules, updates)
    }
}

extension Day5A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "5_test.txt")
        } else {
            return run(path: testPath + "5.txt")
        }
    }
}

