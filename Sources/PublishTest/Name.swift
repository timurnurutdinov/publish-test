//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 2/3/21.
//

import Foundation
import Files
import Publish
import Plot


enum ProjectType: String {
    case ios = "iOS"
    case android = "Android"
    case desktop = "Desktop"
    case touch = "Touch"
    case unknown = "?"
}


// 2020-10-29 [touch] United Feed – Resize.framer
class Name {
    var date: Date = Date()
    var type: ProjectType = .unknown
    var title: String = ""
    var scene: String = ""
    
    var originDate: String = ""
    var originType: String = ""
    var originTitle: String = ""
    
    
    static func printPlatform(_ names: [Name]) {
        let types = names.map { $0.type.rawValue }
        var counts: [String: Int] = [:]
        for item in types { counts[item] = (counts[item] ?? 0) + 1 }
        
        let sortedCounts = counts.sorted { $0.1 > $1.1 }
        for (key, value) in sortedCounts {
            print("\(String(format: "%03d", value)): \(key)")
        }
    }
    
    static func printTimeline(_ names: [Name]) {
        let types = names.map { $0.compactDate() }
        print(types)
    }
    
    static func printTitles(_ names: [Name]) {
        let types = names.map { $0.title }
        var counts: [String: Int] = [:]
        for item in types { counts[item] = (counts[item] ?? 0) + 1 }
        let sortedCounts = counts.sorted { $0.1 > $1.1 }
        for (key, value) in sortedCounts {
            print("\(String(format: "%03d", value)): \(key)")
        }
        
    }
    
    
    
    
    
    
    static func getType(_ line: String) -> ProjectType {
        switch line {
            case "ios", "ibro": return .ios
            case "pp", "abro", "android": return .android
            case "dbro", "d", "chrome", "desktop": return .desktop
            case "touch", "t": return .touch
            default: return .unknown
        }
    }
    
    static func getDate(_ line: String) -> Date {
        let dateFormat = "yyyy-MM-dd"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        if let convertedDate = dateFormatter.date(from: line) {
            return convertedDate
        }
        return Date()
    }

    
    
    
    
    init(_ line: String) {
        let pattern = #"([^\s]+) \[([^]]+)\] ([^–^-]+) [–-] ([^.]+)"#
//        let pattern = #"([^\s]+) \[([^]]+)\] (.*).framer"#
//        let pattern = "/([^\\s]+)/"

        let groups = line.matchingStrings(regex: pattern)
        let flattened = groups.flatMap { $0 }
        
        if flattened.count > 4 {
            self.originDate = flattened[1]
            self.originType = flattened[2]
            self.originTitle = flattened[3]
            
            self.date = Name.getDate(self.originDate)
            self.type = Name.getType(self.originType)
            
            self.title = flattened[3]
            self.scene = flattened[4]
        }
        else {
            print("🛑 Failed to parse name: \(line)")
        }
    }
    
    func isValid() -> Bool {
        return self.title != ""
    }
    
    func compactDate() -> String {
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "d MMM y"
        return formatter4.string(from: self.date)
    }
}

//func getLowestDateString() -> String {
//    let formatter4 = DateFormatter()
//    formatter4.dateFormat = "yyyy-MM-dd"
//    let dates = self.getLowestDates()
//    return "\(self.getID()): \(formatter4.string(from: dates[0]))"
//}




extension String {
    func matchingStrings(regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
        let nsString = self as NSString
        let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).map {
                result.range(at: $0).location != NSNotFound
                    ? nsString.substring(with: result.range(at: $0))
                    : ""
            }
        }
    }
}
