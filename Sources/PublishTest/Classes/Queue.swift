//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 8/1/21.
//

import Foundation
import Files


public struct ScopeEnum {
    public static var production    = Scope("~/Documents/Git/Prototyping-Queue/",
                                            static: "~/Documents/Git/tilllur.ru/s",
                                            dynamic: "~/Documents/Git/tilllur.ru/d")
    
    public static var presentations = Scope("~/Documents/Git/FramerComponents/Presentation-Queue",
                                            static: "~/Documents/Git/tilllur.ru/p",
                                            dynamic: "~/Documents/Git/tilllur.ru/remove")
    
    public static var other         = Scope("~/Documents/Git/FramerComponents/Experiment-Queue",
                                            static: "~/Documents/Git/tilllur.ru/utils",
                                            dynamic: "~/Documents/Git/tilllur.ru/remove")
}



public struct Scope: Equatable {
    public var input: String
    public var outputStatic: String
    public var outputDynamic: String

    init(_ input:String, static outputStatic: String, dynamic outputDynamic: String) {
        self.input = input
        self.outputStatic = outputStatic
        self.outputDynamic = outputDynamic
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
    
    mutating func addPrototype(for folder: Folder, shouldUpdateIndex:Bool = true) {
        let name = Name(folder.name)
        
        if (name.isValid()) {
            let prototype = Prototype(withFolder: folder)
//            let url = self.getURLState(for: prototype.name)
            let url = "temp"
            prototype.setDynamicURL(url)
            self.prototypes.append(prototype)
            if (shouldUpdateIndex) { prototype.setIndex(self.prototypes.count) }
            
            prototype.getPermissionWithTag()
        }
        else {
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
            
            if (count == 0) { selectedProjects = projects[...] }
            else { selectedProjects = projects[..<count] }
            
            selectedProjects.enumerated().forEach { (index, folder) in
                self.addPrototype(for: folder)
            }
            
        } catch { print("Failed to read Queue")}
        
//        self.saveURLState()
    }
}



struct SiteFolder {
    static let path = "~/Documents/Git/tilllur.ru/"
    static let prototypesJSON = "d.json"
}




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
