//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 3/1/22.
//

import Foundation
import Files

// Set status

extension Prototype {
    func restrict(byReason reason: Status = .nda) {
        self.status = .nda
    }
    func allow() {
        self.status = .opened
    }
    
    func feature() {
        self.featured = .starred
    }
}



//extension Queue {
//
//    mutating func restrict(byName name: String, tillEnd: Bool = false, byReason reason: Status = .nda) {
//        let names = self.prototypes.map { $0.name.origin }
//
//        if let firstIndex = names.firstIndex(of: name) {
//            if tillEnd { self.prototypes[firstIndex...].enumerated().forEach { $1.restrict(byReason: reason) } }
//            else { self.prototypes[firstIndex].restrict(byReason: reason) }
//        }
//
//        else { print("Failed to restrict \(name)") }
//    }
//
//    mutating func allow(byName name: String, tillName secondName: String = "") {
//        let names = self.prototypes.map { $0.name.origin }
//
//        if let firstIndex = names.firstIndex(of: name) {
//
//            if (secondName == "") { self.prototypes[firstIndex].allow() }
//            else if let secondIndex = names.firstIndex(of: secondName) {
//                self.prototypes[firstIndex...secondIndex].enumerated().forEach { $1.allow() }
//            }
//            else {
////                self.prototypes[firstIndex].status = .opened
//                print("Gap rules failed for s: \(name), f: \(name)")
//            }
//        }
//        else { print("Failed to allow with name \(name)") }
//    }
//
//
//
//    func allow(byName name: String, withURL url: String) {
//        let names = self.prototypes.map { $0.name.origin }
//        if let firstIndex = names.firstIndex(of: name) {
//            self.prototypes[firstIndex].setStaticURL(url)
//        }
//        else { print("Failed to allow with URL \(name)") }
//    }
//
//    func feature(byName name: String) {
//        let names = self.prototypes.map { $0.name.origin }
//        if let firstIndex = names.firstIndex(of: name) {
//            self.prototypes[firstIndex].featured = .starred
//        }
//        else { print("Failed to feature \(name)") }
//    }
//
//}





extension Prototype {
    
    func copy(toFolder: String, renameTo newName: String) {
        do {
            let listFolder = try Folder(path: SiteFolder.path).createSubfolderIfNeeded(withName: toFolder)
            let originFolder = try Folder(path: self.folder.path)

            let newFolder = try originFolder.copy(to: listFolder)
            
            if !newName.isEmpty {
                try newFolder.rename(to: newName, keepExtension: false)
                self.updateTitle(in: newFolder)
                self.updateIcon(in: newFolder)
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
    
    func getIndex() -> String {
        if (self.iconIndex > 0) { return "\(self.iconIndex)"}
        return ""
    }
    
    func updateIcon(in folder: Folder) {
        if (self.iconIndex <= 0) {
            print("Icon update skipped for \(self.name.origin)")
            return
        }
        
        do {
            let icons = ["icon-76.png", "icon-120.png", "icon-152.png", "icon-180.png", "icon-192.png"]
            
            try icons.enumerated().forEach { (index, iconName) in
//                print("?")
                let iconFile = try File(path: folder.path + "framer/images/" + iconName)
//                print("??")
                try iconFile.delete()
//                print("???")
                
//                print ("~/Documents/Git/FramerComponents/touchIcons/\(self.iconIndex)/" + iconName)
                let newIcon = try File(path: "~/Documents/Git/FramerComponents/touchIcons/\(self.iconIndex)/" + iconName)
//                print("????")
                let iconFolder = try Folder(path: folder.path + "framer/images/")
//                print("?????")
                try newIcon.copy(to: iconFolder)
//                print("??????")
            }
        }
        catch { print("Failed to update icons for \(self.name.origin)") }
    }

}

