import Foundation

class Day9A {
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        var files = input.files
        let spaces = input.spaces
        
        var result = [Int]()
        var startId = 0
        var endID = files.count - 1
        
        result.append(contentsOf: Array(repeating: startId, count: files.first!))
        files.removeFirst()
        startId += 1
        
        for space in spaces {
            
            for _ in 0..<space {
                if let file = files.last {
                    result.append(endID)
                    files.removeLast()
                    if file > 1 {
                        files.append(file-1)
                    } else {
                        endID -= 1
                    }
                }
            }
            if let last = files.first {
                result.append(contentsOf: Array(repeating: startId, count: last))
                files.removeFirst()
                startId += 1
            }

        }
        
        var checksum = 0
        
        for i in 0..<result.count {
            checksum += result[i]*i
        }
        
        return String(checksum)
    }
    
    
    private func parse(path: String) -> (files: [Int], spaces: [Int]) {
        let fileURL = URL(fileURLWithPath: path)
        let items = try! String(contentsOf: fileURL, encoding: .utf8).map { String($0) }.map { Int($0)! }
        
        var files = [Int]()
        var spaces = [Int]()
        
        for i in 0..<items.count {
            if i % 2 == 0 {
                files.append(items[i])
            } else {
                spaces.append(items[i])
            }
        }
        
        return (files, spaces)
    }
}

extension Day9A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "9_test.txt")
        } else {
            return run(path: testPath + "9.txt")
        }
    }
}

