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
    var origin: String = ""
    
    var date: Date = Date()
    var type: ProjectType = .unknown
    var project: String = ""
    var title: String = ""
    
    var originDate: String = ""
    var originType: String = ""
//    var originTitle: String = ""
    
    var successParse = false
    
    
    init(_ line: String) {
        self.origin = line
        let pattern = #"([^\s]+) \[([^]]+)\] ([^–^-]+) [—–-] ([^.]+)"#

        let groups = line.matchingStrings(regex: pattern)
        let flattened = groups.flatMap { $0 }
        
        // Success Parse
        if flattened.count > 4 {
            self.originDate = flattened[1]
            self.originType = flattened[2]
//            self.originTitle = flattened[3]
            
            self.date = Name.getDate(self.originDate)
            self.type = Name.getType(self.originType)
            
            self.project = flattened[3]
            self.title = flattened[4]
            
            self.successParse = true
        }
        else {
            print("📭 Skipped for not matching the pattern: \(line)")
        }
    }
    
    func isValid() -> Bool {
        return successParse
    }
    
    func parseFailed() -> Bool {
        return !successParse
    }
    
}




