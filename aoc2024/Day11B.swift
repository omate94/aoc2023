import Foundation

class Day11B {
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        var stones = input
        
        for _ in 0..<75 {
            var tmp = [Int: Int]()
            for stone in stones.keys {
                let count = stones[stone] ?? 0
                
                if stone == 0 && count > 0 {
                    let ones = tmp[1] ?? 0
                    tmp[1] = count + ones
                } else if String(stone).count % 2 == 0 {
                    let str = String(stone).splitStringInHalf()
                    let firstHalf = Int(str.firstHalf)!
                    let secondHalf = Int(str.secondHalf)!
                    
                    let firstHalfCount = tmp[firstHalf] ?? 0
                    tmp[firstHalf] = firstHalfCount + count
                    
                    let secondHalfCount = tmp[secondHalf] ?? 0
                    tmp[secondHalf] = secondHalfCount + count
                    
                } else {
                    let val = stone * 2024
                    let valCount = tmp[val] ?? 0
                    tmp[val] = valCount + count
                }
            }
            stones = tmp
        }
        
        let result = stones.values.reduce(0, +)

        return String(result)
    }
    
    
    private func parse(path: String) -> [Int: Int] {
        let fileURL = URL(fileURLWithPath: path)
        return  try! String(contentsOf: fileURL, encoding: .utf8)
            .components(separatedBy: " ")
            .map { Int($0)! }
            .reduce(into: [Int: Int]()) { counts, item in
                counts[item, default: 0] += 1
            }
    }
}

extension Day11B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "11_test.txt")
        } else {
            return run(path: testPath + "11.txt")
        }
    }
}
