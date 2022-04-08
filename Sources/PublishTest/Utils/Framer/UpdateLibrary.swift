//
//  File.swift
//  
//
//  Created by tilllur on 06.04.2022.
//

import Foundation
import Files

class UpdateLibrary {
//    static var refProject = "2022-03-31 [bro] Groups — Flow.framer"
    static var refIndexHTML = "index.html"
    static var refFramerFolder = "framer"
    static var framerLibraryFiles = ["coffee-script.js", "framer.init.js", "framer.js", "framer.js.map", "manifest.txt", "style.css", "version"]
    
    var refFile: File? = nil
//    var refFolder: Folder? = nil
    var refFramerFiles: [File] = []
    
    func update() {
        do {
            let lastFolder = (try Folder(path: scope.path).subfolders.reversed().first)!
            
            try lastFolder.files.enumerated().forEach { (index, file) in
                if (file.name == "index.html") { self.refFile = file }
            }
            
            try lastFolder.subfolders.enumerated().forEach { (index, folder) in
                if (folder.name == "framer") {
                    try lastFolder.files.enumerated().forEach { (indexFile, file) in
                        if (UpdateLibrary.framerLibraryFiles.contains(file.name)) {
                            refFramerFiles.append(file)
                        }
                    }
                }
            }
            
            try scope.prototypes.forEach { prototype in
                if (prototype.name.origin != lastFolder.name) {
                    
                    try prototype.folder.files.enumerated().forEach { (i, file) in
                        if (file.name == "index.html") { try file.delete() }
                    }
                    
                    let currentFramerFolderPath = prototype.folder.path + "/framer"
                    let currentFramerFolder = try Folder(path: currentFramerFolderPath)
                    
                    try currentFramerFolder.files.enumerated().forEach { (i, file) in
                        if (UpdateLibrary.framerLibraryFiles.contains(file.name)) {
                            try file.delete()
                        }
                    }
                    
                    // Write
                    try self.refFile!.copy(to: prototype.folder)
                    try self.refFramerFiles.map {
                        try $0.copy(to: currentFramerFolder)
                    }
                    
                }
            }
            
            
            
            
        }
        catch { print("Failed to Update") }
    }
    
    
//    func changeAppFile() -> String {
//        if let appCoffeeURL = URL(string: PresentationComponent.appFile) {
//            let originCode = appCoffeeURL.string()
//
//            let className = "class Presentation extends PageComponent"
//            let newClassName = "class exports.Presentation extends PageComponent"
//            let tempCode = originCode.replacingOccurrences(of: className, with: newClassName)
//
//            let separator = "# Code for development"
//            return tempCode.components(separatedBy: separator)[0]
//        }
//
//        print("Failed to copy PresentationComponent")
//        return ""
//    }
    
}


extension UpdateLibrary {

}
