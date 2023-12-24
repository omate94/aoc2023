//
//  main.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 04..
//

import Foundation


protocol AoCTest {
    func execute(test: Bool) -> String
}

let clock = ContinuousClock()
let time = clock.measure(main)
print("Test time: ", time)

func main() {
//    let day = Day1A()
//    let day = Day1B()
//    let day = Day2A()
//    let day = Day2B()
//    let day = Day3A()
//    let day = Day3B()
//    let day = Day4A()
//    let day = Day4B()
//    let day = Day5A()
//    let day = Day5B()
//    let day = Day6A()
//    let day = Day6B()
//    let day = Day7A()
//    let day = Day7B()
//    let day = Day8A()
//    let day = Day8B()
//    let day = Day7B()
//    let day = Day9A()
//    let day = Day9B()
//    let day = Day10A()
//    let day = Day10B()
//    let day = Day11A()
//    let day = Day11B()
//    let day = Day13A()
//    let day = Day13B()
//    let day = Day14A()
//    let day = Day14B()
//    let day = Day15A()
    let day = Day15B()
//    let day = Day16A()
//    let day = Day16B()


    let result = day.execute(test: false)
    print("Test result: ", result)
}
