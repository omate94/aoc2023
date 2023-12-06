//
//  Day5A.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 04..
//

import Foundation

private struct Almanac {
    let seeds: [Int]
    let seedToSoilMaps: [Map]
    let soilToFertilizerMaps: [Map]
    let fertilizerToWaterMaps: [Map]
    let waterToLightMaps: [Map]
    let lightToTemperatureMaps: [Map]
    let temperatureToHumidityMaps: [Map]
    let humidityToLocationMaps: [Map]
}

private struct Map {
    let destination: Int
    let start: Int
    let offset: Int
}

class Day5A {
    private func run(path: String) -> String {
        let almanac = parse(path: path)
        
        var locations: [Int] = []
        
        for seed in almanac.seeds {
            let soil = findValue(for: seed, in: almanac.seedToSoilMaps)
            let fertilizer = findValue(for: soil, in: almanac.soilToFertilizerMaps)
            let water = findValue(for: fertilizer, in: almanac.fertilizerToWaterMaps)
            let light = findValue(for: water, in: almanac.waterToLightMaps)
            let temperature = findValue(for: light, in: almanac.lightToTemperatureMaps)
            let humidity = findValue(for: temperature, in: almanac.temperatureToHumidityMaps)
            let location = findValue(for: humidity, in: almanac.humidityToLocationMaps)
            locations.append(location)
        }
        
        return String(locations.sorted()[0])
    }
    
    private func findValue(for value: Int, in maps: [Map]) -> Int {
        for map in maps {
            let lowerBound = map.start
            let upperBound = map.start + map.offset - 1
            
            if value >= lowerBound && value <= upperBound {
                let diff =  value - lowerBound
                return map.destination + diff
            }
        }

        return value
    }
    
    private func parse(path: String) -> Almanac {
        let fileURL = URL(fileURLWithPath: path)
        let input = try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
        
        var seeds: [Int] = []
        var seedToSoilMaps: [Map] = []
        var soilToFertilizerMaps: [Map] = []
        var fertilizerToWaterMaps: [Map] = []
        var waterToLightMaps: [Map] = []
        var lightToTemperatureMaps: [Map] = []
        var temperatureToHumidityMaps: [Map] = []
        var humidityToLocationMaps: [Map] = []
        
        var categoryID = 0
        input.forEach {
            if $0 == "" {
                categoryID = 0
            } else if $0.contains("seeds:") {
                seeds = $0.replacingOccurrences(of: "seeds: ", with: "").components(separatedBy: " ").map { Int(String($0))! }
            } else if $0.contains("seed-to-soil map:") {
                categoryID = 1
            } else if categoryID == 1 {
                seedToSoilMaps.append(createMap(line: $0))
            } else if $0.contains("soil-to-fertilizer map:") {
                categoryID = 2
            } else if categoryID == 2 {
                soilToFertilizerMaps.append(createMap(line: $0))
            } else if $0.contains("fertilizer-to-water map:") {
                categoryID = 3
            } else if categoryID == 3 {
                fertilizerToWaterMaps.append(createMap(line: $0))
            } else if $0.contains("water-to-light map:") {
                categoryID = 4
            } else if categoryID == 4 {
                waterToLightMaps.append(createMap(line: $0))
            } else if $0.contains("light-to-temperature map:") {
                categoryID = 5
            } else if categoryID == 5 {
                lightToTemperatureMaps.append(createMap(line: $0))
            } else if $0.contains("temperature-to-humidity map:") {
                categoryID = 6
            } else if categoryID == 6 {
                temperatureToHumidityMaps.append(createMap(line: $0))
            } else if $0.contains("humidity-to-location map:") {
                categoryID = 7
            } else if categoryID == 7 {
                humidityToLocationMaps.append(createMap(line: $0))
            }
        }
        
        
        return Almanac(seeds: seeds,
                       seedToSoilMaps: seedToSoilMaps,
                       soilToFertilizerMaps: soilToFertilizerMaps,
                       fertilizerToWaterMaps: fertilizerToWaterMaps,
                       waterToLightMaps: waterToLightMaps,
                       lightToTemperatureMaps: lightToTemperatureMaps,
                       temperatureToHumidityMaps: temperatureToHumidityMaps,
                       humidityToLocationMaps: humidityToLocationMaps)
    }
    
    private func createMap(line: String) -> Map {
        let values = line.components(separatedBy: " ").map { Int(String($0))! }
        let dest = values[0]
        let start = values[1]
        let length = values[2]
        return Map(destination: dest, start: start, offset: length)
    }
}

extension Day5A: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/5_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/5a.txt")
        }
    }
}
