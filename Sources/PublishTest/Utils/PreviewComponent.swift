//
//  File.swift
//  
//
//  Created by tilllur on 26.03.2022.
//

import Foundation
import Files

class PreviewComponent {
    var code: String = ""
    var modules: [File] = []
    var folders: [Folder] = []
    
    func update(for scope: Queue) {
        do {
            self.code = changeAppFile()
            
            try Folder(path: PreviewComponent.moduleFolder).files.enumerated().forEach { (index, file) in
                if (file.name.fileExtension() == "coffee") { self.modules.append(file) }
            }
            
            try Folder(path: PreviewComponent.moduleFolder).subfolders.enumerated().forEach { (index, folder) in
                if (folder.name == PreviewComponent.assetsFolderName) { self.folders.append(folder) }
            }
            
            try scope.prototypes.forEach { prototype in
                let currentModuleFolder = try prototype.folder.createSubfolderIfNeeded(withName: "modules")
                
                try Folder(path: currentModuleFolder.path).files.enumerated().forEach { (i, file) in
                    if (file.name == PreviewComponent.nameFile) { try file.delete() }
                    if self.modules.first(where: {$0.name == file.name}) != nil { try file.delete() }
                }
                
                try Folder(path: currentModuleFolder.path).subfolders.enumerated().forEach { (i, folder) in
                    if (folder.name == PreviewComponent.assetsFolderName) { try folder.delete() }
                }
                
                self.code.writeFile(PreviewComponent.nameFile, toFolder: currentModuleFolder.path)
                try self.modules.map { try $0.copy(to: currentModuleFolder) }
                try self.folders.map { try $0.copy(to: currentModuleFolder) }
            }
        }
        catch { print("Failed to read PreviewComponent folder") }
    }
    
    
    func changeAppFile() -> String {
        if let appCoffeeURL = URL(string: PreviewComponent.appFile) {
            let originCode = appCoffeeURL.string()
            
            let className = "class Preview extends Layer"
            let newClassName = "class exports.Preview extends Layer"
            let tempCode = originCode.replacingOccurrences(of: className, with: newClassName)
            
            let oldLine = "prototypeCreationYear: \"2020\""
            let newLine = "prototypeCreationYear: \"2021\""
            let tempCode2 = tempCode.replacingOccurrences(of: oldLine, with: newLine)

            let separator = "# Code for development"
            return tempCode2.components(separatedBy: separator)[0]
        }

        print("Failed to copy PreviewComponent")
        return ""
    }
    
}




extension PreviewComponent {
    static let nameFile = "PreviewComponent.coffee"
    static let assetsFolderName = "PreviewComponentAssets"

    static let componentFolder = "~/Documents/Git/FramerComponents/Preview.framer"
    static let moduleFolder = "~/Documents/Git/FramerComponents/Preview.framer/modules"
    static let assetsFolder = "~/Documents/Git/FramerComponents/Preview.framer/PreviewComponentAssets"
    static let appFile = "~/Documents/Git/FramerComponents/Preview.framer/app.coffee"

}
