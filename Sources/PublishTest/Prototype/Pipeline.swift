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
        self.scope.cleanDynamicFolder()
        
        self.copyDynamicPrototypes()
        self.copyBlankPrototype()
        self.savePrototypesPageJSON()
        
//        Timestamp.put()
    }
    
    public mutating func publishStatic() {
        
        // TODO HERE
        self.scope.cleanStaticFolder()
        
        self.copyStaticPrototypes()
        
//        Timestamp.put()
    }
    
}






extension Queue {
    
    func copyDynamicPrototypes() {
        let dynamicPrototypes: [Prototype] = self.prototypes.filter { $0.json.open }
        dynamicPrototypes.enumerated().forEach { (_, prototype) in
            prototype.copy(toFolder: self.scope.dynamicPath, renameTo: prototype.json.seed)
        }
        print("Published \(dynamicPrototypes.count)/\(self.prototypes.count)")
    }
    
    
    func copyStaticPrototypes() {
        let staticPrototypes:[Prototype] = self.prototypes.filter { $0.json.url != "" }
        staticPrototypes.enumerated().forEach { (_, prototype) in
            prototype.copy(toFolder: self.scope.staticPath, renameTo: prototype.json.url)
        }
        
    }
    
    
    // TODO
    // Blank
    func copyBlankPrototype() {
        do {
            let folder = try Folder(path: "~/Documents/Git/FramerComponents/Component-Queue/Blank.framer")
            let blankPrototype = Prototype(withFolder: folder)
            blankPrototype.copy(toFolder: self.scope.dynamicPath, renameTo: Prototype.blankURL)
        }
        catch { print("Failed to copy Blank.framer") }
    }
}

