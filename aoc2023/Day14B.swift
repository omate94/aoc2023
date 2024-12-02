import Foundation

class Day14B {
    private func run(path: String) -> String {
        let map = parse(path: path)
        var tilteddMap: [[String]] =  Array(repeating: Array(repeating: "", count: map.count), count: map.count)
        var cache: [[[String]]] = []
        var index = 0
        
        var tmpMap = map
        for _ in (1...1000000000) {
            cache.append(tmpMap)
            for _ in 1...4 {
                for (i,_) in tmpMap.enumerated() {
                    let col = tmpMap.getColumn(column: i)
                    let tiltedCol = tilt(column: col)
                    for (j,item) in tiltedCol.enumerated() {
                        tilteddMap[j][i] = item
                    }
                }
                tmpMap = rotateLeft(tilteddMap)
            }
            if cache.contains(tmpMap) {
                let idx = cache.firstIndex(of: tmpMap)!
                let loopLength = cache.count - idx
                index = idx + (1000000000 - idx) % loopLength
                break
            }
        }
        
        var result = 0
        
        var rowValue = cache[index].count
        cache[index].forEach { line in
            let count = line.filter{$0 == "O"}.count
            result += count * rowValue
            rowValue -= 1
        }

        return String(result)
    }
    
    private func tilt(column: [String]) -> [String] {
        var result: [String] = Array(repeating: ".", count: column.count)
        var nextRockIndex = 0
        for (i,col) in column.enumerated() {
            if col == "O" {
                result[nextRockIndex] = "O"
                nextRockIndex += 1
            } else if col == "#" {
                result[i] = "#"
                nextRockIndex = i + 1
            }
        }
        
        return result
    }
    
    private func parse(path: String) -> [[String]] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
            .map { Array($0).map { String($0) } }
    }
    
    private func rotateLeft(_ matrix: [[String]]) -> [[String]] {
        guard !matrix.isEmpty else {
            return matrix
        }

        let rowCount = matrix.count
        let colCount = matrix[0].count

        var result = Array(repeating: Array(repeating: "", count: rowCount), count: colCount)

        for i in 0..<rowCount {
            for j in 0..<colCount {
                result[j][rowCount - 1 - i] = matrix[i][j]
            }
        }

        return result
    }
}

extension Day14B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/14_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/14.txt")
        }
    }
}
