import Foundation

class Day2A {
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        var count = 0
        
        for row in input {
            if isSafe(row: row).isSafe {
                count += 1
            }
        }

        return String(count)
    }
    
    private func isSafe(row: [Int]) -> (isSafe: Bool, index: Int?) {
        let diff = row[0] - row[1]
        if diff == 0 {
            return (false, 0)
        }
        
        let isDescending = diff > 0
        
        for i in 0..<row.count - 1 {
            let leftItem = row[i]
            let rightItem = row[i+1]
            
            if abs(leftItem - rightItem) > 3 {
                return (false, i)
            }
            
            if isDescending {
                if leftItem <= rightItem {
                    return (false, i)
                }
            } else {
                if leftItem >= rightItem {
                    return (false, i)
                }
            }
        }
        return (true, nil)
    }
    
    private func parse(path: String) -> [[Int]] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).split(separator: "\n")
            .map {
                $0.components(separatedBy: " ").map { Int($0)! }
            }
    }
}

extension Day2A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "2_test.txt")
        } else {
            return run(path: testPath + "2.txt")
        }
    }
}
