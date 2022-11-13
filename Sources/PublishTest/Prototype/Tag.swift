//
//  File.swift
//  
//
//  Created by tilllur on 17.06.2022.
//

import Foundation
import Files


extension Prototype {
    func restrict(byReason reason: Status = .nda) { self.status = .nda }
    public func allow() { self.status = .opened }
    func feature() { self.featured = .starred }
}

enum TagName: String {
    case green = "Public"
    case red = "Private"
    case yellow = "Favourite"
    case violet = "Link"
    case unknown = "Dev"
}


extension Prototype {
    
    public func setPrivateTag() {
        self.setTag(to: TagName.red)
        self.removeTag(TagName.green)
        self.getPermissionByTag()
    }
    
    public func setPublicTag() {
        self.setTag(to: TagName.green)
        self.removeTag(TagName.red)
        self.getPermissionByTag()
    }
    
    public func clearTags() {
        self.removeTag(TagName.green)
        self.removeTag(TagName.red)
        self.getPermissionByTag()
    }
    
    
    public func toggleFeaturedTag() {
        if (self.featured == Featured.starred) { self.removeTag(TagName.yellow) }
        else { self.setTag(to: TagName.yellow) }
        
        self.getPermissionByTag()
    }
    
//    public func setFavouriteTag() {
//        self.setTag(to: TagName.yellow)
//        self.getPermissionByTag()
//    }
}



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
        let url = self.folder.url
        
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




extension Prototype {
    
    func removeTag(_ tagName: TagName = TagName.green) {
        let url = self.folder.url
        
        do {
            let resourceValues = try url.resourceValues(forKeys: [.tagNamesKey])
            
            var tags : [String]
            if let tagNames = resourceValues.tagNames { tags = tagNames }
            else { tags = [String]() }
            
            if tags.contains(tagName.rawValue) {
                tags = tags.filter { $0 != tagName.rawValue }
                try (url as NSURL).setResourceValue(tags, forKey: .tagNamesKey)
            }
            

        } catch {
            print(error)
        }
    }
    
    
    
    func setTag(to tagName: TagName = TagName.red) {
        let url = self.folder.url
        
        do {
            let resourceValues = try url.resourceValues(forKeys: [.tagNamesKey])
            var tags : [String]
            if let tagNames = resourceValues.tagNames {
                tags = tagNames
            } else {
                tags = [String]()
            }
            
            if !tags.contains(tagName.rawValue) {
                tags += [tagName.rawValue]
                try (url as NSURL).setResourceValue(tags, forKey: .tagNamesKey)
            }
            

        } catch {
            print(error)
        }
    }
}






