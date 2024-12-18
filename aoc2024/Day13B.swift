import Foundation

private struct ClawMachine {
    let aX: Int
    let aY: Int
    let bX: Int
    let bY: Int
    let prizeX: Int
    let prizeY: Int
}

class Day13B {
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        
        var count: Int = 0
        for machine in input {
            count += calculatMinToken(machine: machine)
        }
        
        return String(count)
    }
    
    private func calculatMinToken(machine: ClawMachine) -> Int {
        if (machine.aY * machine.prizeX - machine.aX * machine.prizeY) % (machine.aY * machine.bX - machine.aX * machine.bY) == 0 {
            let b = (machine.aY * machine.prizeX - machine.aX * machine.prizeY) / (machine.aY * machine.bX - machine.aX * machine.bY)
            if (machine.prizeX - machine.bX * b) % machine.aX == 0 {
                let a = (machine.prizeX - machine.bX * b) / machine.aX
                return 3 * a + b
            }
        }

        return 0
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
            let prizeX = Int(machine[2][1].replacingOccurrences(of: ",", with: "").split(separator: "=").last!)! + 10000000000000
            let prizeY = Int(machine[2][2].replacingOccurrences(of: ",", with: "").split(separator: "=").last!)! + 10000000000000
                
            clawMachines.append(ClawMachine(aX: aX, aY: aY, bX: bX, bY: bY, prizeX: prizeX, prizeY: prizeY))
                
        }
        
        return clawMachines
    }
}

extension Day13B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "13_test.txt")
        } else {
            return run(path: testPath + "13.txt")
        }
    }
}

