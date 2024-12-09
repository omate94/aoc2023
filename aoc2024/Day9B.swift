import Foundation

class Day9B {
    
    struct File {
        let name: Int?
        let size: Int
    }
    
    private func run(path: String) -> String {
        var disk = parse(path: path)
        
        var idx = disk.count - 1
        
        while idx != 0 {
            let file = disk[idx]
            
            for i in 0..<disk.count {
                if disk[i].name == nil && disk[i].size >= file.size && i <= idx {
                    let space = disk.remove(at: i)
                    disk.insert(file, at: i)
                    disk.remove(at: idx)
                    disk.insert(File(name: nil, size: file.size), at: idx)
                    if space.size > file.size {
                        let newSpace = File(name: nil, size: space.size-file.size)
                        disk.insert(newSpace, at: i+1)
                    }
                    break
                }
            }
            
            idx -= 1
            while disk[idx].name == nil {
                idx -= 1
            }
        }
                
        
        var checksum = 0
        idx = 0
        for file in disk {
            if file.name != nil {
                for _ in 0..<file.size {
                    checksum += idx*file.name!
                    idx += 1
                }
            } else {
                idx += file.size
            }
        }
        
        return String(checksum)
    }
    
    
    private func parse(path: String) -> [File] {
        let fileURL = URL(fileURLWithPath: path)
        let items = try! String(contentsOf: fileURL, encoding: .utf8).map { String($0) }.map { Int($0)! }
        
        var files = [File]()
        
        var name = 0
        for i in 0..<items.count {
            let item = items[i]
            if i % 2 == 0 {
                if item != 0 {
                    files.append(File(name: name, size: items[i]))
                }
                name += 1
            } else {
                files.append(File(name: nil, size: items[i]))
            }
        }
        
        return files
    }
}

extension Day9B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: testPath + "9_test.txt")
        } else {
            return run(path: testPath + "9.txt")
        }
    }
}

