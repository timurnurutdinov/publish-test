//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 10.10.2023.
//


import Foundation
import Files



extension Queue {
    public mutating func updateIcons() {
        self.read()
        
        self.prototypes.reversed().enumerated().forEach { (index, prototype) in
            prototype.updateIcon(withIndex: index)
        }
    }
}

extension Prototype {
    
    func updateIcon(withIndex index: Int) {
        
        let iconIndex = index + 1
        
        do {
            let icons = ["icon-76.png", "icon-120.png", "icon-152.png", "icon-180.png", "icon-192.png"]
            
            try icons.enumerated().forEach { (index, iconName) in
                let iconFile = try File(path: folder.path + "framer/images/" + iconName)
                try iconFile.delete()
                
                let newIcon = try File(path: "~/Documents/Git/publish-test/touchIcons/\(iconIndex)/" + iconName)
                let iconFolder = try Folder(path: folder.path + "framer/images/")
                try newIcon.copy(to: iconFolder)
            }
        }
        catch { print("Failed to update icons for \(self.name.origin)") }
    }
}

