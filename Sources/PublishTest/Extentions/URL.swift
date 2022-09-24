//
//  File 2.swift
//  
//
//  Created by Timur Nurutdinov on 2/4/21.
//

import Foundation
import Files

import SwiftUI

//import

extension URL {
    func lines() -> Int {
        do { return try File(path: self.path).lines() }
        catch { print("🛑 Failed to count lines in app.coffee") }
        return 0
    }
    
    func string() -> String {
        do { return try File(path: self.path).readAsString() }
        catch { print("🛑 Failed to get string from app.coffee") }
        return ""
    }
    
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }

        self = url
    }
    
    public func copy(toFolder path: String) -> URL {
//        let listFolder = try Folder(path: toFolder).createSubfolderIfNeeded(withName: toFolder)
        do {
            let file = try File(path: self.path)
            let folder = try Folder(path: "\(path)images/")
            let fullName = self.path.fileName() + "." + self.path.fileExtension()
            if (folder.containsFile(named: fullName)) {
                try folder.files.enumerated().forEach { (index, file) in
                    if (file.name == fullName) {
                        try file.delete()
                    }
                }
            }
            try file.copy(to: folder)
            
        } catch { print() }
        
        return self
    }
    
    
    // TODO: Change location
    public func createFramerCodeFromImage() -> String {
        
        if let img = NSImage(contentsOf: self) {
            let cleanLastPathComponent = "\(URL(string: self.lastPathComponent)!.deletingPathExtension())".camelized
            
            if (URL(string: cleanLastPathComponent) == nil) { return "" }
            
            let code1 = "\(URL(string: cleanLastPathComponent)!.deletingPathExtension()) = new Layer\n"
            let code2 = "\twidth: \(img.size.width)\n"
            let code3 = "\theight: \(img.size.height)\n"
            let code4 = "\timage: \"images/\(self.lastPathComponent)\"\n"
            
            let code = code1 + code2 + code3 + code4
            
            return code
        }
        return ""
    }
    
    // file:///Users/tilllur/Desktop/Screenshot%202022-07-17%20at%2015.22.33.png
    
//    func copy(toFolder: String, renameTo newName: String) {
//        do {
//            let listFolder = try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: toFolder)
//            let originFolder = try Folder(path: self.folder.path)
//
//            let newFolder = try originFolder.copy(to: listFolder)
//
//            if !newName.isEmpty {
//                try newFolder.rename(to: newName, keepExtension: false)
//                self.updateTitle(in: newFolder)
//                self.updateIcon(in: newFolder)
//            }
//
//
//        } catch { print() }
//    }
}
