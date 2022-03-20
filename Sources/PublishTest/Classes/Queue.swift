//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 8/1/21.
//

import Foundation
import Files

struct Queue {
    
    var prototypes: [Prototype] = []
    var path = ""
    
    var prevState: [PrototypeConfig] = []
    var nextState: [PrototypeConfig] = []
    
    
    // Complexity
    var maxLines = 0
    var average: Double = 0.0
    var standardVariation: Double = 1.0
    var zScore: [Double] = [Double]()
    
    mutating func setMaxLines(_ value: Int) { self.maxLines = value }
    mutating func setAvarage(_ value: Double) { self.average = value }
    mutating func setStandardVariation(_ value: Double) { self.standardVariation = value }
    mutating func setZScore(_ array: [Double]) { self.zScore = array }
    
    mutating func setState(_ state: [PrototypeConfig]) { self.nextState = state }
    
    
    
    init(withPath path: String) {
        self.path = path
        self.createOutputFolders()
        self.readState()
    }
    
    mutating func read(_ selectedPath:String = Queue.production) {
        do {
            try Folder(path: selectedPath).subfolders.enumerated().forEach { (index, folder) in
                self.prototypes.append(Prototype(withFolder: folder, andID: self.prototypes.count))
            }
        } catch { print("Failed to read Queue")}
    }
    
}



extension Queue {
    static let production = "~/Documents/Git/Prototyping-Queue/"
    static let testing = "~/Documents/testing-queue/"
}



struct OutputFolder {
    // TODO: change folder
    static let name = "output" // Bad
    static let path = "~/Documents/Git/tilllur.ru/"
    
    static let prototypesDynamicFolder = "d"
    static let prototypesStaticFolder = "s"
    static let presentationFolder = "p"
    
    static let prototypesJSON = "d.json"
    
}




