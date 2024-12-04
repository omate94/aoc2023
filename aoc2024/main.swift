import Foundation

let testPath = "/Users/olahmate/AdventOfCode/tests/2024/"

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
    let day = Day4B()
    
    let result = day.execute(test: false)
    print("Test result: ", result)
}
