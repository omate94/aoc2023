import Foundation

class Day15A {
    private func run(path: String) -> String {
        let parts = parse(path: path)
        var cache: [String: Int] = [:]
        
        let result = parts.reduce(0, { (res, part) in
            if let val = cache[part] {
                return res + val
            } else {
                let val = calculateHash(string: part)
                cache[part] = val
                return res + val
            }
        })
        
        return String(result)
    }
    
    private func calculateHash(string: String) -> Int {
        let asciiValues: [UInt8] = string.compactMap(\.asciiValue)
        
        let result = asciiValues.reduce(0, { (res, value) in
            (res + Int(value)) * 17 % 256
        })
    
        return Int(result)
    }
    
    private func parse(path: String) -> [String] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: ",")
    }
}

extension Day15A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/15_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/15.txt")
        }
    }
}

