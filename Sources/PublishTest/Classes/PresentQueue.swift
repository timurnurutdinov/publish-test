//
//  File.swift
//  
//
//  Created by tilllur on 19.03.2022.
//

import Foundation
import Files

class PresentQueue {
    var prototypes: [Prototype] = []
    
    init() {
        do {
            try Folder(path: PresentQueue.presentationFolder).subfolders.enumerated().forEach { (index, folder) in
                self.prototypes.append(Prototype(withFolder: folder))
            }
        } catch { print("Failed to read Presentations") }
    }
    
    func publish() {
        self.cleanFolders()
        self.openForProduction()
        self.setFolders()
    }
    
    func allow(byName name: String, withURL url: String) {
        let names = self.prototypes.map { $0.name.origin }
        if let firstIndex = names.firstIndex(of: name) {
            self.prototypes[firstIndex].setStaticURL(url)
            print("Added: \(url)")
        }
    }
    
    func setFolders() {
        let toAddStatic:[Prototype] = self.prototypes.filter { $0.staticURL != "" }
        toAddStatic.enumerated().forEach {
            $1.addFolder(toFolder: OutputFolder.presentationFolder, renamedTo: $1.staticURL)
        }
    }
    
    func cleanFolders() {
        do {
            try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.presentationFolder).delete()
            try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.presentationFolder)
        } catch { print() }
    }
}


extension PresentQueue {
    static let presentationFolder = "~/Documents/Git/PresentationComponent/Presentation-Queue"
}
