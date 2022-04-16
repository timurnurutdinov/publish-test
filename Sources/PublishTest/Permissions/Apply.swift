//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 3/1/22.
//

import Foundation
import Files

// Set status
extension Queue {
    
    mutating func restrict(byName name: String, tillEnd: Bool = false, byReason reason: Status = .nda) {
        let names = self.prototypes.map { $0.name.origin }
        
        if let firstIndex = names.firstIndex(of: name) {
            if tillEnd { self.prototypes[firstIndex...].enumerated().forEach { $1.status = .nda } }
            else { self.prototypes[firstIndex].status = .nda }
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
                self.updateTitle(in: newFolder)
            }
        } catch { print() }
    }
    
        
    func updateTitle(in folder: Folder) {
        do {
            let fileURL = URL(fileURLWithPath: folder.path + "framer/framer.generated.js")
            let separators = ["\"documentTitle\":\"", "\"};"]
            
            let content = fileURL.string()
            
            var newTitle = self.name.title.replacingOccurrences(of: ".framer", with: "")
            if (self.name.title == "") { newTitle = "Blank" }
            
            let parts = content.components(separatedBy: separators[0])
            if (parts.count == 2) {
                let nextParts = parts[1].components(separatedBy: separators[1])
                let updatedContent = parts[0] + separators[0] + newTitle + separators[1] + nextParts[1]
                
                let framerFile = try File(path: folder.path + "framer/framer.generated.js")
                try framerFile.delete()
                
                updatedContent.writeFile("framer.generated.js", toFolder: folder.path + "framer/")
            }
            
            

            
        } catch { print("?") }
    }

}

