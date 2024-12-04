import Foundation

class Day1A {
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        let firstSorted = input.firstColumn.sorted()
        let secondSorted = input.secondColumn.sorted()
        
        var count = 0

        for i in 0..<firstSorted.count {
            count += abs(firstSorted[i]-secondSorted[i])
        }

        return String(count)
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

extension Day1A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "1_test.txt")
        } else {
            return run(path: testPath + "1.txt")
        }
    }
}
