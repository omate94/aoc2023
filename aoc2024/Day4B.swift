import Foundation
import aoc2023

class Day4B {
    
    private func run(path: String) -> String {
        let input = parse(path: path)

        var count = 0
        
        for i in 0..<input.count {
            for j in 0..<input[i].count {
                if i > 0 && i < input.count - 1 && j > 0 && j < input[i].count - 1 {
                    if input[i][j] == "A" {
                        if checkX(matrix: input, i: i, j: j) {
                            count += 1
                        }
                    }
                }
            }
        }

        return String(count)
    }
    
    private func checkX(matrix: [[String]], i: Int, j: Int) -> Bool {
        let topLeft = matrix[i-1][j-1]
        let topRight = matrix[i-1][j+1]
        let bottomLeft = matrix[i+1][j-1]
        let bottomRight = matrix[i+1][j+1]
        
        if (topLeft == "M" && bottomRight == "S" || topLeft == "S" && bottomRight == "M") &&
           (topRight == "M" && bottomLeft == "S" || topRight == "S" && bottomLeft == "M") {
            return true
        }
        
        return false
    }
    
    private func parse(path: String) -> [[String]] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).split(separator: "\n")
            .map { val in
                return Array(val).map { String($0) }
            }
    }
}

extension Day4B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "4_test.txt")
        } else {
            return run(path: testPath + "4.txt")
        }
    }
}
