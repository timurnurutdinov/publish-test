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
}
