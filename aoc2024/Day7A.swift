import Foundation

class Day7A {
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        var result = 0
        
        for row in input {
            if checkRow(row: row.numbers, target: row.target) {
                result += row.target
            }
        }
    
        return String(result)
    }
    
    private func checkRow(row: [Int], target: Int) -> Bool {
        let initial = [row[0] + row[1], row[0] * row[1]]
        let results = calc(idx: 2, row: row, sums: initial)
        return results.contains(target)
    }
    
    private func calc(idx: Int, row: [Int], sums: [Int]) -> [Int] {
        if idx == row.count {
            return sums
        }

        var res = [Int]()
        
        for sum in sums {
            res.append(sum + row[idx])
            res.append(sum * row[idx])
        }
        
        return calc(idx: idx + 1, row: row, sums: res)
    }
    
    private func parse(path: String) -> [(target: Int, numbers: [Int])] {
        let fileURL = URL(fileURLWithPath: path)
        let tmp = try! String(contentsOf: fileURL, encoding: .utf8).split(separator: "\n")
            .map { $0.split(separator: " ").map { String($0) } }
        

        var result = [(target: Int, numbers: [Int])] ()
        
        for row in tmp {
            let testStr = row.first!.replacingOccurrences(of: ":", with: "")
            let numberStr = Array(row.dropFirst())
            let target = Int(testStr)!
            let numbers = numberStr.map { Int($0)! }
            result.append((target, numbers))
        }
        
        return result
    }
}

extension Day7A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "7_test.txt")
        } else {
            return run(path: testPath + "7.txt")
        }
    }
}

