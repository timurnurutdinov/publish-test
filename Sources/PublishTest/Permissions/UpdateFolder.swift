//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 3/1/22.
//

import Foundation
import Files


extension Prototype {
    
    func addFolder() {
        self.addFolder(toFolder: OutputFolder.prototypesDynamicFolder, renamedTo: self.url)
    }
    
    
    func addFolderByURL() {
        self.addFolder(toFolder: OutputFolder.prototypesStaticFolder, renamedTo: self.staticURL)
    }
    
    
    func addFolder(toFolder: String, renamedTo newName: String) {
        do {
            let listFolder = try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: toFolder)
            let originFolder = try Folder(path: self.folder.path)

            let newFolder = try originFolder.copy(to: listFolder)
            if !newName.isEmpty {
                try newFolder.rename(to: newName, keepExtension: false)
            }
        } catch { print() }
    }


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
