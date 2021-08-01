//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 7/24/21.
//

import Foundation
import Checksum
import Files

struct PrototypeConfig: Codable {
    var id: Int
    var originName: String
    var date: Date
    var status: Status
}


extension Queue {
    
    mutating func applyRestrictionRules() {
        return
        self.restrict(byName: "2021-01-24 [pp] Geo View – Arrow Playground.framer", tillEnd: true)
        self.restrict(byName: "2018-10-10 [abro] Menu – Open 11.framer")
        
        self.allow(byName: "2019-05-18 [utils] Utils – Size.framer")
        self.allow(byName: "2019-05-18 [ios] Purify – Swipe.framer")
    }
    
    mutating func setRestrictions() {
        self.applyRestrictionRules()
        let allowedPrototypes = self.prototypes.filter { $0.status == .opened }
    }
    
    
    
    mutating func readState(configFile:String = "config.json",
              fromFolder: String = "~/Documents/Git/publish-test/Content/") {
        print("State Read")
        do {
            let file = try Folder(path: fromFolder).file(at: configFile)
            let decoder = JSONDecoder()

            do { self.prevState = try decoder.decode([PrototypeConfig].self, from: file.testData())
            } catch { print("Failed to decode JSON") }
            
        }
        catch { print(error) }
    }
    
    
    
    func saveState(configFile:String = "config.json", toFolder: String = "~/Documents/Git/publish-test/Content/") {
        do {
            let configSamples = self.prototypes.map { PrototypeConfig(id: $0.id, originName: $0.name.origin, date: $0.folder.modificationDate!, status: $0.status) }
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let data = try encoder.encode(configSamples)
            if let jsonString = String(data: data, encoding: .utf8) {
                jsonString.writeFile(configFile, toFolder: toFolder)
            }
            
        } catch { print(error) }
        
    }
    
    
}






// Set status
extension Queue {
    
    mutating func restrict(byName name: String, tillEnd: Bool = false) {
        
        let names = self.prototypes.map { $0.name.origin }
        
        if let firstIndex = names.firstIndex(of: name) {
            if tillEnd { self.prototypes[firstIndex...].enumerated().forEach { $1.status = .closed } }
            else { self.prototypes[firstIndex].status = .closed }
        }

    }
    
    mutating func allow(byName name: String) {
        let names = self.prototypes.map { $0.name.origin }
        
        if let firstIndex = names.firstIndex(of: name) {
            self.prototypes[firstIndex].status = .opened
        }
    }

}
