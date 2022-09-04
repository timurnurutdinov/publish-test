//
//  File.swift
//  
//
//  Created by tilllur on 17.06.2022.
//

import Foundation
import Files



extension Prototype {
    
    
    func getPermissionByTag() {
        
        do {
            let resourceValues = try self.folder.url.resourceValues(forKeys: [.tagNamesKey])
            
            if let tags = resourceValues.tagNames {
                if (tags.contains("Private")) {
                    self.restrict()
                }
                else if (tags.contains("Public")) {
                    self.allow()
                }
                else {
                    self.restrict()
                }
                
                
                if (tags.contains("Favourite")) {
                    self.feature()
                }
            }

        } catch {
            print(error)
        }
    }
    
    
    func updateTags() {
        var url = self.folder.url
        
        do {
            let resourceValues = try url.resourceValues(forKeys: [.tagNamesKey])
            var tags : [String]
            if let tagNames = resourceValues.tagNames {
                tags = tagNames
            } else {
                tags = [String]()
            }
            
            if (self.staticSeed.url != "") {
                let linkID = "Link"
                if !tags.contains(linkID) {
                    tags += ["Link"]
                    try (url as NSURL).setResourceValue(tags, forKey: .tagNamesKey)
                }
            }
            

        } catch {
            print(error)
        }
    }
    
}








