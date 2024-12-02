import Foundation

class Day3A {
    private func run(path: String) -> String {
        let rows = parse(path: path)
        var validNumbers: [Int] = []
        var checkedIndexes: [Int:[Int]] = [:]
        
        for i in 0..<rows.count {
            for j in 0..<rows[i].count {
                if rows[i][j] == "." {
                    continue
                }
                if i == 0 && j == 0 {
                    if checkIsSymbol(char: rows[i][j+1]) ||
                        checkIsSymbol(char: rows[i+1][j]) ||
                        checkIsSymbol(char: rows[i+1][j+1]) {
                        let res = findNumberAndPos(row: rows[i], charPos: j)
                        if !(checkedIndexes[i]?.contains(j) ?? false) {
                            validNumbers.append(res.num)
                            
                            if checkedIndexes[i] == nil {
                                checkedIndexes[i] = res.indexes
                            } else {
                                var cI = checkedIndexes[i]!
                                cI.append(contentsOf: res.indexes)
                                checkedIndexes[i] = cI
                            }
                        }
                    }
                } else if i == 0 && j == rows[i].count-1 {
                    if checkIsSymbol(char: rows[i][j-1]) ||
                        checkIsSymbol(char: rows[i+1][j]) ||
                        checkIsSymbol(char: rows[i+1][j-1]) {
                        let res = findNumberAndPos(row: rows[i], charPos: j)
                        if !(checkedIndexes[i]?.contains(j) ?? false) {
                            validNumbers.append(res.num)
                            
                            if checkedIndexes[i] == nil {
                                checkedIndexes[i] = res.indexes
                            } else {
                                var cI = checkedIndexes[i]!
                                cI.append(contentsOf: res.indexes)
                                checkedIndexes[i] = cI
                            }
                        }
                    }
                } else if i == rows.count-1 && j == 0 {
                    if checkIsSymbol(char: rows[i][j+1]) ||
                        checkIsSymbol(char: rows[i-1][j]) ||
                        checkIsSymbol(char: rows[i-1][j+1]) {
                        let res = findNumberAndPos(row: rows[i], charPos: j)
                        if !(checkedIndexes[i]?.contains(j) ?? false) {
                            validNumbers.append(res.num)
                            
                            if checkedIndexes[i] == nil {
                                checkedIndexes[i] = res.indexes
                            } else {
                                var cI = checkedIndexes[i]!
                                cI.append(contentsOf: res.indexes)
                                checkedIndexes[i] = cI
                            }
                        }
                    }
                } else if i == rows.count-1 && j == rows[i].count-1 {
                    if checkIsSymbol(char: rows[i][j-1]) ||
                        checkIsSymbol(char: rows[i-1][j]) ||
                        checkIsSymbol(char: rows[i-1][j-1]) {
                        let res = findNumberAndPos(row: rows[i], charPos: j)
                        if !(checkedIndexes[i]?.contains(j) ?? false) {
                            validNumbers.append(res.num)
                            
                            if checkedIndexes[i] == nil {
                                checkedIndexes[i] = res.indexes
                            } else {
                                var cI = checkedIndexes[i]!
                                cI.append(contentsOf: res.indexes)
                                checkedIndexes[i] = cI
                            }
                        }
                    }
                } else if j == 0 {
                    if checkIsSymbol(char: rows[i-1][j]) ||
                        checkIsSymbol(char: rows[i+1][j]) ||
                        checkIsSymbol(char: rows[i][j+1]) ||
                        checkIsSymbol(char: rows[i+1][j+1]) ||
                        checkIsSymbol(char: rows[i-1][j+1]) {
                        let res = findNumberAndPos(row: rows[i], charPos: j)
                        if !(checkedIndexes[i]?.contains(j) ?? false) {
                            validNumbers.append(res.num)
                            
                            if checkedIndexes[i] == nil {
                                checkedIndexes[i] = res.indexes
                            } else {
                                var cI = checkedIndexes[i]!
                                cI.append(contentsOf: res.indexes)
                                checkedIndexes[i] = cI
                            }
                        }
                    }
                } else if j == rows[i].count-1 {
                    if checkIsSymbol(char: rows[i-1][j]) ||
                        checkIsSymbol(char: rows[i+1][j]) ||
                        checkIsSymbol(char: rows[i][j-1]) ||
                        checkIsSymbol(char: rows[i+1][j-1]) ||
                        checkIsSymbol(char: rows[i-1][j-1]) {
                        let res = findNumberAndPos(row: rows[i], charPos: j)
                        if !(checkedIndexes[i]?.contains(j) ?? false) {
                            validNumbers.append(res.num)
                            
                            if checkedIndexes[i] == nil {
                                checkedIndexes[i] = res.indexes
                            } else {
                                var cI = checkedIndexes[i]!
                                cI.append(contentsOf: res.indexes)
                                checkedIndexes[i] = cI
                            }
                        }
                    }
                } else if i == 0 {
                    if checkIsSymbol(char: rows[i][j-1]) ||
                        checkIsSymbol(char: rows[i][j+1]) ||
                        checkIsSymbol(char: rows[i+1][j]) ||
                        checkIsSymbol(char: rows[i+1][j+1]) ||
                        checkIsSymbol(char: rows[i+1][j-1]) {
                        let res = findNumberAndPos(row: rows[i], charPos: j)
                        if !(checkedIndexes[i]?.contains(j) ?? false) {
                            validNumbers.append(res.num)
                            
                            if checkedIndexes[i] == nil {
                                checkedIndexes[i] = res.indexes
                            } else {
                                var cI = checkedIndexes[i]!
                                cI.append(contentsOf: res.indexes)
                                checkedIndexes[i] = cI
                            }
                        }
                    }
                } else if i == rows.count-1 {
                    if checkIsSymbol(char: rows[i][j-1]) ||
                        checkIsSymbol(char: rows[i][j+1]) ||
                        checkIsSymbol(char: rows[i-1][j]) ||
                        checkIsSymbol(char: rows[i-1][j+1]) ||
                        checkIsSymbol(char: rows[i-1][j-1]) {
                        let res = findNumberAndPos(row: rows[i], charPos: j)
                        if !(checkedIndexes[i]?.contains(j) ?? false) {
                            validNumbers.append(res.num)
                            
                            if checkedIndexes[i] == nil {
                                checkedIndexes[i] = res.indexes
                            } else {
                                var cI = checkedIndexes[i]!
                                cI.append(contentsOf: res.indexes)
                                checkedIndexes[i] = cI
                            }
                        }
                        
                    }
                } else {
                    if checkIsSymbol(char: rows[i][j-1]) ||
                        checkIsSymbol(char: rows[i][j+1]) ||
                        checkIsSymbol(char: rows[i-1][j-1]) ||
                        checkIsSymbol(char: rows[i-1][j]) ||
                        checkIsSymbol(char: rows[i-1][j+1]) ||
                        checkIsSymbol(char: rows[i+1][j-1]) ||
                        checkIsSymbol(char: rows[i+1][j]) ||
                        checkIsSymbol(char: rows[i+1][j+1]) {
                        let res = findNumberAndPos(row: rows[i], charPos: j)
                        if !(checkedIndexes[i]?.contains(j) ?? false) {
                            validNumbers.append(res.num)
                            
                            if checkedIndexes[i] == nil {
                                checkedIndexes[i] = res.indexes
                            } else {
                                var cI = checkedIndexes[i]!
                                cI.append(contentsOf: res.indexes)
                                checkedIndexes[i] = cI
                            }
                        }
                        
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
    
    private func checkIsSymbol(char: String.Element) -> Bool {
        return char != "0" && char != "1" && char != "2" && char != "3" && char != "4" && char != "5" &&
        char != "6" && char != "7" && char != "8" && char != "9" && char != "."
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

extension Day3A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "3_test.txt")
        } else {
            return run(path: testPath + "3.txt")
        }
    }
}
