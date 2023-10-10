//
//  File.swift
//  
//
//  Created by tilllur on 04.09.2022.
//

import Foundation
import Files



public enum TJSON: String {
    case URLStatic = "static"
    case URLDynamic = "dynamic"
    case Tag = "tag"
    case Star = "star"
}

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
    
    public func readTag() { read(json: "tag.json", type: .Tag) }
    public func saveTag() { save(json: "tag.json", type: .Tag) }
    
    public func readStar() { read(json: "star.json", type: .Star) }
    public func saveStar() { save(json: "star.json", type: .Star) }
    
    public func readURLStatic() { read(json: "static.json", type: .URLStatic) }
    public func saveURLStatic() { save(json: "static.json", type: .URLStatic) }
    
    public func readURLDynamic() { read(json: "seed.json", type: .URLDynamic) }
    public func saveURLDynamic() { save(json: "seed.json", type: .URLDynamic) }
    
    
    
    public func read(json:String = "seed.json", type: TJSON) {
        
        do {

            let seedFolder = try Folder(path: folder.path)
            try seedFolder.createSubfolderIfNeeded(withName: "tilllur")
            
            let file = try Folder(path: folder.path + "tilllur/").file(at: json)
            let decoder = JSONDecoder()

            do {
                let tempData = try decoder.decode(Seed.self, from: file.testData())
                if (type == .URLDynamic) { self.dynamicSeed = tempData }
                else if (type == .URLStatic) { self.staticSeed = tempData }
//                else if (type == .Tag) { self.staticSeed = tempData }
                else {  }
            } catch { print("Failed to decode JSON State") }

        }
        catch { print(error) }
    }
    

    public func save(json:String = "seed.json", type: TJSON) {
        do {
            
            let seedFolder = try Folder(path: folder.path)
            try seedFolder.createSubfolderIfNeeded(withName: "tilllur")
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            var seed = Seed(url: "")
            if (type == .URLDynamic) { seed = self.dynamicSeed }
            else if (type == .URLStatic) { seed = self.staticSeed }
            else {  }
            
            let data = try encoder.encode(seed)
            if let jsonString = String(data: data, encoding: .utf8) { jsonString.writeFile(json, toFolder: folder.path + "tilllur/") }

        } catch { print(error) }
    }
    
    
}




