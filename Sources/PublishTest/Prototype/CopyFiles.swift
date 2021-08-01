//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 2/4/21.
//

import Foundation
import Files



extension Queue {
    
    func duplicatePrototypes(allowedPrototypes:[Prototype]) {
        allowedPrototypes.enumerated().forEach { (index, prototype) in prototype.copyFiles() }
    }
    
    func createOutputFolders() {
        do {
            let folder = try Folder(path: "~/Desktop/")
            try folder.createSubfolderIfNeeded(withName: OutputFolder.name)
        }
        catch { print("📭 Failed to create: \(OutputFolder.name)") }
        
    }
}

extension Prototype {
    func copyFiles() {
        do {
            let newRepositoryFolder = try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.prototypesFolder)
            let originFolder = try Folder(path: self.folder.path)
            
            let newFolder = try originFolder.copy(to: newRepositoryFolder)
            try newFolder.rename(to: String(self.id), keepExtension: false)
            
        } catch { print() }
    }
}
