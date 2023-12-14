//
//  Day13A.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 13..
//

import Foundation

class Day13A {
    private func run(path: String) -> String {
        let maps = parse(path: path).map { invertMap(map: $0)}
        var rows: [Int] = []
        var columns: [Int] = []
        var horizontals: [[String]] = []
        var error: [[String]] = []

        maps.forEach {
            if let val = getIndex(map: $0) {
                columns.append(val)
            } else {
                horizontals.append($0)
            }
        }

        horizontals = horizontals.map { invertMap(map: $0)}
        
        horizontals.forEach {
            if let val = getIndex(map: $0) {
                rows.append(val)
            } else {
                error.append($0)
            }
        }


        let result = rows.reduce(0, +) * 100 + columns.reduce(0, +)
        return String(result)
    }

    func invertMap(map: [String]) -> [String] {
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
    
    func getIndex(map: [String]) -> Int? {
        var fromFront: [Int] = map.indices.filter({ map[$0] == map.first! })
        var fromBack: [Int] = map.indices.filter({ map[$0] == map.last! })
        
        if fromFront.count > 1 {
            let first = fromFront.first!
            fromFront.removeFirst()
            for idx in fromFront.reversed() {
                if validateReflection(map: map, from: first, to: idx) {
                    let half = (idx - first  + 1) / 2
                    return first + half
                }
            }
        }
        
        if fromBack.count > 1 {
            let last = fromBack.last!
            fromBack.removeLast()
            for idx in fromBack {
                if validateReflection(map: map, from: idx, to: last) {
                    let half = (last - idx  + 1) / 2
                    return last-half + 1
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

extension Day13A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/13_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/13.txt")
        }
    }
}
