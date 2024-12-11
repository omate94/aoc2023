import Foundation

class Day11A {
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        var stones = input
        for _ in 0..<6 {
            var tmp = [Int]()
            
            for stone in stones {
                if stone == 0 {
                    tmp.append(1)
                } else if String(stone).count % 2 == 0 {
                    let str = String(stone).splitStringInHalf()
                    let firstHalf = Int(str.firstHalf)!
                    let secondHalf = Int(str.secondHalf)!
                    
                    tmp.append(firstHalf)
                    tmp.append(secondHalf)
                    
                } else {
                    tmp.append(stone * 2024)
                }
            }
            stones = tmp
        }        
        
        return String(stones.count)
    }
    
    
    private func parse(path: String) -> [Int] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: " ")
            .map { Int($0)! }
    }
}

extension Day11A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "11_test.txt")
        } else {
            return run(path: testPath + "11.txt")
        }
    }
}

extension String {
   func splitStringInHalf()->(firstHalf:String,secondHalf:String) {
       let halfLength = self.count / 2
       let index = self.index(self.startIndex, offsetBy: halfLength)

       let firstHalf = self[..<index]
       let secondHalf = self[index...]
       return (firstHalf: String(firstHalf), secondHalf: String(secondHalf))
    }
}
