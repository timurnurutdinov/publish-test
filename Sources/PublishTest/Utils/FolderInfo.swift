//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 8/1/21.
//

import Foundation
import Files

struct FolderInfo {
    
    static func read() {
        let prototypePath = "~/Desktop/plus.framer"
        
        do {
            let folder = try Folder(path: prototypePath)
//            Prototype.init(withFolder: folder)
            
        } catch { }
    }
}

