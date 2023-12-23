//
//  Day13B.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 23..
//

import Foundation

class Day13B {
    private func run(path: String) -> String {
        let maps = parse(path: path).map { rotateMap(map: $0)}
        var rows: [Int] = []
        var columns: [Int] = []
        
        for map in maps {
            let oldColumnVal = getIndex(map: map)
            let oldRowVal = getIndex(map: rotateMap(map: map))
        outerLoop: for (i,line) in map.enumerated() {
                let characters = Array(line).map { String($0) }
                for (j, element) in characters.enumerated() {
                    var mutableMap = map
                    var mutableCharacters = characters
                    if element == "." {
                        mutableCharacters[j] = "#"
                    } else {
                        mutableCharacters[j] = "."
                    }
                    mutableMap[i] = mutableCharacters.joined(separator:"")
                
                    if let val = getIndex(map: mutableMap, old: oldColumnVal) {
                        columns.append(val)
                        break outerLoop
                    } else {
                        let rotated = rotateMap(map: mutableMap)
                        if let val = getIndex(map: rotated, old: oldRowVal) {
                            rows.append(val)
                            break outerLoop
                        }
                    }
                }
            }
        }

        let result = rows.reduce(0, +) * 100 + columns.reduce(0, +)
        return String(result)
    }

    func rotateMap(map: [String]) -> [String] {
        var result: [String] = []
        for i in 0..<map[0].count {
            var str = ""
            for line in map {
                str.append(Array(line)[i])
            }
            result.append(str)
        }
        return result
    }
    
    func getIndex(map: [String], old: Int? = nil) -> Int? {
        var fromFront: [Int] = map.indices.filter({ map[$0] == map.first! })
        var fromBack: [Int] = map.indices.filter({ map[$0] == map.last! })
        
        if fromFront.count > 1 {
            let first = fromFront.first!
            fromFront.removeFirst()
            for idx in fromFront.reversed() {
                if validateReflection(map: map, from: first, to: idx) {
                    let half = (idx - first  + 1) / 2
                    if let old = old {
                        if first+half != old {
                            return first+half
                        }
                    } else {
                        return first + half
                    }
                }
            }
        }
        
        if fromBack.count > 1 {
            let last = fromBack.last!
            fromBack.removeLast()
            for idx in fromBack {
                if validateReflection(map: map, from: idx, to: last) {
                    let half = (last - idx  + 1) / 2
                    if let old = old {
                        if last-half + 1 != old {
                            return last-half + 1
                        }
                    } else {
                        return last-half + 1
                    }
                }
            }
        }
        
        return nil
    }
    
    func validateReflection(map: [String], from: Int, to: Int) -> Bool {
        let half = (to - from  + 1) / 2
        let firstHalf: [String] = Array(map[from..<from+half])
        let secondHalf: [String] = Array(map[from+half...to])
        return firstHalf == secondHalf.reversed()
    }

    private func parse(path: String) -> [[String]] {
        let fileURL = URL(fileURLWithPath: path)
        let input = try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")

        var result: [[String]] = []
        var tmp: [String] = []

        input.forEach {
            if $0.isEmpty {
                result.append(tmp)
                tmp = []
            } else {
                tmp.append($0)
            }
        }

        result.append(tmp)

        return result
    }
}

extension Day13B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/13_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/13.txt")
        }
    }
}
