//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 2/4/21.
//

import Foundation
import Files


extension Array where Element == Double {
    func writeFile(withName name:String = "blank.txt", separatedBy separator:String = ",") {
        let stringArray = self.map { String($0.rounded(toPlaces: 3)) }
        stringArray.writeFile(withName: name, separatedBy: separator)
    }
}

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
