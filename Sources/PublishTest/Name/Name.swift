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

public class Name {
    public var origin: String = ""
    
    var date: Date = Date()
    var type: ProjectType = .unknown
    public var project: String = ""
    public var title: String = ""
    
    var originDate: String = ""
    var originType: String = ""
    
    var successParse = false
    
    
    public init(_ line: String) {
        self.origin = line
        let pattern = #"([^\s]+) \[([^]]+)\] ([^–^-]+) [—–-] ([^.]+)"#

        let groups = line.matchingStrings(regex: pattern)
        let flattened = groups.flatMap { $0 }
        
        if flattened.count > 4 {
            self.originDate = flattened[1]
            self.originType = flattened[2]
            
            self.date = Name.getDate(self.originDate)
            self.type = Name.getType(self.originType)
            
            self.project = flattened[3]
            self.title = flattened[4]
            
            self.successParse = true
        }
//        else {
//            print("📭 Name skipped: pattern doesn't match for: \(line)")
//        }
    }
    
    func isValid() -> Bool {
        return successParse
    }
    
    func parseFailed() -> Bool {
        return !successParse
    }
    
}




