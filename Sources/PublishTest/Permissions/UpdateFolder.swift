//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 3/1/22.
//

import Foundation
import Files


extension Prototype {
    
    func addFolder(_ isRestricted: Bool = false) {
        do {
            let listFolder = try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.prototypesDynamicFolder)
            
            var originFolder = try Folder(path: self.folder.path)
//            if isRestricted { originFolder = try Folder(path: Prototype.blankPrototype) }

            let newFolder = try originFolder.copy(to: listFolder)
            try newFolder.rename(to: self.url, keepExtension: false)

        } catch { print() }
    }
    
    
//    func addBlankFolder() { self.addFolder(true) }
    
    func addFolderByURL() {
        do {
            let listFolder = try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.prototypesStaticFolder)
            let originFolder = try Folder(path: self.folder.path)

            let newFolder = try originFolder.copy(to: listFolder)
            try newFolder.rename(to: self.staticURL, keepExtension: false)

        } catch { print() }
    }
    
    
//    func removeFolder() {
//        do {
//            let listFolder = try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.prototypesFolder)
//            let folder = try Folder(path: listFolder.path + "\(self.id)")
//            try folder.delete()
//        }
//        catch { print(error) }
//    }
    
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
