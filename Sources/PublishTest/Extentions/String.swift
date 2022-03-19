//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 2/4/21.
//

import Foundation
import Files

extension String {

    func fileName() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }

    func fileExtension() -> String {
        return URL(fileURLWithPath: self).pathExtension
    }
    
    func matchingStrings(regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
        let nsString = self as NSString
        let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).map {
                result.range(at: $0).location != NSNotFound
                    ? nsString.substring(with: result.range(at: $0))
                    : ""
            }
        }
    }
    
    
    func writeTempFile(_ name:String = "blank.txt") {
        self.writeFile(name, toFolder: "~/Desktop/output/")
    }
    
    func writeTempFile(_ name:String = "blank.txt", toFolder path:String) {
        self.writeFile(name, toFolder: "~/Desktop/output/" + path)
    }
    
    func writeFile(_ name:String = "blank.txt", toFolder path:String) {
        do {
            let folder = try Folder(path: path)
            let file = try folder.createFile(named: name)
            try file.write(self)
        }
        catch {
            print("🛑 Failed to write file to \(path)")
        }
    }
    
}



extension String {
    static func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyz"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    static func randomStringForURL() -> String {
        return self.randomString(length: 8)
    }
}
