//
//  Day1B.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 04..
//

import Foundation

class Day1B {
    private func run(path: String) -> String {
        let nums = parse(path: path)
        var result: [Int] = []
        
        nums.forEach {
            let firstDigit = $0.first!!
            let lastDigit = $0.last!!
            let number =  Int(String(firstDigit) + String(lastDigit))!
            result.append(number)
        }
    
        return String(result.reduce(0,+))
    }
    
    private func parse(path: String) -> [[Int?]] {
        let fileURL = URL(fileURLWithPath: path)
        return try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
            .compactMap { Array($0) }
            .map { convertNum(str: String($0)) }
            .map {
                $0.map { Int(String($0)) }
                    .filter { $0 != nil }
            }
    }
    
    private func convertNum(str: String) -> String {
        var res = str
        if str.contains("one") {
            res = res.replacingOccurrences(of: "one", with: "1")
            res = res.replacingOccurrences(of: "on", with: "1")
        }
        
        if str.contains("two") {
            res = res.replacingOccurrences(of: "two", with: "2")
            res = res.replacingOccurrences(of: "wo", with: "2")
            res = res.replacingOccurrences(of: "ow", with: "2")
            res = res.replacingOccurrences(of: "w", with: "2")
        }
        
        if str.contains("three") {
            res = res.replacingOccurrences(of: "three", with: "3")
            res = res.replacingOccurrences(of: "hree", with: "3")
            res = res.replacingOccurrences(of: "thre", with: "3")
            res = res.replacingOccurrences(of: "hre", with: "3")
        }
        
        if str.contains("four") {
            res = res.replacingOccurrences(of: "four", with: "4")
        }
        
        if str.contains("five") {
            res = res.replacingOccurrences(of: "five", with: "5")
            res = res.replacingOccurrences(of: "fiv", with: "5")
        }
        
        if str.contains("six") {
            res = res.replacingOccurrences(of: "six", with: "6")
        }
        
        if str.contains("seven") {
            res = res.replacingOccurrences(of: "seven", with: "7")
            res = res.replacingOccurrences(of: "seve", with: "7")
        }
        
        if str.contains("eight") {
            res = res.replacingOccurrences(of: "eight", with: "8")
            res = res.replacingOccurrences(of: "eigh", with: "8")
            res = res.replacingOccurrences(of: "ight", with: "8")
            res = res.replacingOccurrences(of: "igh", with: "8")
        }
        
        if str.contains("nine") {
            res = res.replacingOccurrences(of: "nine", with: "9")
            res = res.replacingOccurrences(of: "ine", with: "9")
            res = res.replacingOccurrences(of: "nin", with: "9")
            res = res.replacingOccurrences(of: "in", with: "9")
        }
        
        return res
    }
}

extension Day1B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/1b_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/1b.txt")
        }
    }
}
