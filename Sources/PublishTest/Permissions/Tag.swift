//
//  File.swift
//  
//
//  Created by tilllur on 17.06.2022.
//

import Foundation

extension Prototype {
    
    func getPermissionWithTag() {
        
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
            }

        } catch {
            print(error)
        }
    }
    
}