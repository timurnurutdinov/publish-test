//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 2/4/21.
//

import Foundation
import Files

extension File {
    
    func lines() -> Int {
        do {
            let str = try Data(contentsOf: self.url).withUnsafeBytes { String(decoding: $0, as: UTF8.self) }
            return str.utf8.split(separator: UInt8(ascii: "\n"), omittingEmptySubsequences: false).count
        }
        catch { print("Failed to count lines: \(self.path)") }
        return 0
    }
    
//    func string() -> String {
//        do {
//            let str = try Data(contentsOf: self.url).withUnsafeBytes { String(decoding: $0, as: UTF8.self) }
//            return str
//        }
//        catch { print("Failed to count lines: \(self.path)") }
//        return ""
//    }
    
    func testData() -> Data {
        do {
            return try Data(contentsOf: self.url)
        }
        catch { print("Failed to count lines: \(self.path)") }
        return Data()
    }
}


