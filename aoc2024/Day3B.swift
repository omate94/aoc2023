import Foundation

class Day3B {
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        
        let pattern = #"do\(\)|don't\(\)|mul\((\d{1,3}),(\d{1,3})\)"#
        let regex = try! NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: input, range: NSRange(input.startIndex..., in: input))
        
        var isEnabled = true
        var results: [[Int]] = []
        
        for match in matches {
            let range = Range(match.range, in: input)!
            let matchedString = String(input[range])
            
            if matchedString == "do()" {
                isEnabled = true
            } else if matchedString == "don't()" {
                isEnabled = false
            } else if isEnabled {
                let range = Range(match.range, in: input)!
                let command = String(input[range])
                results.append(getNumber(from: command))
            }
        }
        
        let result = results.reduce(0) { tmp, item in
            tmp + item[0] * item[1]
        }
        
        return String(result)
    }
    
    private func getNumber(from text: String) -> [Int] {
        let pattern =  #"mul\((\d+),(\d+)\)"#
        let regex = try! NSRegularExpression(pattern: pattern)
        let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text))
        let range1 = Range(match!.range(at: 1), in: text)!
        let number1 = Int(text[range1])!
        let range2 = Range(match!.range(at: 2), in: text)!
        let number2 = Int(text[range2])!
        
        return [number1, number2]
    }
    
    private func parse(path: String) -> String {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8)
    }
}

extension Day3B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "3_test.txt")
        } else {
            return run(path: testPath + "3.txt")
        }
    }
}

