//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 7/24/21.
//

import Foundation
import Checksum
import Files



extension Queue {
    
    func cleanSiteFolder(_ path: String) {
        do {
            try Folder(path: SiteFolder.path).createSubfolderIfNeeded(withName: path).delete()
            try Folder(path: SiteFolder.path).createSubfolderIfNeeded(withName: path)
        }
        catch { print() }
    }
    
    
    public mutating func publishDynamic() {
        self.cleanSiteFolder("d")
        self.copyDynamicPrototypes()
        self.copyBlankPrototype()
        self.savePrototypesPageJSON()
        
        Timestamp()
    }
    
    
    func copyDynamicPrototypes() {
        print(self.prototypes.map { $0.status })
        let dynamicPrototypes: [Prototype] = self.prototypes.filter { $0.status == .opened }
        print(dynamicPrototypes.count)
        dynamicPrototypes.enumerated().forEach { (_, prototype) in
            prototype.copy(toFolder: self.scope.outputDynamic, renameTo: prototype.dynamicSeed.url)
        }
        print("Published \(dynamicPrototypes.count)/\(self.prototypes.count)")
    }
    
    func copyBlankPrototype() {
        do {
            let folder = try Folder(path: "~/Documents/Git/FramerComponents/Blank.framer")
            let blankPrototype = Prototype(withFolder: folder)
            blankPrototype.copy(toFolder: self.scope.outputDynamic, renameTo: Prototype.blankURL)
        }
        catch { print("Failed to copy Blank.framer") }
    }
    
}



extension Queue {
    
    public mutating func publishStatic() {
        self.cleanSiteFolder("s")
        self.copyStaticPrototypes()
        
        Timestamp()
    }
    
    func cleanStaticFolders() {
        do {
            try Folder(path: SiteFolder.path).createSubfolderIfNeeded(withName: self.scope.outputStatic).delete()
            try Folder(path: SiteFolder.path).createSubfolderIfNeeded(withName: self.scope.outputStatic)
        }
        catch { print() }
    }
    
    func copyStaticPrototypes() {
        let staticPrototypes:[Prototype] = self.prototypes.filter { $0.staticSeed.url != "" }
        staticPrototypes.enumerated().forEach { (_, prototype) in
            prototype.copy(toFolder: self.scope.outputStatic, renameTo: prototype.staticSeed.url)
        }
        
    }
}






