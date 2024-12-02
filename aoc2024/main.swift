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
//    let result = day.execute(test: false)
//    print("Test result: ", result)
}
