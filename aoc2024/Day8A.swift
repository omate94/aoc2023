import Foundation

private struct Step: Equatable, Hashable {
    let x: Int
    let y: Int
    
    static func == (lhs: Step, rhs: Step) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    func mirror(step: Step) -> Step {
        let yDiff = self.y-step.y
        let xDiff = self.x-step.x
        return Step(x: self.x+xDiff, y: self.y+yDiff)
    }
}

class Day8A {
    
    private func run(path: String) -> String {
        let input = parse(path: path)
        let antennasDict = input.antennas
        let width = input.width
        let height = input.height
        
        var antinodes = Set<Step>()
        
        for frequency in antennasDict.keys {
            let antennas = antennasDict[frequency]!
            
            for i in 0..<antennas.count - 1 {
                let antenna1 = antennas[i]
                for j in i+1..<antennas.count {
                    let antenna2 = antennas[j]

                    let antinode1 = antenna1.mirror(step: antenna2)
                    let antinode2 = antenna2.mirror(step: antenna1)
                    
                    if inBounds(step: antinode1, width: width, height: height){
                        antinodes.insert(antinode1)
                    }
                    
                    if inBounds(step: antinode2, width: width, height: height){
                        antinodes.insert(antinode2)
                    }
                }
            }
        }
        
        return String(antinodes.count)
    }
    
    private func inBounds(step: Step, width: Int, height: Int) -> Bool {
        return step.x >= 0 && step.x < width && step.y >= 0 && step.y < height
    }
    
    private func parse(path: String) -> (antennas: [String: [Step]], width: Int, height: Int) {
        let fileURL = URL(fileURLWithPath: path)
        let map = try! String(contentsOf: fileURL, encoding: .utf8).split(separator: "\n")
            .map { Array($0).map { String($0) } }
        

        var result = [String: [Step]]()
        
        for i in 0..<map.count {
            for j in 0..<map[i].count {
                let antenna = map[i][j]
                if antenna == "." { continue }
                if let val = result[antenna] {
                    var mutable = val
                    mutable.append(Step(x: j, y: i))
                    result[antenna] = mutable
                } else {
                    result[antenna] = [Step(x: j, y: i)]
                }
            }
        }
        
        return (result, map[0].count, map.count)
    }
}

extension Day8A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "8_test.txt")
        } else {
            return run(path: testPath + "8.txt")
        }
    }
}

