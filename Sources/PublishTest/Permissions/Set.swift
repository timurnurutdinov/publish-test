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
        
        self.saveState()
        self.saveState(configFile: OutputFolder.prototypesJSON, toFolder: OutputFolder.path)
        
        self.savePrototypesPageJSON()
    }
    
    func cleanDynamicFolders() {
        do {
            try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.prototypesDynamicFolder).delete()
            try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.prototypesDynamicFolder)
        }
        catch { print() }
    }
    
    func copyDynamicPrototypes() {
        let dynamicPrototypes: [Prototype] = self.prototypes.filter { $0.status == .opened }
        dynamicPrototypes.enumerated().forEach { (_, prototype) in
            prototype.copy(toFolder: OutputFolder.prototypesDynamicFolder, renameTo: prototype.url)
        }
    }
    
}



extension Queue {
    
    mutating func publishStatic() {
        self.cleanStaticFolders()
        self.setStaticRules()
        self.copyStaticPrototypes()
    }
    
    func cleanStaticFolders() {
        do {
            try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.prototypesStaticFolder).delete()
            try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.prototypesStaticFolder)
        }
        catch { print() }
    }
    
    func copyStaticPrototypes() {
        let staticPrototypes:[Prototype] = self.prototypes.filter { $0.staticURL != "" }
        staticPrototypes.enumerated().forEach { (_, prototype) in
            prototype.copy(toFolder: OutputFolder.prototypesStaticFolder, renameTo: prototype.staticURL)
        }
        
    }
}






