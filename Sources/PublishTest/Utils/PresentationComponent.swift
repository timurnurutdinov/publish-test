//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 3/19/22.
//

import Foundation
import Files

class PresentationComponent {
//    var app: File? = nil
    var code: String = ""
    var modules: [File] = []
    var presentations: [Folder] = []
    
    init() {
        do {
            
            self.code = changeAppFile()
//            self.code.writeFile(PresentationComponent.nameFile, toFolder: "~/Desktop")
            
//            try Folder(path: PresentationComponent.componentFolder).files.enumerated().forEach { (index, file) in
//                if (file.name == "app.coffee") { self.app = file }
//            }
            
            try Folder(path: PresentationComponent.moduleFolder).files.enumerated().forEach { (index, file) in
                if (file.name.fileExtension() == "coffee") { self.modules.append(file) }
            }
            
            try Folder(path: PresentationComponent.presentationFolder).subfolders.enumerated().forEach { (index, folder) in
                let currentModuleFolderPath = folder.path + "/modules"
                let currentModuleFolder = try Folder(path: currentModuleFolderPath)
                
                try Folder(path: currentModuleFolderPath).files.enumerated().forEach { (i, file) in
                    if (file.name == PresentationComponent.nameFile) { try file.delete() }
                    if self.modules.first(where: {$0.name == file.name}) != nil { try file.delete() }
                }
                
                self.code.writeFile(PresentationComponent.nameFile, toFolder: currentModuleFolderPath)
                try modules.map { try $0.copy(to: currentModuleFolder) }
            }
        }
        catch { print("Failed to read PresentationComponent folder") }
    }
    
    
    func changeAppFile() -> String {
        if let appCoffeeURL = URL(string: PresentationComponent.appFile) {
            let originCode = appCoffeeURL.string()
            let className = "class Presentation extends PageComponent"
            let newClassName = "class exports.Presentation extends PageComponent"
            
            let tempCode = originCode.replacingOccurrences(of: className, with: newClassName)
            
            let separator = "# Code for development"
            return tempCode.components(separatedBy: separator)[0]
        }
        
        print("Failed to copy PresentationComponent")
        return ""
    }
    
}


extension PresentationComponent {
//    static let appFileName = "app.coffee"
//    static let name = "PresentationComponent"
    static let nameFile = "PresentationComponent.coffee"
//    static let assetFolder = "Presentation-Queue"
//    static let moduleFolder = "modules/"
    
    static let presentationFolder = "~/Documents/Git/PresentationComponent/Presentation-Queue"
    static let componentFolder = "~/Documents/Git/PresentationComponent/Presentation.framer"
    static let moduleFolder = "~/Documents/Git/PresentationComponent/Presentation.framer/modules"
    static let appFile = "~/Documents/Git/PresentationComponent/Presentation.framer/app.coffee"

}


