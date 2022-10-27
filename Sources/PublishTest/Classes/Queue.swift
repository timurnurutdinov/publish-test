//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 8/1/21.
//

import Foundation
import Files
import WebKit


public struct Site {
    public static var host = "~/Documents/Git/tilllur.ru/"
    
    public static func with(_ shortPath: String) -> String { return Site.host + shortPath }
    
    
    public static func cleanFolder(_ shortPath: String) {
        do {
            try Folder(path: Site.host).createSubfolderIfNeeded(withName: shortPath).delete()
            try Folder(path: Site.host).createSubfolderIfNeeded(withName: shortPath)
        }
        catch { print() }
    }
}



public struct ScopeEnum {
    public static var production    = Scope("~/Documents/Git/Prototyping-Queue/",
                                            static: "s",
                                            dynamic: "d")
    
    public static var presentations = Scope("~/Documents/Git/FramerComponents/Presentation-Queue",
                                            static: "p",
                                            dynamic: "remove")
    
    public static var components = Scope("~/Documents/Git/FramerComponents/Component-Queue",
                                            static: "remove",
                                            dynamic: "remove")
    
    public static var other         = Scope("~/Documents/Git/FramerComponents/Experiment-Queue",
                                            static: "utils",
                                            dynamic: "remove")
}



public struct Scope: Equatable {
    public var input: String
    
    public var staticShort: String
    public var staticLong: String
    
    
    public var dynamicShort: String
    public var dynamicLong: String
    

    init(_ input:String, static outputStatic: String, dynamic outputDynamic: String) {
        self.input = input
        
        staticShort = outputStatic
        dynamicShort = outputDynamic
        
        staticLong = Site.with(staticShort)
        dynamicLong = Site.with(dynamicShort)
        
    }
    
    public static func == (lhs: Scope, rhs: Scope) -> Bool {
        return (lhs.input == rhs.input)
    }
}





public struct Queue {
    public var scope: Scope
    public var prototypes: [Prototype] = []
    
    public init(_ scope: Scope) {
        self.scope = scope
        self.createOutputFolders() // TODO: remove
    }
    
}



extension Queue {
    
    mutating func addPrototype(for folder: Folder) {
        let name = Name(folder.name)
        
        if (name.isValid()) {
            self.prototypes.append(Prototype(withFolder: folder))
        }
        else {
            if (self.scope == ScopeEnum.components) { self.prototypes.append(Prototype(withFolder: folder)) }
            print("📭 Name skipped: pattern doesn't match for: \(name.origin)")
        }
    }
    
    
//    mutating func getURLState(for name: Name) -> String {
//        let newConf = PrototypeConfig(originName: name.origin, url: String.randomStringForURL())
//        let elem = self.urlState.first { $0.originName == newConf.originName }
//
//        if elem != nil { return elem!.url }
//        else {
//            self.urlState.insert(newConf)
//            return newConf.url
//        }
//
//    }
    
    
    public mutating func read() {
        self.prototypes = [Prototype]()
        do {
            try Folder(path: self.scope.input).subfolders.reversed().enumerated().forEach { (index, folder) in
                self.addPrototype(for: folder)
            }
        } catch { print("Failed to read Queue")}
        
//        self.saveURLState()
    }
    
    
    public mutating func readLast(_ count: Int = 1) {
        self.prototypes = [Prototype]()
        do {
            let projects = try Folder(path: self.scope.input).subfolders.reversed().map { $0 }
            var selectedProjects = ArraySlice<Folder>()
            
            let mCount = min(count, projects.count)
            
            if (count == 0) { selectedProjects = projects[...] }
            else { selectedProjects = projects[..<mCount] }
            
            selectedProjects.enumerated().forEach { (index, folder) in
                self.addPrototype(for: folder)
            }
            
        } catch { print("Failed to read Queue")}
        
//        self.saveURLState()
    }
}



//struct SiteFolder {
//    static let path = "~/Documents/Git/tilllur.ru/"
//    static let prototypesJSON = "d.json"
//}




extension Queue {
    static let dirtyOutputName = "output" // Bad
    
    func createOutputFolders() {
        do {
            let folder = try Folder(path: "~/Documents/PublishTest")
            try folder.createSubfolderIfNeeded(withName: Queue.dirtyOutputName)
        }
        catch { print("Failed to created OUTPUT temp") }
    }
}


//struct PrototypeComplexity {
//    // Complexity
//    var maxLines = 0
//    var average: Double = 0.0
//    var standardVariation: Double = 1.0
//    var zScore: [Double] = [Double]()
//
//    mutating func setMaxLines(_ value: Int) { self.maxLines = value }
//    mutating func setAvarage(_ value: Double) { self.average = value }
//    mutating func setStandardVariation(_ value: Double) { self.standardVariation = value }
//    mutating func setZScore(_ array: [Double]) { self.zScore = array }
//}
