import Foundation

class Day5B {
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        let rulesDict = input.rules
        let updates = input.updates
        
        var count = 0

        for i in 0..<updates.count {
            let update = updates[i]
            outerLoop: for j in 0..<update.count {
                if let rules = rulesDict[updates[i][j]] {
                    for rule in rules {
                        if let idx = update.firstIndex(of: rule) {
                            if j > idx {
                                let fixedUpdate = fix(update: update, rulesDict: rulesDict)
                                let middle = (fixedUpdate.count - 1) / 2
                                count += fixedUpdate[middle]
                                break outerLoop
                            }
                        }
                    }
                }
            }
        }
        
        return String(count)
    }
    
    private func fix(update: [Int], rulesDict: [Int: Set<Int>]) -> [Int] {
        var mutableUpdate = update
        var isFixed = false
        
        while !isFixed {
            let (_isFixed, i, j) = check(update: mutableUpdate, rulesDict: rulesDict)
            isFixed = _isFixed
            if !isFixed {
                mutableUpdate.swapAt(i!, j!)
            }
        }
        
        return mutableUpdate
    }
    
    private func check(update: [Int], rulesDict: [Int: Set<Int>]) -> (isFixed: Bool, i: Int?, j: Int?) {
        for i in 0..<update.count {
            if let rules = rulesDict[update[i]] {
                for rule in rules {
                    if let idx = update.firstIndex(of: rule) {
                        if i > idx {
                            return (false, i, idx)
                        }
                    }
                }
            }
        }
        
        return (true, nil, nil)
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

extension Day5B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "5_test.txt")
        } else {
            return run(path: testPath + "5.txt")
        }
    }
}

