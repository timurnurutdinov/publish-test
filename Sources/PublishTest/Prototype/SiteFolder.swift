//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 3/1/22.
//

import Foundation
import Files



extension Prototype {
    
    func copy(toFolder: String, renameTo newName: String) {
        do {
            let listFolder = try Folder(path: toFolder)
            let originFolder = try Folder(path: self.folder.path)

            let newFolder = try originFolder.copy(to: listFolder)
            newFolder.removeSeed()
            
            if !newName.isEmpty {
                try newFolder.rename(to: newName, keepExtension: false)
                self.updateTitle(in: newFolder)
            }
            
            
            
            
        } catch { print() }
    }
    
        
    func updateTitle(in folder: Folder) {
        do {
            let fileURL = URL(fileURLWithPath: folder.path + "framer/framer.generated.js")
            let separators = ["\"documentTitle\":\"", "\"};"]
            
            let content = fileURL.string()
            
            var newTitle = self.name.title.replacingOccurrences(of: ".framer", with: "")
            if (self.name.title == "") { newTitle = "Blank" }
            
            let parts = content.components(separatedBy: separators[0])
            if (parts.count == 2) {
                let nextParts = parts[1].components(separatedBy: separators[1])
                let updatedContent = parts[0] + separators[0] + newTitle + separators[1] + nextParts[1]
                
                let framerFile = try File(path: folder.path + "framer/framer.generated.js")
                try framerFile.delete()
                
                updatedContent.writeFile("framer.generated.js", toFolder: folder.path + "framer/")
            }
            
        }
        catch { print("Failed to update title for \(self.name.origin)") }
    }
    
    
//    func getIndex() -> String {
//        if (self.iconIndex > 0) { return "\(self.iconIndex)"}
//        return ""
//    }
    
    
//    func updateIcon(in folder: Folder) {
//        if (self.iconIndex <= 0) {
//            print("Icon update skipped for \(self.name.origin)")
//            return
//        }
//
//        do {
//            let icons = ["icon-76.png", "icon-120.png", "icon-152.png", "icon-180.png", "icon-192.png"]
//
//            try icons.enumerated().forEach { (index, iconName) in
//                let iconFile = try File(path: folder.path + "framer/images/" + iconName)
//                try iconFile.delete()
//
//                let newIcon = try File(path: "~/Documents/Git/FramerComponents/touchIcons/\(self.iconIndex)/" + iconName)
//                let iconFolder = try Folder(path: folder.path + "framer/images/")
//                try newIcon.copy(to: iconFolder)
//            }
//        }
//        catch { print("Failed to update icons for \(self.name.origin)") }
//    }

}

