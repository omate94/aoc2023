import Foundation

class Day4A {
    
    private func run(path: String) -> String {
        let input = parse(path: path)

        var count = 0
        count += checkRows(in: input)
        count += checkColumns(in: input)
        count += checkDiagonals(in: input)

        return String(count)
    }
    
    private func countXMAS(str: String) -> Int {
        return str.numberOfOccurrencesOf(string: "XMAS") + str.numberOfOccurrencesOf(string: "SAMX")
    }
    
    private func checkRows(in matrix: [[String]]) -> Int {
        var count = 0
        for row in matrix {
            count += countXMAS(str: row.joined())
        }
        
        return count
    }
    
    private func checkColumns(in matrix: [[String]]) -> Int {
        var count = 0
        for i in 0..<matrix[0].count {
            count += countXMAS(str: matrix.getColumn(column: i).joined())
        }
        
        return count
    }
    
    private func checkDiagonals(in matrix: [[String]]) -> Int {
        var count = 0
        for i in 0..<matrix[0].count {
            let diagonals = matrix.getDiagonals(for: (0,i))
            count += countXMAS(str: diagonals.0.map { $0 as! String }.joined())
            count += countXMAS(str: diagonals.1.map { $0 as! String }.joined())
        }
        
        for i in 1..<matrix[0].count-1 {
            let diagonals = matrix.getDiagonals(for: (matrix[0].count-1,i))
            count += countXMAS(str: diagonals.0.map { $0 as! String }.joined())
            count += countXMAS(str: diagonals.1.map { $0 as! String }.joined())
        }
        
        return count
    }
    
    private func parse(path: String) -> [[String]] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).split(separator: "\n")
            .map { val in
                return Array(val).map { String($0) }
            }
    }
}

extension Day4A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "4_test.txt")
        } else {
            return run(path: testPath + "4.txt")
        }
    }
}
