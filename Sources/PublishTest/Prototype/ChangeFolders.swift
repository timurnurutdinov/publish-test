//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 2/4/21.
//

import Foundation
import Files



extension Queue {
    
    func createOutputFolders() {
        do {
            let folder = try Folder(path: "~/Desktop/")
            try folder.createSubfolderIfNeeded(withName: OutputFolder.name)
        }
        catch { print("Failed to create: \(OutputFolder.path)") }
    }
    
    func cleanPrototypesFolder() {
        do {
            try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.prototypesFolder).delete()
            try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.prototypesFolder)
        }
        catch { print() }
    }
}






extension Prototype {
    
    func addFolder(_ isRestricted: Bool = false) {
        do {
            let listFolder = try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.prototypesFolder)
            
            var originFolder = try Folder(path: self.folder.path)
            if isRestricted { originFolder = try Folder(path: Prototype.blankPrototype) }

            let newFolder = try originFolder.copy(to: listFolder)
            try newFolder.rename(to: self.url, keepExtension: false)

        } catch { print() }
    }
    
    
    func addBlankFolder() {
        let withRestriction = true
        self.addFolder(withRestriction)
    }
    
    
    func removeFolder() {
        do {
            let listFolder = try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.prototypesFolder)
            let folder = try Folder(path: listFolder.path + "\(self.id)")
            try folder.delete()
        }
        catch { print(error) }
    }
    
    
    
}
