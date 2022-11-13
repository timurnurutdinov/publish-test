//
//  File.swift
//  
//
//  Created by tilllur on 02.11.2022.
//

import Foundation
import Files

extension Prototype {
    
    public func fixTree() {
        do {
//            print(self.folder.path)
//            print(self.folder.path + "app.coffee")
//            let appCoffeeURL = URL(string: self.folder.path + "app.coffee")
//            print(self.folder.url)
//            print(appCoffeeURL)
            
            try Folder(path: self.folder.path).files.enumerated().forEach { (i, file) in
                if (file.name == "app.coffee") {
                    
                    let originCode = file.url.string()
                    let newCode = self.fixNamesForTree(originCode)
                    
                    try file.delete()
                    newCode.writeFile("app.coffee", toFolder: self.folder.path)
                }
            }
        }
        catch {
            print("FAILED TREE PRINT")
        }
    }
    
    
    
    func fixNamesForTree(_ code: String) -> String {
        
        let lines = code.split(separator: "\n", omittingEmptySubsequences: false)
        var newText: String = ""
        
        lines.enumerated().forEach { (index, line) in
            newText += line
            newText += "\n"
            
            if (!line.contains("{")) {
                if (line.contains("= new Layer") || line.contains("= new TextLayer") || line.contains("= new ScrollComponent") || line.contains("= new PageComponent")) {
                    let layerNameWithTabs = line.components(separatedBy: " = ")[0]
                    let layerName = layerNameWithTabs.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    let additionalLine = "\t" + layerNameWithTabs.components(separatedBy: layerName)[0] + "name: \"" + layerName + "\"\n"
                    
                    newText += additionalLine
                }

            }
            
        }
        
        print(newText)
        
        return newText
    }
    
        
//    func appleFixes(for file: File) -> String {
//        print(file)
//        print("asdasd")
//        print(URL(string: file.path))
//        if let appCoffeeURL = URL(string: file.path) {
//
//            let originCode = appCoffeeURL.string()
//
//            let lines = originCode.split(separator: "\n")
//            print("SDD")
//            print(lines)
//
//
//            lines.map {
//                print($0)
//                if ($0.contains("new Layer")) {
//                    print(index)
//                }
//            }
//
//        }
//
//        print("WTF")
//        return ""
//    }

}
