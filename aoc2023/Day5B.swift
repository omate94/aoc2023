//
//  Day5A.swift
//  aoc2023
//
//  Created by Oláh Máté on 2023. 12. 04..
//

import Foundation

private struct Almanac {
    let seeds: [Range]
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
    var diff: Int {
        destination - start
    }
    
    var end: Int {
        start + offset - 1
    }
    
    func contains(_ value: Int) -> Bool {
        value >= start && value < (start + offset)
    }
}

private struct Range {
    let start: Int
    let end: Int
    
    func contains(_ range: Range) -> Bool {
        range.start >= start && range.end <= end
    }
}

class Day5B {
    private func run(path: String) -> String {
        let almanac = parse(path: path)
        
        let soilRanges = updateRanges(for: almanac.seeds, with: almanac.seedToSoilMaps)
        let fertilizerRanges = updateRanges(for: soilRanges, with: almanac.soilToFertilizerMaps)
        let waterRanges = updateRanges(for: fertilizerRanges, with: almanac.fertilizerToWaterMaps)
        let lightRanges = updateRanges(for: waterRanges, with: almanac.waterToLightMaps)
        let temperatureRanges = updateRanges(for: lightRanges, with: almanac.lightToTemperatureMaps)
        let humidityRanges = updateRanges(for: temperatureRanges, with: almanac.temperatureToHumidityMaps)
        let locationRanges = updateRanges(for: humidityRanges, with: almanac.humidityToLocationMaps)

        return String(locationRanges.sorted { $0.start <  $1.start }.first!.start)
    }
    
    private func updateRanges(for ranges: [Range], with maps: [Map]) -> [Range] {
        var mutableRanges = ranges
        
        var result: [Range] = []
        for map in maps {
            let res = checkRanges(mutableRanges, with: map)
            result.append(contentsOf: res.shifted)
            mutableRanges = res.remained
        }
        result.append(contentsOf: mutableRanges)
        
        return result
    }
    
    private func checkRanges(_ ranges: [Range], with map: Map) -> (shifted: [Range], remained: [Range]) {
        var shifted: [Range] = []
        var remained: [Range] = []
        for range in ranges {
            if map.contains(range.start) && map.contains(range.end) {
                let shiftedRange = shiftRange(range: range, diff: map.diff)
                shifted.append(shiftedRange)
            } else if map.contains(range.start) {
                let containedRange = Range(start: range.start, end: map.end)
                let remainingRange = Range(start: map.end + 1, end: range.end)
                let shiftedRange = shiftRange(range: containedRange, diff: map.diff)
                shifted.append(shiftedRange)
                remained.append(remainingRange)
            } else if map.contains(range.end) {
                let remainingRange = Range(start: range.start, end: map.start-1)
                let containedRange = Range(start: map.start, end: range.end)
                let shiftedRange = shiftRange(range: containedRange, diff: map.diff)
                shifted.append(shiftedRange)
                remained.append(remainingRange)
            } else if range.contains(Range(start: map.start, end: map.end)) {
                let leftRemainingRange = Range(start: range.start, end: map.start-1)
                let rightRemainingRange = Range(start: map.end+1, end: range.end)
                let containedRange = Range(start: map.start, end: map.end)
                let shiftedRange = shiftRange(range: containedRange, diff: map.diff)
                shifted.append(shiftedRange)
                remained.append(leftRemainingRange)
                remained.append(rightRemainingRange)
            } else {
                remained.append(range)
            }
        }
        return (shifted,remained)
    }
    
    private func shiftRange(range: Range, diff: Int) -> Range {
        let newRangeStart = range.start + diff
        let newRangeEnd = range.end + diff
        return Range(start: newRangeStart, end: newRangeEnd)
    }
    
    private func parse(path: String) -> Almanac {
        let fileURL = URL(fileURLWithPath: path)
        let input = try! String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
        
        var seeds: [Range] = []
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
                seeds = createSeed(line: $0)
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
    
    private func createSeed(line: String) -> [Range] {
        let seedRaw = line.replacingOccurrences(of: "seeds: ", with: "").components(separatedBy: " ").map { Int(String($0))! }
        var seeds: [Range] = []
        
        for i in stride(from: 0, to: seedRaw.count - 1, by: 2) {
            seeds.append(Range(start: seedRaw[i], end: seedRaw[i]+seedRaw[i+1]-1))
        }

        return seeds
    }
    
    private func createMap(line: String) -> Map {
        let values = line.components(separatedBy: " ").map { Int(String($0))! }
        let dest = values[0]
        let start = values[1]
        let length = values[2]
        return Map(destination: dest, start: start, offset: length)
    }
}

extension Day5B: AoCTest {
    func execute(test: Bool) -> String {
        if test {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/5_test.txt")
        } else {
            return run(path: "/Users/olahmate/aoc2023/tests/2023/5.txt")
        }
    }
}
