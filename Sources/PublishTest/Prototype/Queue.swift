//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 8/1/21.
//

import Foundation

struct Queue {
    
    var prototypes: [Prototype] = []
    var path = ""
    
    
    // Complexity
    var maxLines = 0
    var average: Double = 0.0
    var standardVariation: Double = 1.0
    var zScore: [Double] = [Double]()
    
    mutating func setMaxLines(_ value: Int) { self.maxLines = value }
    mutating func setAvarage(_ value: Double) { self.average = value }
    mutating func setStandardVariation(_ value: Double) { self.standardVariation = value }
    mutating func setZScore(_ array: [Double]) { self.zScore = array }
    
    
    // Restrictions
    var restrictedTillName: String = ""
    var restrictedList = [String]()
    var allowedList = [String]()
    
    mutating func restrict(till tillName: String) { self.restrictedTillName = tillName }
    mutating func restrict(byName name: String) { self.restrictedList.append(name) }
    mutating func allow(byName name: String) { self.allowedList.append(name) }
    
    
    
    var moduleNames: [String: String] = [:]
    
    
    init(withPath path: String) {
        self.path = path
        self.createOutputFolders()
    }
    
    mutating func add(_ prototype: Prototype) {
        self.prototypes.append(prototype)
    }
}



struct OutputFolder {
    static let name = "output"
    static let path = "~/Desktop/output/"
    
    static let prototypesFolder = "show"
}

