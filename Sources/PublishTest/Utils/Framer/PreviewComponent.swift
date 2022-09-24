//
//  File.swift
//  
//
//  Created by tilllur on 26.03.2022.
//

import Foundation
import Files

class PreviewComponent {
    
    var modules: [File] = []
    var folders: [Folder] = []
    var shellString = ""
    
    let templateModuleFolder = "/Applications/Framer.app/Contents/Resources/FramerTemplateExtras"
    
    func update(for scope: Queue) {
        do {
            
            try Folder(path: PreviewComponent.moduleFolder).files.enumerated().forEach { (index, file) in
                if (file.name.fileExtension() == "coffee") { self.modules.append(file) }
            }
            
            try Folder(path: PreviewComponent.moduleFolder).subfolders.enumerated().forEach { (index, folder) in
                if (folder.name == PreviewComponent.assetsFolderName) { self.folders.append(folder) }
            }
            
            
            var updatePrototypes = scope.prototypes
            let templatePrototype = Prototype(withFolder: try Folder(path: self.templateModuleFolder))
            updatePrototypes.append(templatePrototype)
            
            
            try updatePrototypes.forEach { prototype in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YY"
                
                let code = self.changeAppFile(for: prototype.name, with: dateFormatter)
                let currentModuleFolder = try prototype.folder.createSubfolderIfNeeded(withName: "modules")
                
                try Folder(path: currentModuleFolder.path).files.enumerated().forEach { (i, file) in
                    if (file.name == PreviewComponent.nameFile) { try file.delete() }
                    if self.modules.first(where: {$0.name == file.name}) != nil { try file.delete() }
                }
                
                try Folder(path: currentModuleFolder.path).subfolders.enumerated().forEach { (i, folder) in
                    if (folder.name == PreviewComponent.assetsFolderName) { try folder.delete() }
                }
                
                code.writeFile(PreviewComponent.nameFile, toFolder: currentModuleFolder.path)
                try self.modules.map { try $0.copy(to: currentModuleFolder) }
                try self.folders.map { try $0.copy(to: currentModuleFolder) }
                
                self.shellString.append(prototype.getShellCommand())
            }
            
//            try
            
        }
        catch { print("Failed to read PreviewComponent folder") }
        self.shellString.writeTempFile("shell.txt")
    }
    
    
    func changeAppFile(for prototypeName:Name, with dateFormatter:DateFormatter) -> String {
        if let appCoffeeURL = URL(string: PreviewComponent.appFile) {
            let originCode = appCoffeeURL.string()
            
            let className = "class Preview extends Layer"
            let newClassName = "class exports.Preview extends Layer"
            let tempCode = originCode.replacingOccurrences(of: className, with: newClassName)
            
            let oldLine = "prototypeCreationYear: \"20:20\""
            let newLine = "prototypeCreationYear: \"\(prototypeName.getStatusBarTime())\""
            let tempCode2 = tempCode.replacingOccurrences(of: oldLine, with: newLine)

            let separator = "# Code for development"
            return tempCode2.components(separatedBy: separator)[0]
        }

        print("Failed to copy PreviewComponent")
        return ""
    }
    
    
    
}


extension Prototype {
    
    func getShellCommand() -> String {
        let command = "python ~/Documents/Git/FramerComponents/FramerModuleBuilder/make.pyc \"\(self.folder.path)modules\" \"\(self.folder.path)framer/framer.modules.js\"\n"
        
        return command
    }
    
}


extension Name {
    
    func getStatusBarTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        let timestamp = dateFormatter.string(from: self.date)
        return "\(timestamp.prefix(2)):\(timestamp.suffix(2))"
    }
    
    func getYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: self.date)
    }
}


extension PreviewComponent {
    static let nameFile = "PreviewComponent.coffee"
    static let assetsFolderName = "PreviewComponentAssets"

    static let componentFolder = "~/Documents/Git/FramerComponents/Component-Queue/Preview.framer"
    static let moduleFolder = "~/Documents/Git/FramerComponents/Component-Queue/Preview.framer/modules"
    static let assetsFolder = "~/Documents/Git/FramerComponents/Component-Queue/Preview.framer/modules/PreviewComponentAssets"
    static let appFile = "~/Documents/Git/FramerComponents/Component-Queue/Preview.framer/app.coffee"

}
