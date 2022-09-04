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
    
    mutating func publishDynamic() {
        self.cleanDynamicFolders()
        self.setDynamicRules()
        self.setFeatured()
        
        self.copyDynamicPrototypes()
        self.copyBlankPrototype()
        
        self.savePrototypesPageJSON()
    }
    
    func cleanDynamicFolders() {
        do {
            try Folder(path: SiteFolder.path).createSubfolderIfNeeded(withName: self.scope.outputDynamic).delete()
            try Folder(path: SiteFolder.path).createSubfolderIfNeeded(withName: self.scope.outputDynamic)
        }
        catch { print() }
    }
    
    func copyDynamicPrototypes() {
        let dynamicPrototypes: [Prototype] = self.prototypes.filter { $0.status == .opened }
        dynamicPrototypes.enumerated().forEach { (_, prototype) in
            prototype.copy(toFolder: self.scope.outputDynamic, renameTo: prototype.seed.nameDynamic)
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
        self.cleanStaticFolders()
        self.setStaticRules()
        self.copyStaticPrototypes()
    }
    
    func cleanStaticFolders() {
        do {
            try Folder(path: SiteFolder.path).createSubfolderIfNeeded(withName: self.scope.outputStatic).delete()
            try Folder(path: SiteFolder.path).createSubfolderIfNeeded(withName: self.scope.outputStatic)
        }
        catch { print() }
    }
    
    func copyStaticPrototypes() {
        let staticPrototypes:[Prototype] = self.prototypes.filter { $0.seed.nameStatic != "" }
        staticPrototypes.enumerated().forEach { (_, prototype) in
            prototype.copy(toFolder: self.scope.outputStatic, renameTo: prototype.seed.nameStatic)
        }
        
    }
}






