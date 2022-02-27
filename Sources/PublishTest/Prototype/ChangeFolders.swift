//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 2/4/21.
//

import Foundation
import Files



// Set prototypes folder:
// 1. Update .opened
// 2. Make .closed blank

extension Queue {
    
    func setFolders() {
        let toCopyPrototypes = self.prototypes.filter { $0.action != .remove && $0.action != .none }
        toCopyPrototypes.enumerated().forEach {
            if $1.action == .updateAndClose || $1.action == .updateAndOpen { self.removeFolder(withID: $1.id) }
            $1.addFolder()
        }
        
//        let toRemovePrototypes = self.prototypes.filter { $0.action == .remove }
    }
    
    func copyBlank() {
        
    }
    
    
    func removeFolder(withID id:Int) {
        do {
            let listFolder = try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.prototypesFolder)
            let folder = try Folder(path: listFolder.path + "\(id)")
            try folder.delete()
        }
        catch { print(error) }
    }
    

    
}



// General Init
extension Queue {
    func createOutputFolders() {
        do {
            // TODO: Refactor
            let folder = try Folder(path: "~/Desktop/")
            try folder.createSubfolderIfNeeded(withName: OutputFolder.name)
        }
        catch { print("📭 Failed to create: \(OutputFolder.name)") }
    }
}



extension Prototype {
    func addFolder() {
        do {
            let listFolder = try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.prototypesFolder)
            let originFolder = try Folder(path: self.folder.path)

            let newFolder = try originFolder.copy(to: listFolder)
            try newFolder.rename(to: String(self.id), keepExtension: false)

        } catch { print() }
    }
}
