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
}

public struct PrototypeJSON: Codable, Hashable, ItemJSON {
    public typealias DataType = PrototypeJSON
    
    public var seed: String
    public var url: String
    public var open: Bool
    public var star: Bool
    
}


//public struct PrototypeJSONConfig {
//    public var json: any ItemJSON
//    public var fileName: String = "tilllur.json"
//    public var jsonFolder: Folder
//    
////    public func save() {
////        json.save(json: self.json, withName: fileName, toFolder: self.jsonFolder)
////    }
//    
////    public func read() {
////        self.json =
////    }
//}
//









// Generic JSON


// structure

// tilllur.json
// read folder

// write folder


public protocol ItemJSON {
    associatedtype DataType: Codable

    mutating func read(file: File?) -> DataType
    func save(json: DataType, withName jsonName: String, toFolder folder: Folder)
}

extension ItemJSON {
    
    
    public mutating func read(file: File?) -> DataType {
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
    
    public func jsonFile(_ fileName: String = "tilllur.json") -> File? {
        do {
            try Folder(path: folder.path).createSubfolderIfNeeded(withName: "tilllur")
            return try Folder(path: folder.path + "tilllur/").file(at: fileName)
        }
        catch { print("jsonFolder read failed") }
        return nil
    }
}



//extension Prototype {
//
//    public func readJSON() {
//
//        do {
//
//            let seedFolder = try Folder(path: folder.path)
//            try seedFolder.createSubfolderIfNeeded(withName: "tilllur")
//
//            let file = try Folder(path: folder.path + "tilllur/").file(at: "tilllur.json")
//            let decoder = JSONDecoder()
//
//            do {
//                self.json = try decoder.decode(PrototypeJSON.self, from: file.readData())
//
//            } catch { print("Failed to decode JSON State") }
//
//        }
//        catch { print(error) }
//    }
//
//    public func saveJSON() {
//        do {
//
//            let seedFolder = try Folder(path: folder.path)
//            try seedFolder.createSubfolderIfNeeded(withName: "tilllur")
//
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted
//
//            let data = try encoder.encode(self.json)
//            if let jsonString = String(data: data, encoding: .utf8) { jsonString.writeFile("tilllur.json", toFolder: folder.path + "tilllur/") }
//
//        } catch { print(error) }
//    }
//}










