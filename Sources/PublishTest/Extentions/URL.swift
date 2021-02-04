//
//  File 2.swift
//  
//
//  Created by Timur Nurutdinov on 2/4/21.
//

import Foundation
import Files

extension URL {
    func lines() -> Int {
        do { return try File(path: self.path).lines() }
        catch { print("🛑 Failed to count lines in app.coffee") }
        return 0
    }
}
