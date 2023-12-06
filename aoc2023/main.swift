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
    let day = Day6B()

    let result = day.execute(test: false)
    print("Test result: ", result)
}
