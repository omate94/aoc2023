import Foundation

class Day15B {
    private var cache: [String: Int] = [:]
    private func run(path: String) -> String {
        let lenses = parse(path: path)
        var boxes: [Int:[String]] = [:]
        
        for lens in lenses {
            let label = getLabel(from: lens)
            let boxID = getBox(string: label)
            if lens.contains("=") {
                if let box = boxes[boxID] {
                    var lensesInBox = box
                    if  let firstIndex = lensesInBox.firstIndex(where: { $0.contains(label) }) {
                        lensesInBox[firstIndex] = lens
                    } else {
                        lensesInBox.append(lens)
                    }
                    boxes[boxID] = lensesInBox
                } else {
                    boxes[boxID] = [lens]
                }
            } else {
                if let box = boxes[boxID] {
                    var lensesInBox = box
                    lensesInBox.removeAll(where: { $0.contains(label) })
                    boxes[boxID] = lensesInBox
                }
            }
        }
        
        var result = 0
        
        for box in boxes.keys {
            if let lenses = boxes[box], !lenses.isEmpty {
                for (i,lens) in lenses.enumerated() {
                    let focalLength = Int(String(lens.last!))!
                    result += (box + 1) * (i + 1) * focalLength
                }
            }
        }
        
        return String(result)
    }
    
    private func getLabel(from string: String) -> String {
        if string.contains("-"), let index = string.firstIndex(of: "-") {
            return String(string[..<index])
        } else {
            let index = string.firstIndex(of: "=")!
            return String(string[..<index])
        }
    }
    
    private func getBox(string: String) -> Int {
        if let val = cache[string] {
            return val
        } else {
            let val = calculateHash(string: string)
            cache[string] = val
            return val
        }
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

extension Day15B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/15_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/15.txt")
        }
    }
}

