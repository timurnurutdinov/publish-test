//
//  File.swift
//  
//
//  Created by tilllur on 04.09.2022.
//

import Foundation
import Files


public struct URL2000: Codable, Hashable {
    public var urls: String
    
    init(_ urls: String) {
        self.urls = urls
    }
    
    public static func == (lhs: URL2000, rhs: URL2000) -> Bool {
        return lhs.urls == rhs.urls
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(urls)
    }
}


// for Seed
// GENERATE SEEDS?


extension Queue {

//    public static var seedURLJSONPath = "/Users/tilllur/Documents/Git/FramerComponents/dynamic-urls.json"

    public func createSeedURLS() {
        var file: [String] = []
        for _ in 1...2000 { file.append(String.randomURL()) }

        let uniqueUrls = Array(Set(file))
        uniqueUrls.writeFile(withName: "protototyping-queue.txt", separatedBy: "\n")
    }


    public func readSeedURLS() -> String {
        do {
            return try File(path: "/Users/tilllur/Documents/Git/FramerPreviewer/protototyping-queue.txt").string()
        } catch { print(error) }
        return ""
    }

    public mutating func updateSeeds() {
        self.read()
        let urls = readSeedURLS().split(separator: "\n")

        self.prototypes.reversed().enumerated().forEach { (index, prototype) in
            if (index == 0) { print(prototype.name.origin) }
            
            prototype.json.seed = String(urls[index])
        }
    }
    
    public mutating func updateSeed(forNewPrototype prototype: Prototype) {
        let urls = readSeedURLS().split(separator: "\n")
        
        if self.prototypes.count > 1 {
            let prevPrototype = self.prototypes[1]
            let prevJSONSeed = prevPrototype.json.seed
            
            if let prevIndex = urls.firstIndex(of: String.SubSequence(prevJSONSeed)) {
                print("Index of \(prevJSONSeed) is: \(prevIndex)")
                let newIndex = prevIndex + 1
                prototype.json.seed = String(urls[newIndex])
                prototype.saveJSON()
                
                var defaultName = prototype.name.origin
                var newName = prototype.name.origin
                
                if defaultName.hasSuffix(".framer") {
                    newName = defaultName.replacingOccurrences(of: ".framer", with: String(newIndex) + ".framer", options: .backwards, range: nil)
                }
                
                do {
                    try prototype.folder.rename(to: newName)
                    prototype.name = Name(prototype.folder.name)
                } catch { print("Failed to rename new Prototype")}
            }
        }
        else { print("Zero queue error. Cant get URL for seed") }
        
    }

}
