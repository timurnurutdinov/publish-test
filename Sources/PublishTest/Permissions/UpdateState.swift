//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 3/1/22.
//

import Foundation
import Files


extension Queue {
    
    mutating func readState(configFile:String = "config.json",
              fromFolder: String = "~/Documents/Git/publish-test/Content/") {
        print("Reading JSON State")
        do {
            let file = try Folder(path: fromFolder).file(at: configFile)
            let decoder = JSONDecoder()

            do { self.prevState = try decoder.decode([PrototypeConfig].self, from: file.testData())
            } catch { print("Failed to decode JSON State") }
            
        }
        catch { print(error) }
    }
    
    
    mutating func saveState(configFile:String = "config.json", toFolder: String = "~/Documents/Git/publish-test/Content/") {
        do {
            
            let nextState = self.prototypes.map {
                PrototypeConfig(id: $0.id, originName: $0.name.origin, date: $0.folder.modificationDate!, status: $0.status, url: $0.url)
            }
            
            self.setState(nextState)
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let data = try encoder.encode(self.nextState)
            if let jsonString = String(data: data, encoding: .utf8) { jsonString.writeFile(configFile, toFolder: toFolder) }
            
        } catch { print(error) }
    }
        
}









enum IntBoolforJSON: Int, Codable {
    case opened = 1
    case closed = 0
}

struct PrototypeJSON: Codable {
    var i: Int // index
    var t: String // title
    var p: String // project title
    var year: String // year
    var fav: IntBoolforJSON // fav
    var s: IntBoolforJSON // status
}

extension Queue {
    mutating func savePrototypesPageJSON(configFile:String = "m.json", toFolder: String = OutputFolder.path) {
        do {
            
            let minimalState = self.prototypes.map {
                PrototypeJSON(i: $0.id, t: $0.name.title, p: $0.name.project, year: "2021", fav: .closed, s: .closed)
            }
            
            
            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted
            
            let data = try encoder.encode(minimalState)
            if let jsonString = String(data: data, encoding: .utf8) { jsonString.writeFile(configFile, toFolder: toFolder) }
            
        } catch { print(error) }
    }
}
