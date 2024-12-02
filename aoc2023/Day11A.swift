//
//  Day11A.swift
//  aoc2023
//
//  Created by Mate Olah on 2023. 12. 10..
//

import Foundation

private struct Galaxy {
    var x: Int
    var y: Int
    
    func distanceFrom(galaxy: Galaxy) -> Int {
        return abs(galaxy.x-self.x)+abs(galaxy.y-self.y)
    }
}


class Day11A {
    private func run(path: String) -> String {
        let universe = parse(path: path)
        var galaxies: [Galaxy] = []
                
        for (i, un) in universe.enumerated() {
            for (j,galaxy) in un.enumerated() {
                if galaxy == "#" {
                    galaxies.append(Galaxy(x: j, y: i))
                }
            }
        }
        
        let exntendedGalaxies = extendUniverse(universe: universe, galaxies: galaxies)
        
        var result = 0
        
        for (i,galaxy) in exntendedGalaxies.enumerated() {
            for j in i+1..<exntendedGalaxies.count {
                result += galaxy.distanceFrom(galaxy: exntendedGalaxies[j])
            }
        }
        
        return String(result)
    }
    
    private func extendUniverse(universe: [[String]], galaxies: [Galaxy]) -> [Galaxy] {
        var mutableGalaxies = galaxies
        var emptyRowIndexes: [Int] = []
        for (i,line) in universe.enumerated() {
            if !line.contains("#") {
                emptyRowIndexes.append(i)
            }
        }
        
        var emptyColumnIndexes: [Int] = []
        for i in 0..<universe.first!.count {
            let column = universe.getColumn(column: i)
            if !column.contains("#") {
                emptyColumnIndexes.append(i)
            }
        }
        
        for emptyRowIndex in emptyRowIndexes {
            for i in 0..<galaxies.count {
                if galaxies[i].y > emptyRowIndex {
                    mutableGalaxies[i].y += 1
                }
            }
        }
        
        for emptyColumnIndex in emptyColumnIndexes {
            for i in 0..<galaxies.count {
                if galaxies[i].x > emptyColumnIndex {
                    mutableGalaxies[i].x += 1
                }
            }
        }
        
        return mutableGalaxies
    }
    
    private func parse(path: String) -> [[String]] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
            .map { val in
                return Array(val).map { String($0) }
            }
    }
}

extension Day11A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/11_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/11.txt")
        }
    }
}
