//
//  File.swift
//  
//
//  Created by tilllur on 04.09.2022.
//

import Foundation
import Files



extension Prototype {
    public func saveJSON() {
        self.json.save(json: self.json, withName: "tilllur.json", toFolder: self.jsonFolder())
    }
    
    public func readJSON() -> PrototypeJSON {
        return PrototypeJSON.read(file: self.jsonFile())
    }
}

public struct PrototypeJSON: Codable, Hashable, ItemJSON {
    public typealias DataType = PrototypeJSON
    
    public var seed: String
    public var url: String
    public var open: Bool
    public var star: Bool
    
    init(seed: String, url: String, open: Bool, star: Bool) { self.seed = seed; self.url = url; self.open = open; self.star = star }
    init(jsonFile: File) { self = PrototypeJSON.read(file: jsonFile) }
}





// Generic JSON


// structure

// tilllur.json
// read folder

// write folder


public protocol ItemJSON {
    associatedtype DataType: Codable

    static func read(file: File?) -> DataType
    func save(json: DataType, withName jsonName: String, toFolder folder: Folder)
}

extension ItemJSON {
    
    
    public static func read(file: File?) -> DataType {
        do {
            
            if let file = file { return try JSONDecoder().decode(DataType.self, from: file.readData())}
            else { fatalError("File \(String(describing: file)) does't exist") }
            
        } catch { fatalError("Error decoding JSON: \(error)") }
    }
    
    public func save(json: DataType, withName jsonName: String, toFolder folder: Folder) {
        do {
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let data = try encoder.encode(json)
            if let jsonString = String(data: data, encoding: .utf8) { jsonString.writeFile(jsonName, toFolder: folder.path) }

        } catch { print(error) }
    }
}



extension Prototype {
    
    
    public func jsonFolder() -> Folder {
        do { return try Folder(path: folder.path).createSubfolderIfNeeded(withName: "tilllur") }
        catch { fatalError("jsonFolder read failed") }
    }
    
    public func jsonFile(_ fileName: String = "tilllur.json") -> File {
        do {
            try Folder(path: folder.path).createSubfolderIfNeeded(withName: "tilllur")
            return try Folder(path: folder.path + "tilllur/").file(at: fileName)
        }
        catch { fatalError("jsonFolder read failed") }
    }
}

