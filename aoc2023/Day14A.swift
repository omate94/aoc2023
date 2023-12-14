//
//  Day14A.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 14..
//

import Foundation

class Day14A {
    private func run(path: String) -> String {
        let maps = parse(path: path)
        var titledMap: [[String]] =  Array(repeating: Array(repeating: "", count: maps.count), count: maps.count)
       
        for (i,_) in maps.enumerated() {
            let col = maps.getColumn(column: i)
            let tiltedCol = tilt(column: col)
            for (j,item) in tiltedCol.enumerated() {
                titledMap[j][i] = item
            }
        }
        
        var result = 0
        var rowValue = titledMap.count
        titledMap.forEach { line in
            let count = line.filter{$0 == "O"}.count
            result += count * rowValue
            rowValue -= 1
        }
        
        return String(result)
    }
    
    private func tilt(column: [String]) -> [String] {
        var result: [String] = Array(repeating: ".", count: column.count)
        var nextRockIndex = 0
        for (i,col) in column.enumerated() {
            if col == "O" {
                result[nextRockIndex] = "O"
                nextRockIndex += 1
            } else if col == "#" {
                result[i] = "#"
                nextRockIndex = i + 1
            }
        }
        
        return result
    }
    
    private func parse(path: String) -> [[String]] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
            .map { Array($0).map { String($0) } }
    }
}

extension Day14A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/14_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/14.txt")
        }
    }
}
