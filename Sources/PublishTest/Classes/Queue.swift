//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 8/1/21.
//

import Foundation
import Files

public struct Queue {
    
    var prototypes: [Prototype] = []
    var path = ""
    
    var urlState = Set<PrototypeConfig>()
    
    
    // Complexity
    var maxLines = 0
    var average: Double = 0.0
    var standardVariation: Double = 1.0
    var zScore: [Double] = [Double]()
    
    mutating func setMaxLines(_ value: Int) { self.maxLines = value }
    mutating func setAvarage(_ value: Double) { self.average = value }
    mutating func setStandardVariation(_ value: Double) { self.standardVariation = value }
    mutating func setZScore(_ array: [Double]) { self.zScore = array }
    
    
    public init() {}
    
    public init(withPath path: String) {
        self.path = path
        self.createOutputFolders()
        self.readURLState()
    }
    
    public func getPrototypes() -> [Prototype] {
        return self.prototypes
    }
    
}



extension Queue {

    public static func load(fromPath path: String = "~/Documents/Git/Prototyping-Queue/") -> Queue {
        var queue = Queue(withPath: path)
        do {
            queue.read()
            return queue
        }
        catch {}
        return Queue()
    }
    
    public static func load(last n: Int = 10, fromPath path: String = "~/Documents/Git/Prototyping-Queue/") -> Queue {
        var queue = Queue(withPath: path)
        do {
            queue.readLast(n)
            return queue
        }
        catch {}
        return Queue()
    }

}


extension Queue {
    static let production = "~/Documents/Git/Prototyping-Queue/"
    static let testing = "~/Desktop/testing-queue/"
    
    
    mutating func addPrototype(for folder: Folder, shouldUpdateIndex:Bool = true) {
        let name = Name(folder.name)
        
        if (name.isValid()) {
            let prototype = Prototype(withFolder: folder)
            let url = self.getURLState(for: prototype.name)
            prototype.setDynamicURL(url)
            self.prototypes.append(prototype)
            if (shouldUpdateIndex) { prototype.setIndex(self.prototypes.count) }
            
            prototype.getPermissionWithTag()
        }
        else {
            print("📭 Name skipped: pattern doesn't match for: \(name.origin)")
        }
    }
    
    
    mutating func getURLState(for name: Name) -> String {
        let newConf = PrototypeConfig(originName: name.origin, url: String.randomStringForURL())
        let elem = self.urlState.first { $0.originName == newConf.originName }
        
        if elem != nil { return elem!.url }
        else {
            self.urlState.insert(newConf)
            return newConf.url
        }
        
    }
    
    
    public mutating func read() {
        do {
            try Folder(path: self.path).subfolders.enumerated().forEach { (index, folder) in
                self.addPrototype(for: folder)
            }
        } catch { print("Failed to read Queue")}
        
        self.saveURLState()
    }
    
    
    public mutating func readLast(_ count: Int = 1) {
        do {
            let projects = try Folder(path: self.path).subfolders.reversed().map { $0 }
            var selectedProjects = ArraySlice<Folder>()
            
            if (count == 0) { selectedProjects = projects[...] }
            else { selectedProjects = projects[..<count] }
            
            selectedProjects.enumerated().forEach { (index, folder) in
                self.addPrototype(for: folder)
            }
            
        } catch { print("Failed to read Queue")}
        
        self.saveURLState()
    }
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




extension Queue {
    
    func createOutputFolders() {
        do {
            let folder = try Folder(path: "~/Desktop/")
            try folder.createSubfolderIfNeeded(withName: OutputFolder.name)
        }
        catch { print("Failed to create: \(OutputFolder.path)") }
    }
}
