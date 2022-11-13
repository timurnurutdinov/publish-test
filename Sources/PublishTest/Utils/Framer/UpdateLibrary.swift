//
//  File.swift
//  
//
//  Created by tilllur on 06.04.2022.
//

import Foundation
import Files


extension Queue {
    
    
    public func updateLibrary(component: FramerComponent = FramerComponentEnum.PreviewComponent) {
        
        var refIndexHTML = "index.html"
        var refFramerFolder = "framer"
        
        var framerLibraryFiles = ["framer.generated.js", "coffee-script.js", "framer.init.js", "framer.js", "framer.js.map", "manifest.txt", "style.css", "version"]
        
        var refFile: File? = nil
        var refFramerFiles: [File] = []
        
        
        do {
            
            let refFolder = try Folder(path: component.componentFolder)
            
            try refFolder.files.enumerated().forEach { (index, file) in
                if (file.name == "index.html") { refFile = file }
            }
            
            try refFolder.subfolders.enumerated().forEach { (index, folder) in
                if (folder.name == "framer") {
                    
                    try folder.files.enumerated().forEach { (indexFile, file) in
                        if (framerLibraryFiles.contains(file.name)) {
                            refFramerFiles.append(file)
//                            print("Added as ref file \(file.name)")
                        }
                    }
                }
            }
            
            
            
            try self.prototypes.forEach { prototype in
                print(prototype.name.origin)
                if (prototype.name.origin != refFolder.name) {
                    
                    // Index.html
                    try prototype.folder.files.enumerated().forEach { (i, file) in
                        if (file.name == "index.html") { try file.delete() }
                    }
                    
                    try refFile!.copy(to: prototype.folder)
                    
                    // Framer folder
                    let currentFramerFolderPath = prototype.folder.path + "/framer"
                    let currentFramerFolder = try Folder(path: currentFramerFolderPath)

                    try currentFramerFolder.files.enumerated().forEach { (i, file) in
                        if (framerLibraryFiles.contains(file.name)) { try file.delete() }
                    }

                    try refFramerFiles.map {
                        try $0.copy(to: currentFramerFolder)
                    }
                    
                }
            }
            
            
            
            print("Updated")
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


