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
            prototype.dynamicSeed = Seed(url: String(urls[index]))
            prototype.saveSeed()
        }
    }
    
}
