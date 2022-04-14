//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 3/1/22.
//

import Foundation

// Set status
extension Queue {
    
    mutating func restrict(byName name: String, tillEnd: Bool = false, byReason reason: RestrictionReason = RestrictionReason.temporaryNDA) {
        let names = self.prototypes.map { $0.name.origin }
        
        if let firstIndex = names.firstIndex(of: name) {
            if tillEnd { self.prototypes[firstIndex...].enumerated().forEach { $1.status = .closed } }
            else { self.prototypes[firstIndex].status = .closed }
        }
    }
    
    mutating func allow(byName name: String) {
        let names = self.prototypes.map { $0.name.origin }
        if let firstIndex = names.firstIndex(of: name) {
            self.prototypes[firstIndex].status = .opened
        }
    }
    
    func allow(byName name: String, withURL url: String) {
        let names = self.prototypes.map { $0.name.origin }
        if let firstIndex = names.firstIndex(of: name) {
            self.prototypes[firstIndex].setStaticURL(url)
        }
    }
    
    func feature(byName name: String) {
        let names = self.prototypes.map { $0.name.origin }
        if let firstIndex = names.firstIndex(of: name) {
            self.prototypes[firstIndex].featured = .starred
        }
    }

}


extension Prototype {
    
    func copy(toFolder: String, renameTo newName: String) {
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
