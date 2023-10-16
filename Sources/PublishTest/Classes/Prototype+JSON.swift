//
//  File.swift
//  
//
//  Created by tilllur on 04.09.2022.
//

import Foundation
import Files



extension Prototype {
    public func saveJSON() { self.json.save(json: self.json, withName: "tilllur.json", toFolder: self.jsonFolder()) }
    public func readJSON() -> PrototypeJSON? {
        if let prototypeWithValidJSON = PrototypeJSON.read(file: self.jsonFile()) { return prototypeWithValidJSON }
        return nil
    }
}

public struct PrototypeJSON: Codable, Hashable, ItemJSON {
    
    public typealias DataType = PrototypeJSON
    
    public var seed: String
    public var url: String
    public var open: Bool
    public var star: Bool
    
    init(seed: String, url: String, open: Bool, star: Bool) { self.seed = seed; self.url = url; self.open = open; self.star = star }
    init(jsonFile: File?) {
        if let prototypeWithValidJSON = PrototypeJSON.read(file: jsonFile) { self = prototypeWithValidJSON }
        else { self = PrototypeJSON(seed: "none", url: "", open: false, star: false) }
    }
}









public protocol ItemJSON {
    associatedtype DataType: Codable

    static func read(file: File?) -> DataType?
    func save(json: DataType, withName jsonName: String, toFolder folder: Folder?)
}

extension ItemJSON {
    
    public static func read(file: File?) -> DataType? {
        do {
            
            if let file = file { return try JSONDecoder().decode(DataType.self, from: file.readData())}
            else {
                print("File \(String(describing: file)) does't exist")
                return nil
            }
            
        } catch {
            print("Error decoding JSON:")
            return nil
            
        }
    }
    
    public func save(json: DataType, withName jsonName: String, toFolder folder: Folder?) {
        do {
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let data = try encoder.encode(json)
            if let jsonString = String(data: data, encoding: .utf8) {
                if let unwrappedFolder = folder {
                    jsonString.writeFile(jsonName, toFolder: unwrappedFolder.path)
                }
                
            }

        } catch { print(error) }
    }
}



extension Prototype {
    
    public func jsonFolder() -> Folder? {
        do { return try Folder(path: folder.path).createSubfolderIfNeeded(withName: "tilllur") }
        catch {
            print("Failed to read jsonFolder for \(self.name.origin)")
            return nil
        }
    }
    
    public func jsonFile(_ fileName: String = "tilllur.json") -> File? {
        do {
            try Folder(path: folder.path).createSubfolderIfNeeded(withName: "tilllur")
            return try Folder(path: folder.path + "tilllur/").file(at: fileName)
        }
        catch {
            print("Failed to read jsonFile for \(self.name.origin)")
            return nil
        }
    }
}

