import Foundation

class Day7B {
    func run(path: String) -> String {
        return ""
    }
}

extension Day7B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "7_test.txt")
        } else {
            return run(path: testPath + "7.txt")
        }
    }
}

