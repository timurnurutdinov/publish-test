////
////  File.swift
////
////
////  Created by Timur Nurutdinov on 3/19/22.
////

import Foundation
import Files


//class PresentationComponent {
//    
//
//    public func updatePresentation() {
//        
//        var code: String = ""
//        var modules: [File] = []
//        
//        do {
//            self.code = changeAppFile()
//
//            try Folder(path: PresentationComponent.moduleFolder).files.enumerated().forEach { (index, file) in
//                if (file.name.fileExtension() == "coffee") { self.modules.append(file) }
//            }
//
//            try Folder(path: PresentQueue.presentationFolder).subfolders.enumerated().forEach { (index, folder) in
//                let currentModuleFolderPath = folder.path + "/modules"
//                let currentModuleFolder = try Folder(path: currentModuleFolderPath)
//
//                try Folder(path: currentModuleFolderPath).files.enumerated().forEach { (i, file) in
//                    if (file.name == PresentationComponent.nameFile) { try file.delete() }
//                    if self.modules.first(where: {$0.name == file.name}) != nil { try file.delete() }
//                }
//
//                self.code.writeFile(PresentationComponent.nameFile, toFolder: currentModuleFolderPath)
//                try self.modules.map { try $0.copy(to: currentModuleFolder) }
//            }
//        }
//        catch { print("Failed to read PresentationComponent folder") }
//    }
//
//
//    func changeAppFile() -> String {
//        return ""
//        if let appCoffeeURL = URL(string: PresentationComponent.appFile) {
//            let originCode = appCoffeeURL.string()
//
//            let className = "class Presentation extends"
//            let newClassName = "class exports.Presentation extends"
//            let tempCode = originCode.replacingOccurrences(of: className, with: newClassName)
//
//            let separator = "# Code for development"
//            return tempCode.components(separatedBy: separator)[0]
//        }
//
//        print("Failed to copy PresentationComponent")
//        return ""
//    }
//
//}


