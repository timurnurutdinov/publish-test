//
//  File.swift
//  
//
//  Created by tilllur on 26.03.2022.
//

import Foundation
import Files

extension Queue {
    
//    public func updatePresentationComponent() {
//        self.update(module: ComponentUpdateEnum.PresentationComponent)
//    }
    
    public func update(component: FramerComponent) {
        
        var modules: [File] = []
        var folders: [Folder] = []
        
        do {
            
            try Folder(path: component.moduleFolder).files.enumerated().forEach { (index, file) in
                if (file.name.fileExtension() == "coffee") { modules.append(file) }
                else if (file.name.fileExtension() == "css") { modules.append(file) }
                else if (file.name.fileExtension() == "ttf") { modules.append(file) }
            }
            
            try Folder(path: component.moduleFolder).subfolders.enumerated().forEach { (index, folder) in
                if (folder.name == component.assetsFolderName) { folders.append(folder) }
            }
            
            
            try self.prototypes.forEach { prototype in
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YY"
                
                let code = component.changeAppFile(for: prototype.name, with: dateFormatter)
                let currentModuleFolder = try prototype.folder.createSubfolderIfNeeded(withName: "modules")
                
                try Folder(path: currentModuleFolder.path).files.enumerated().forEach { (i, file) in
                    if (file.name == component.nameFile) { try file.delete() }
                    if modules.first(where: {$0.name == file.name}) != nil { try file.delete() }
                }
                
                try Folder(path: currentModuleFolder.path).subfolders.enumerated().forEach { (i, folder) in
                    if (folder.name == component.assetsFolderName) { try folder.delete() }
                }
                
                code.writeFile(component.nameFile, toFolder: currentModuleFolder.path)
                try modules.map { try $0.copy(to: currentModuleFolder) }
                try folders.map { try $0.copy(to: currentModuleFolder) }
                
//                shellString.append(prototype.getShellCommand())
                prototype.buildModules()
            }
            
        }
        
        catch { print("Failed to read PreviewComponent folder") }
        
    }
    
    
//    func changeAppFile(for prototypeName:Name, with dateFormatter:DateFormatter) -> String {
//        if let appCoffeeURL = URL(string: PreviewComponent.appFile) {
//            let originCode = appCoffeeURL.string()
//
//            let className = "class Preview extends Layer"
//            let newClassName = "class exports.Preview extends Layer"
//            let tempCode = originCode.replacingOccurrences(of: className, with: newClassName)
//
//            let oldLine = "prototypeCreationYear: \"20:20\""
//            let newLine = "prototypeCreationYear: \"\(prototypeName.getStatusBarTime())\""
//            let tempCode2 = tempCode.replacingOccurrences(of: oldLine, with: newLine)
//
//            let separator = "# Code for development"
//            return tempCode2.components(separatedBy: separator)[0]
//        }
//
//        print("Failed to copy PreviewComponent")
//        return ""
//    }
    
    
    
}


extension Prototype {
    
    public func buildModules() {
        let cdExecutableURL = URL(fileURLWithPath: "bin/zsh")
        
        let command = "export PATH=\"$PATH:\"/opt/homebrew/opt/node/bin; node -v; cd /Users/tilllur/Documents/Git/publish-test/framer-bundler-master/; ls; export PATH=\"$PATH:\"/usr/local/bin/; node /Users/tilllur/Documents/Git/publish-test/framer-bundler-master/index.js \"\(self.folder.path)\""

        try! Process.run(cdExecutableURL,
            arguments: ["-c", command],
            terminationHandler: { _ in print("updated") })
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



public enum FramerComponentEnum {
    
    public static var PreviewComponent = FramerComponent(nameFile:          "PreviewComponent.coffee",
                                                         assetsFolderName:  "PreviewComponentAssets",
                                                         componentFolder:   "~/Documents/Git/PreviewComponent/Preview.framer",
                                                         moduleFolder:      "~/Documents/Git/PreviewComponent/Preview.framer/modules",
                                                         assetsFolder:      "~/Documents/Git/PreviewComponent/Preview.framer/modules/PreviewComponentAssets",
                                                         appFile:           "~/Documents/Git/PreviewComponent/Preview.framer/app.coffee")
    
    public static var PresentationComponent = FramerComponent(nameFile:     "PresentationComponent.coffee",
                                                         assetsFolderName:  "PresentationComponentAssets",
                                                         componentFolder:   "~/Documents/Git/PresentationComponent/Presentation.framer",
                                                         moduleFolder:      "~/Documents/Git/PresentationComponent/Presentation.framer/modules",
                                                         assetsFolder:      "~/Documents/Git/PresentationComponent/Presentation.framer/modules/PresentationComponentAssets",
                                                         appFile:           "~/Documents/Git/PresentationComponent/Presentation.framer/app.coffee")
}



public struct FramerComponent {
    var nameFile = ""
    var assetsFolderName = ""

    var componentFolder = ""
    var moduleFolder = ""
    var assetsFolder = ""
    var appFile = ""
    
    
    func changeAppFile(for prototypeName:Name, with dateFormatter:DateFormatter) -> String {
        if let appCoffeeURL = URL(string: self.appFile) {
            let originCode = appCoffeeURL.string()
            var tempCode = originCode
            
            let oldline1 = "class Preview extends FixPreviewExport"
            let newline1 = "class exports.Preview extends FixPreviewExport"
            tempCode = tempCode.replacingOccurrences(of: oldline1, with: newline1)
            
            let oldline2 = "class Presentation extends FixPresentationExport"
            let newline2 = "class exports.Presentation extends FixPresentationExport"
            tempCode = tempCode.replacingOccurrences(of: oldline2, with: newline2)
            
            let oldline3 = "overrideTimeValue: \"20:21\""
            let newline3 = "overrideTimeValue: \"\(prototypeName.getStatusBarTime())\""
            tempCode = tempCode.replacingOccurrences(of: oldline3, with: newline3)

            let separator = "# Code for development"
            return tempCode.components(separatedBy: separator)[0]
        }

        print("Failed to copy PreviewComponent")
        return ""
    }
    
}
