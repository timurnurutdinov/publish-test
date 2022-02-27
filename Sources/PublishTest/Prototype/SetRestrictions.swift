//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 7/24/21.
//

import Foundation
import Checksum
import Files



enum RestrictionReason: String {
    case internalAPI = "api"
    case temporaryNDA = "temp"
}

enum Status: String, Codable {
    case opened = "opened"
    case closed = "closed"
}


struct PrototypeConfig: Codable {
    var id: Int
    var originName: String
    var date: Date
    var status: Status
    
    static func == (lhs: PrototypeConfig, rhs: PrototypeConfig) -> Bool {
        return lhs.id == rhs.id && lhs.originName == rhs.originName && lhs.date == rhs.date && lhs.status == rhs.status
    }
}





extension Queue {
    mutating func setRestrictions() {
        self.restrictLocally()
        self.saveState()
        self.setFolders()
    }
    
    mutating func restrictLocally() {
        // TODO: remove magic numbers
        self.restrict(byName: "2019-05-08 [abro] Verticals – Swipe 16.framer", tillEnd: true)
        self.allow(byName: "2019-05-18 [utils] Utils – Size.framer")
        self.allow(byName: "2019-05-18 [utils] Temp – One.framer")
    }
    
    func setFolders() {
        self.cleanPrototypesFolder()
        
        let toAdd: [Prototype] = self.prototypes.filter { $0.status == .opened }
        toAdd.enumerated().forEach { $1.addFolder() }
        
        let toRestrict: [Prototype] = self.prototypes.filter { $0.status == .closed }
        toRestrict.enumerated().forEach { $1.addBlankFolder() }
        
    }
}




// Read/Save States
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
                PrototypeConfig(id: $0.id, originName: $0.name.origin, date: $0.folder.modificationDate!, status: $0.status) }
            
            self.setState(nextState)
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let data = try encoder.encode(self.nextState)
            if let jsonString = String(data: data, encoding: .utf8) {
                jsonString.writeFile(configFile, toFolder: toFolder)
            }
            
        } catch { print(error) }
    }
    
}





// Set status
extension Queue {
    
    mutating func restrict(byName name: String, tillEnd: Bool = false, byReason reason: RestrictionReason = RestrictionReason.temporaryNDA) {
        
        let names = self.prototypes.map { $0.name.origin }
        
        if let firstIndex = names.firstIndex(of: name) {
            if tillEnd { self.prototypes[firstIndex...].enumerated().forEach { $1.setStatus(.closed) } }
            else { self.prototypes[firstIndex].setStatus(.closed) }
        }

    }
    
    mutating func allow(byName name: String) {
        let names = self.prototypes.map { $0.name.origin }
        
        if let firstIndex = names.firstIndex(of: name) {
            self.prototypes[firstIndex].setStatus(.opened)
        }
    }

}



// Update
//extension Queue {
//    
//    func logActions(with removeLogOutput: String) {
//        
//        let realActions = self.prototypes.filter { $0.action != .none }
//        let actions = realActions.map { "\($0.name.origin) -> \($0.action.rawValue) (\($0.id))" }
//        let actionsOutput = actions.reduce("") { "\($0)\($1)\n" }
//        actionsOutput.writeFile("actions.txt")
//        
//        if actionsOutput != "" { print("Actions:\n\(removeLogOutput)\(actionsOutput)") }
//    }
//}
