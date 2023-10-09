//
//  File.swift
//  
//
//  Created by tilllur on 04.09.2022.
//

import Foundation
import Files


public struct Seed: Codable, Hashable {
    public var url: String
    
    public static func == (lhs: Seed, rhs: Seed) -> Bool {
        return (lhs.url == rhs.url)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(url)
    }
}



extension Prototype {
    
    public func readSeedStatic(configFile:String = "static.json") {
        readSeed(configFile: configFile, dynamic: false)
    }
    
    public func saveSeedStatic(configFile:String = "static.json") {
        saveSeed(configFile: configFile, dynamic: false)
    }
    
    
    
    public func readSeed(configFile:String = "seed.json", dynamic: Bool = true) {
        
        do {

            let seedFolder = try Folder(path: folder.path)
            try seedFolder.createSubfolderIfNeeded(withName: "tilllur")
            
            let file = try Folder(path: folder.path + "tilllur/").file(at: configFile)
            let decoder = JSONDecoder()

            do {
                let seed = try decoder.decode(Seed.self, from: file.testData())
                if (dynamic) { self.dynamicSeed = seed }
                else { self.staticSeed = seed }
            } catch { print("Failed to decode JSON State") }

        }
        catch { print(error) }
    }
    

    public func saveSeed(configFile:String = "seed.json", dynamic: Bool = true) {
        do {
            
            let seedFolder = try Folder(path: folder.path)
            try seedFolder.createSubfolderIfNeeded(withName: "tilllur")
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            var seed = Seed(url: "")
            if (dynamic) { seed = self.dynamicSeed }
            else { seed = self.staticSeed }
            
            let data = try encoder.encode(seed)
            if let jsonString = String(data: data, encoding: .utf8) { jsonString.writeFile(configFile, toFolder: folder.path + "tilllur/") }

        } catch { print(error) }
    }
    
    
}


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

