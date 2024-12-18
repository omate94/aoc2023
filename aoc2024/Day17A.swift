import Foundation

class Day17A {
    var registerA = 0
    var registerB = 0
    var registerC = 0
    private func run(path: String) -> String {
        let input = parse(path: path)
        registerA = input.a
        registerB = input.b
        registerC = input.c
        let commands = input.commands
        
        var output = [Int]()
        var i = 0
        
        while i < commands.count-1 {
            let opcode = commands[i]
            let operand = commands[i+1]
            
            switch opcode {
            case 0:
                adv(operand: operand)
                i += 2
            case 1:
                bxl(operand: operand)
                i += 2
            case 2:
                bst(operand: operand)
                i += 2
            case 3:
                if let val = jnz(operand: operand) {
                    i = val
                } else {
                    i += 2
                }
            case 4:
                bxc()
                i += 2
            case 5:
                let val = out(operand: operand)
                output.append(val)
                i += 2
            case 6:
                bdv(operand: operand)
                i += 2
            case 7:
                cdv(operand: operand)
                i += 2
            default:
                fatalError()
            }
        }
        
        return String(output.map { String($0) }.joined(separator: ","))
    }
    
    private func adv(operand: Int) {
        let comboOperand = Double(comboOperand(of: operand))
        let result = registerA / Int(pow(2.0, comboOperand))
        registerA = result
    }
    
    private func bxl(operand: Int) {
        let result = registerB ^ operand
        registerB = result
    }
    
    private func bst(operand: Int) {
        let comboOperand = comboOperand(of: operand)
        let result = comboOperand % 8
        registerB = result
    }
    
    private func jnz(operand: Int) -> Int? {
        if registerA != 0 {
            return operand
        }
        return nil
    }
    
    private func bxc() {
        let result = registerB ^ registerC
        registerB = result
    }
    
    private func out(operand: Int) -> Int {
        let comboOperand = comboOperand(of: operand)
        let result = comboOperand % 8
        return result
    }
    
    private func bdv(operand: Int) {
        let comboOperand = Double(comboOperand(of: operand))
        let result = registerA / Int(pow(2.0, comboOperand))
        registerB = result
    }
    
    private func cdv(operand: Int) {
        let comboOperand = Double(comboOperand(of: operand))
        let result = registerA / Int(pow(2.0, comboOperand))
        registerC = result
    }
    
    private func comboOperand(of operand: Int) -> Int {
        switch operand {
        case 0, 1, 2, 3:
            return operand
        case 4:
            return registerA
        case 5:
            return registerB
        case 6:
            return registerC
        default:
            fatalError()
        }
    }
    
    private func parse(path: String) -> (a: Int, b: Int, c: Int, commands: [Int]) {
        let fileURL = URL(fileURLWithPath: path)
        let rows = try! String(contentsOf: fileURL, encoding: .utf8)
            .split(separator: "\n")
            .map {
                String($0)
            }
        
        let a = Int(rows[0].split(separator: " ")[2])!
        let b = Int(rows[1].split(separator: " ")[2])!
        let c = Int(rows[2].split(separator: " ")[2])!
        let commands = rows[3].split(separator: " ").dropFirst().map{ String($0) }.first!.split(separator: ",").map { Int($0)! }

        return (a, b, c, commands)

    }
}

extension Day17A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "17_test.txt")
        } else {
            return run(path: testPath + "17.txt")
        }
    }
}

