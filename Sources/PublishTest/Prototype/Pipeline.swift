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
        
        
        // TODO HERE
        Site.cleanFolder(self.scope.dynamicShort)
//        self.cleanSiteFolder("d")
        
        self.copyDynamicPrototypes()
        self.copyBlankPrototype()
        self.savePrototypesPageJSON()
        
        Timestamp.put()
    }
    
    public mutating func publishStatic() {
        
        // TODO HERE
        StaticSite.cleanFolder(self.scope.staticShort)
//        self.cleanSiteFolder("s")
        
        self.copyStaticPrototypes()
        
        Timestamp.put()
    }
    
}






extension Queue {
    
    func copyDynamicPrototypes() {
        let dynamicPrototypes: [Prototype] = self.prototypes.filter { $0.json.open }
        dynamicPrototypes.enumerated().forEach { (_, prototype) in
            prototype.copy(toFolder: self.scope.dynamicLong, renameTo: prototype.json.seed)
        }
        print("Published \(dynamicPrototypes.count)/\(self.prototypes.count)")
    }
    
    
    func copyStaticPrototypes() {
        let staticPrototypes:[Prototype] = self.prototypes.filter { $0.json.url != "" }
        staticPrototypes.enumerated().forEach { (_, prototype) in
            prototype.copy(toFolder: self.scope.staticLong, renameTo: prototype.json.url)
        }
        
    }
    
    
    // TODO
    // Blank
    func copyBlankPrototype() {
        do {
            let folder = try Folder(path: "~/Documents/Git/FramerComponents/Component-Queue/Blank.framer")
            let blankPrototype = Prototype(withFolder: folder)
            blankPrototype.copy(toFolder: self.scope.dynamicLong, renameTo: Prototype.blankURL)
        }
        catch { print("Failed to copy Blank.framer") }
    }
}

