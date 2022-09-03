//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 2/4/21.
//

import Foundation

extension Name {
    
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
        let types = names.map { $0.project }
        var counts: [String: Int] = [:]
        for item in types { counts[item] = (counts[item] ?? 0) + 1 }
        let sortedCounts = counts.sorted { $0.1 > $1.1 }
        for (key, value) in sortedCounts {
            print("\(String(format: "%03d", value)): \(key)")
        }
        
    }
}


extension Name {
    
    public func compactDate() -> String {
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "d MMM y"
        return formatter4.string(from: self.date)
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
    
    public static func getDate(_ line: String) -> Date {
        let dateFormat = "yyyy-MM-dd"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        if let convertedDate = dateFormatter.date(from: line) {
            return convertedDate
        }
        return Date()
    }
}
