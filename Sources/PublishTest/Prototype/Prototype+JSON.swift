//
//  File.swift
//  
//
//  Created by tilllur on 04.09.2022.
//

import Foundation
import Files



public struct PrototypeJSON: Codable, Hashable {
    public var seed: String
    public var url: String
    public var open: Bool
    public var star: Bool
}


extension Prototype {
    
    
    public func readJSON() {
        
        do {

            let seedFolder = try Folder(path: folder.path)
            try seedFolder.createSubfolderIfNeeded(withName: "tilllur")
            
            let file = try Folder(path: folder.path + "tilllur/").file(at: "tilllur.json")
            let decoder = JSONDecoder()

            do {
                self.json = try decoder.decode(PrototypeJSON.self, from: file.testData())
 
            } catch { print("Failed to decode JSON State") }

        }
        catch { print(error) }
    }
    
    public func saveJSON() {
        do {
            
            let seedFolder = try Folder(path: folder.path)
            try seedFolder.createSubfolderIfNeeded(withName: "tilllur")
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let data = try encoder.encode(self.json)
            if let jsonString = String(data: data, encoding: .utf8) { jsonString.writeFile("tilllur.json", toFolder: folder.path + "tilllur/") }

        } catch { print(error) }
    }
}










