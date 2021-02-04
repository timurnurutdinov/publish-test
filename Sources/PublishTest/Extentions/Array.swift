//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 2/4/21.
//

import Foundation
import Files

extension Array where Element == String {
    func writeFile(withName name:String = "blank.txt", separatedBy separator:String = ",") {
        do {
            let folder = try Folder(path: "~/Desktop/output/")
            let file = try folder.createFile(named: name)
            try file.write(self.joined(separator: separator))
            
        }
        catch { }
    }
}
