//
//  Day3B.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 04..
//

import Foundation

class Day3B {
    private func run(path: String) -> String {
        let rows = parse(path: path)
        var validNumbers: [Int] = []
        
        for i in 0..<rows.count {
            for j in 0..<rows[i].count {
                if rows[i][j] != "*" {
                    continue
                }
                
                if i == 0 && j == 0 {
                    let first = isNum(char: rows[i][j+1])
                    let second = isNum(char: rows[i+1][j])
                    let third = isNum(char: rows[i+1][j+1])
                    if first && second {
                        let f = findNumberAndPos(row: rows[i], charPos: j+1)
                        let s = findNumberAndPos(row: rows[i+1], charPos: j)
                        validNumbers.append(f.num*s.num)
                    } else if first && third {
                        let num1 = findNumberAndPos(row: rows[i], charPos: j+1)
                        let num2 = findNumberAndPos(row: rows[i+1], charPos: j+1)
                        validNumbers.append(num1.num*num2.num)
                    }
                } else if i == 0 && j == rows[i].count-1 {
                    let first = isNum(char: rows[i][j-1])
                    let second = isNum(char: rows[i+1][j])
                    let third = isNum(char: rows[i+1][j-1])
                    if first && second {
                        let f = findNumberAndPos(row: rows[i], charPos: j-1)
                        let s = findNumberAndPos(row: rows[i+1], charPos: j)
                        validNumbers.append(f.num*s.num)
                    } else if first && third {
                        let num1 = findNumberAndPos(row: rows[i], charPos: j-1)
                        let num2 = findNumberAndPos(row: rows[i+1], charPos: j-1)
                        validNumbers.append(num1.num*num2.num)
                    }
                } else if i == rows.count-1 && j == 0 {
                    let first = isNum(char: rows[i][j+1])
                    let second = isNum(char: rows[i-1][j])
                    let third = isNum(char: rows[i-1][j+1])
                    if first && second {
                        let f = findNumberAndPos(row: rows[i], charPos: j+1)
                        let s = findNumberAndPos(row: rows[i-1], charPos: j)
                        validNumbers.append(f.num*s.num)
                    } else if first && third {
                        let num1 = findNumberAndPos(row: rows[i-1], charPos: j)
                        let num2 = findNumberAndPos(row: rows[i-1], charPos: j+1)
                        validNumbers.append(num1.num*num2.num)
                    }
                } else if i == rows.count-1 && j == rows[i].count-1 {
                    let first = isNum(char: rows[i][j-1])
                    let second = isNum(char: rows[i-1][j])
                    let third = isNum(char: rows[i-1][j-1])
                    if first && second {
                        let f = findNumberAndPos(row: rows[i], charPos: j-1)
                        let s = findNumberAndPos(row: rows[i-1], charPos: j)
                        validNumbers.append(f.num*s.num)
                    } else if first && third {
                        let num1 = findNumberAndPos(row: rows[i], charPos: j-1)
                        let num2 = findNumberAndPos(row: rows[i-1], charPos: j-1)
                        validNumbers.append(num1.num*num2.num)
                    }
                } else if j == 0 {
                    let first = isNum(char: rows[i-1][j])
                    let second = isNum(char: rows[i-1][j+1])
                    let third = isNum(char: rows[i][j+1])
                    let fourth = isNum(char: rows[i+1][j])
                    let fifth = isNum(char: rows[i+1][j+1])
                    
                    let firstRow = first || second
                    let secondRow = third
                    let thirdRow = fourth || fifth
                    
                    if firstRow && secondRow {
                        let num1 = findNumberAndPos(row: rows[i], charPos: j+1).num
                        if first && second {
                            let num2 = findNumberAndPos(row: rows[i-1], charPos: j).num
                            validNumbers.append(num1*num2)
                        } else if first {
                            let num2 = findNumberAndPos(row: rows[i-1], charPos: j).num
                            validNumbers.append(num1*num2)
                        } else {
                            let num2 = findNumberAndPos(row: rows[i-1], charPos: j+1).num
                            validNumbers.append(num1*num2)
                        }
                    }
                    
                    if firstRow && thirdRow {
                        var num1: Int?
                        var num2: Int?
                        
                        if first && second {
                            num1 = findNumberAndPos(row: rows[i-1], charPos: j).num
                        } else if first {
                            num1 = findNumberAndPos(row: rows[i-1], charPos: j).num
                        } else {
                            num1 = findNumberAndPos(row: rows[i-1], charPos: j+1).num
                        }
                        
                        if fourth && fifth {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j).num
                        } else if first {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j).num
                        } else {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j+1).num
                        }
                        
                        if let num1 = num1, let num2 = num2 {
                            validNumbers.append(num1*num2)
                        }
                    }
                    
                    if thirdRow && secondRow {
                        let num1 = findNumberAndPos(row: rows[i], charPos: j+1).num
                        if fourth && fifth {
                            let num2 = findNumberAndPos(row: rows[i+1], charPos: j).num
                            validNumbers.append(num1*num2)
                        } else if first {
                            let num2 = findNumberAndPos(row: rows[i+1], charPos: j).num
                            validNumbers.append(num1*num2)
                        } else {
                            let num2 = findNumberAndPos(row: rows[i+1], charPos: j+1).num
                            validNumbers.append(num1*num2)
                        }
                    }
                    
                } else if j == rows[i].count-1 {
                    let first = isNum(char: rows[i-1][j-1])
                    let second = isNum(char: rows[i-1][j])
                    let third = isNum(char: rows[i][j-1])
                    let fourth = isNum(char: rows[i+1][j-1])
                    let fifth = isNum(char: rows[i+1][j])
                    
                    let firstRow = first || second
                    let secondRow = third
                    let thirdRow = fourth || fifth
                    
                    if firstRow && secondRow {
                        let num1 = findNumberAndPos(row: rows[i], charPos: j-1).num
                        if first && second {
                            let num2 = findNumberAndPos(row: rows[i-1], charPos: j-1).num
                            validNumbers.append(num1*num2)
                        } else if first {
                            let num2 = findNumberAndPos(row: rows[i-1], charPos: j-1).num
                            validNumbers.append(num1*num2)
                        } else {
                            let num2 = findNumberAndPos(row: rows[i-1], charPos: j).num
                            validNumbers.append(num1*num2)
                        }
                    }
                    
                    if firstRow && thirdRow {
                        var num1: Int?
                        var num2: Int?
                        
                        if first && second {
                            num1 = findNumberAndPos(row: rows[i-1], charPos: j-1).num
                        } else if first {
                            num1 = findNumberAndPos(row: rows[i-1], charPos: j-1).num
                        } else {
                            num1 = findNumberAndPos(row: rows[i-1], charPos: j).num
                        }
                        
                        if fourth && fifth {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j-1).num
                        } else if first {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j-1).num
                        } else {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j).num
                        }
                        
                        if let num1 = num1, let num2 = num2 {
                            validNumbers.append(num1*num2)
                        }
                    }
                    
                    if thirdRow && secondRow {
                        let num1 = findNumberAndPos(row: rows[i], charPos: j-1).num
                        if fourth && fifth {
                            let num2 = findNumberAndPos(row: rows[i+1], charPos: j-1).num
                            validNumbers.append(num1*num2)
                        } else if first {
                            let num2 = findNumberAndPos(row: rows[i+1], charPos: j-1).num
                            validNumbers.append(num1*num2)
                        } else {
                            let num2 = findNumberAndPos(row: rows[i+1], charPos: j).num
                            validNumbers.append(num1*num2)
                        }
                    }
                    
                } else if i == 0 {
                    let first = isNum(char: rows[i][j-1])
                    let second = isNum(char: rows[i][j+1])
                    let third = isNum(char: rows[i+1][j-1])
                    let fourth = isNum(char: rows[i+1][j])
                    let fifth = isNum(char: rows[i+1][j+1])
                    
                    if first && second {
                        let num1 = findNumberAndPos(row: rows[i], charPos: j-1).num
                        let num2 = findNumberAndPos(row: rows[i], charPos: j+1).num
                        validNumbers.append(num1*num2)
                    }
                    
                    if first {
                        let num1 = findNumberAndPos(row: rows[i], charPos: j-1).num
                        var num2 = 0
                        
                        if third && fourth && fifth {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j-1).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if third && fourth && !fifth {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j-1).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if third && !fourth && !fifth {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j-1).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if !third && fourth && fifth {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if !third && fourth && !fifth {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if !third && !fourth && fifth {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j+1).num
                            validNumbers.append(num1*num2)
                        }
                    } else if second {
                        let num1 = findNumberAndPos(row: rows[i], charPos: j+1).num
                        var num2 = 0
                        if third && fourth && fifth {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j-1).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if third && fourth && !fifth {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j-1).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if third && !fourth && !fifth {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j-1).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if !third && fourth && fifth {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if !third && fourth && !fifth {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if !third && !fourth && fifth {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j+1).num
                            validNumbers.append(num1*num2)
                        }
                    } else {
                        if third && fifth && !fourth {
                            let num1 = findNumberAndPos(row: rows[i+1], charPos: j-1).num
                            let num2 = findNumberAndPos(row: rows[i+1], charPos: j+1).num
                            validNumbers.append(num1*num2)
                        }
                    }
                    
                } else if i == rows.count-1 {
                    let first = isNum(char: rows[i-1][j-1])
                    let second = isNum(char: rows[i-1][j])
                    let third = isNum(char: rows[i-1][j+1])
                    let fourth = isNum(char: rows[i][j-1])
                    let fifth = isNum(char: rows[i][j+1])
                    
                    if fourth && fifth {
                        let num1 = findNumberAndPos(row: rows[i], charPos: j-1).num
                        let num2 = findNumberAndPos(row: rows[i], charPos: j+1).num
                        validNumbers.append(num1*num2)
                    }
                    
                    if fourth {
                        let num1 = findNumberAndPos(row: rows[i], charPos: j-1).num
                        var num2 = 0
                        
                        if first && second && third {
                            num2 = findNumberAndPos(row: rows[i-1], charPos: j-1).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if first && second && !third {
                            num2 = findNumberAndPos(row: rows[i-1], charPos: j-1).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if first && !second && !third {
                            num2 = findNumberAndPos(row: rows[i-1], charPos: j-1).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if !first && second && third {
                            num2 = findNumberAndPos(row: rows[i-1], charPos: j).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if !first && second && !third {
                            num2 = findNumberAndPos(row: rows[i-1], charPos: j).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if !first && !second && third {
                            num2 = findNumberAndPos(row: rows[i-1], charPos: j+1).num
                            validNumbers.append(num1*num2)
                        }
                    } else if second {
                        let num1 = findNumberAndPos(row: rows[i], charPos: j+1).num
                        var num2 = 0
                        if first && second && third {
                            num2 = findNumberAndPos(row: rows[i-1], charPos: j-1).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if first && second && !third {
                            num2 = findNumberAndPos(row: rows[i-1], charPos: j-1).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if first && !second && !third {
                            num2 = findNumberAndPos(row: rows[i-1], charPos: j-1).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if !first && second && third {
                            num2 = findNumberAndPos(row: rows[i-1], charPos: j).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if !first && second && !third {
                            num2 = findNumberAndPos(row: rows[i-1], charPos: j).num
                            validNumbers.append(num1*num2)
                        }
                        
                        if !first && !second && third {
                            num2 = findNumberAndPos(row: rows[i-1], charPos: j+1).num
                            validNumbers.append(num1*num2)
                        }
                    } else {
                        if first && third && !second {
                            let num1 = findNumberAndPos(row: rows[i-1], charPos: j-1).num
                            let num2 = findNumberAndPos(row: rows[i-1], charPos: j+1).num
                            validNumbers.append(num1*num2)
                        }
                    }
                } else {
                    let first = isNum(char: rows[i-1][j-1])
                    let second = isNum(char: rows[i-1][j])
                    let third = isNum(char: rows[i-1][j+1])
                    let fourth = isNum(char: rows[i][j-1])
                    let fifth = isNum(char: rows[i][j+1])
                    let sixth = isNum(char: rows[i+1][j-1])
                    let seventh = isNum(char: rows[i+1][j])
                    let eight = isNum(char: rows[i+1][j+1])
                    
                    var num1 = 0
                    var num2 = 0
                    if first && !second && third {
                        num1 = findNumberAndPos(row: rows[i-1], charPos: j-1).num
                        num2 = findNumberAndPos(row: rows[i-1], charPos: j+1).num
                        validNumbers.append(num1*num2)
                    }
                    
                    if fourth && fifth {
                        num1 = findNumberAndPos(row: rows[i], charPos: j-1).num
                        num2 = findNumberAndPos(row: rows[i], charPos: j+1).num
                        validNumbers.append(num1*num2)
                    }
                    
                    if sixth && !seventh && eight {
                        num1 = findNumberAndPos(row: rows[i+1], charPos: j-1).num
                        num2 = findNumberAndPos(row: rows[i+1], charPos: j+1).num
                        validNumbers.append(num1*num2)
                    }
                    
                    let firstRow = first || second || third
                    let secondRow = fourth || fifth
                    let thirdRow = sixth || seventh || eight
                    
                    if firstRow && secondRow {
                        if first {
                            num1 = findNumberAndPos(row: rows[i-1], charPos: j-1).num
                        } else if second {
                            num1 = findNumberAndPos(row: rows[i-1], charPos: j).num
                        } else if third {
                            num1 = findNumberAndPos(row: rows[i-1], charPos: j+1).num
                        }
                        
                        if fourth {
                            num2 = findNumberAndPos(row: rows[i], charPos: j-1).num
                        } else if fifth {
                            num2 = findNumberAndPos(row: rows[i], charPos: j+1).num
                        }
                        validNumbers.append(num1*num2)
                    } else if firstRow && thirdRow {
                        if first {
                            num1 = findNumberAndPos(row: rows[i-1], charPos: j-1).num
                        } else if second {
                            num1 = findNumberAndPos(row: rows[i-1], charPos: j).num
                        } else if third {
                            num1 = findNumberAndPos(row: rows[i-1], charPos: j+1).num
                        }
                        
                        if sixth {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j-1).num
                        } else if seventh {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j).num
                        } else if eight {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j+1).num
                        }
                        
                        validNumbers.append(num1*num2)
                    } else if secondRow && thirdRow {
                        if fourth {
                            num1 = findNumberAndPos(row: rows[i], charPos: j-1).num
                        } else if fifth {
                            num1 = findNumberAndPos(row: rows[i], charPos: j+1).num
                        }
                        
                        if sixth {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j-1).num
                        } else if seventh {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j).num
                        } else if eight {
                            num2 = findNumberAndPos(row: rows[i+1], charPos: j+1).num
                        }
                        
                        validNumbers.append(num1*num2)
                    }
                }
            }
        }

        return String(validNumbers.reduce(0, +))
    }
    
    private func parse(path: String) -> [[String.Element]] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
            .map( {Array($0)})
    }
    
    private func findNumberAndPos(row: [String.Element], charPos: Int) -> (num: Int, indexes: [Int]) {
        var numStr: String = ""
        var indexes: [Int] = []
    
        for (i,r) in row.enumerated() {
            if isNum(char: r) {
                numStr.append(r)
                indexes.append(i)
            } else if indexes.contains(charPos) {
                return (Int(numStr)!, indexes)
            } else {
                numStr = ""
                indexes = []
            }
        }
    
        return (Int(numStr)!, indexes)
    }
    
    private func isNum(char: String.Element) -> Bool {
        return char == "0" || char == "1" || char == "2" || char == "3" || char == "4" || char == "5" ||
        char == "6" || char == "7" || char == "8" || char == "9"
    }
}

extension Day3B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/3_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/3.txt")
        }
    }
}
