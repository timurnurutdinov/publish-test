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
    
    public mutating func publishDynamic() {
        
        Site.cleanFolder(self.scope.dynamicShort)
//        self.cleanSiteFolder("d")
        
        self.copyDynamicPrototypes()
        self.copyBlankPrototype()
        self.savePrototypesPageJSON()
        
        Timestamp.put()
    }
    
    public mutating func publishStatic() {
        
        Site.cleanFolder(self.scope.staticShort)
//        self.cleanSiteFolder("s")
        
        self.copyStaticPrototypes()
        
        Timestamp.put()
    }
    
}






extension Queue {
    
    func copyDynamicPrototypes() {
        let dynamicPrototypes: [Prototype] = self.prototypes.filter { $0.status == .opened }
        dynamicPrototypes.enumerated().forEach { (_, prototype) in
            prototype.copy(toFolder: self.scope.dynamicLong, renameTo: prototype.dynamicSeed.url)
        }
        print("Published \(dynamicPrototypes.count)/\(self.prototypes.count)")
    }
    
    
    func copyStaticPrototypes() {
        let staticPrototypes:[Prototype] = self.prototypes.filter { $0.staticSeed.url != "" }
        staticPrototypes.enumerated().forEach { (_, prototype) in
            prototype.copy(toFolder: self.scope.staticLong, renameTo: prototype.staticSeed.url)
        }
        
    }
    
    
    // Blank
    func copyBlankPrototype() {
        do {
            let folder = try Folder(path: "~/Documents/Git/FramerComponents/Blank.framer")
            let blankPrototype = Prototype(withFolder: folder)
            blankPrototype.copy(toFolder: self.scope.dynamicLong, renameTo: Prototype.blankURL)
        }
        catch { print("Failed to copy Blank.framer") }
    }
}





//extension Queue {
//    
//    func cleanSiteFolder(_ path: String) {
//        do {
//            try Folder(path: Site.host).createSubfolderIfNeeded(withName: path).delete()
//            try Folder(path: Site.host).createSubfolderIfNeeded(withName: path)
//        }
//        catch { print() }
//    }
//}
