import Foundation

class Day1B {
    private func run(path: String) -> String {
        let input = parse(path: path)
        let first = input.firstColumn.sorted()
        let second = input.secondColumn.sorted()
        
        var cache: [Int: Int] = [:]
        var result = 0
        for i in 0..<first.count {
            let itemInFirst = first[i]
            if let cachedCount = cache[itemInFirst] {
                result += cachedCount
                continue
            }
            
            var count = 0
            for itemInSecond in second {
                if itemInFirst == itemInSecond {
                    count += 1
                }
            }
            
            let value = itemInFirst * count
            cache[itemInFirst] = value
            result += value
            count = 0
        }
        
        return String(result)
    }
    
    private func parse(path: String) -> (firstColumn: [Int], secondColumn: [Int]) {
        let fileURL = URL(fileURLWithPath: path)
        let input = try! String(contentsOf: fileURL, encoding: .utf8).split(separator: "\n")
            .map {
                $0.components(separatedBy: "   ").compactMap { Int($0) }
            }

        return (input.compactMap { $0.first }, input.compactMap { $0.last })
    }
}

extension Day1B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "1_test.txt")
        } else {
            return run(path: testPath + "1.txt")
        }
    }
}
