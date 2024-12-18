import Foundation

private struct ClawMachine {
    let aX: Int
    let aY: Int
    let bX: Int
    let bY: Int
    let prizeX: Int
    let prizeY: Int
}

class Day13A {
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        
        var count = 0
        for i in input {
            if let minToken = calculatMinToken(clawMachine: i) {
                count += minToken
            }
        }
        
        return String(count)
    }
    
    private func calculatMinToken(clawMachine: ClawMachine) -> Int? {
        var minToken: Int? = nil
        
        for a in 0...(clawMachine.prizeX / clawMachine.aX) {
            for b in 0...(clawMachine.prizeX / clawMachine.bX) {
                if clawMachine.aX * a + clawMachine.bX * b == clawMachine.prizeX &&
                   clawMachine.aY * a + clawMachine.bY * b == clawMachine.prizeY {
                     let token = 3 * a + 1 * b
                     if let currentMin = minToken {
                         minToken = min(currentMin, token)
                     } else {
                         minToken = token
                     }
                 }
             }
         }
        
        return minToken
    }
    
    private func parse(path: String) -> [ClawMachine] {
        let fileURL = URL(fileURLWithPath: path)
        let rows = try! String(contentsOf: fileURL, encoding: .utf8)
            .split(separator: "\n\n")
        
        var clawMachines: [ClawMachine] = []
        
        for row in rows {
            let machine = row.split(separator: "\n")
                .map { $0.split(separator: " ").map { String($0) } }
            
            let aX = Int(machine[0][2].replacingOccurrences(of: ",", with: "").split(separator: "+").last!)!
            let aY = Int(machine[0][3].replacingOccurrences(of: ",", with: "").split(separator: "+").last!)!
            let bX = Int(machine[1][2].replacingOccurrences(of: ",", with: "").split(separator: "+").last!)!
            let bY = Int(machine[1][3].replacingOccurrences(of: ",", with: "").split(separator: "+").last!)!
            let prizeX = Int(machine[2][1].replacingOccurrences(of: ",", with: "").split(separator: "=").last!)!
            let prizeY = Int(machine[2][2].replacingOccurrences(of: ",", with: "").split(separator: "=").last!)!
                
            clawMachines.append(ClawMachine(aX: aX, aY: aY, bX: bX, bY: bY, prizeX: prizeX, prizeY: prizeY))
                
        }
        
        return clawMachines
    }
}

extension Day13A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "13_test.txt")
        } else {
            return run(path: testPath + "13.txt")
        }
    }
}

