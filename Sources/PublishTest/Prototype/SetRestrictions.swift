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

enum Action: String {
    // nothing to remove
    case none = "already updated"
    case addAndOpen = "add/open"
    case addAndClose = "add/close"
    
    // remove older version
    case updateAndOpen = "update/open"
    case updateAndClose = "update/close"
    
    // just remove
    case remove = "remove"
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






// Most Valuable
extension Queue {
    mutating func setRestrictions() {
        self.restrictLocally()
        
        self.updateActions()
        self.setActions()
    }
    
    mutating func restrictLocally() {
        // TODO: remove magic numbers
        self.restrict(byName: "2019-05-08 [abro] Verticals – Swipe 16.framer", tillEnd: true)
        self.allow(byName: "2019-05-18 [utils] Utils – Size.framer")
    }
}




extension Queue {
    
    mutating func updateActions() {
        self.saveState()
        let pairs = zip(self.prevState, self.nextState).map { $0 }
        
        pairs.enumerated().forEach { index, pair in
            if pair.0 == pair.1 { self.prototypes[index].setAction(.none) }
            else {
                if pair.1.status == .opened { self.prototypes[index].setAction(.updateAndOpen) }
                else { self.prototypes[index].setAction(.updateAndClose) }
            }
        }
        
    }
    
    
    mutating func setActions() {
        var doneString = ""
        
        if self.nextState.count <= self.prevState.count {
            
            self.prevState[self.nextState.count...].enumerated().forEach {
                removeFolder(withID: $1.id)
                doneString += "\($1.originName) -> \(Action.remove) (\($1.id))\n"
            }
        }
        
        else if self.nextState.count > self.prevState.count {
            
            self.prototypes[self.prevState.count...].enumerated().forEach {
                if $1.status == .opened { $1.setAction(.addAndOpen) }
                else { $1.setAction(.addAndClose) }
            }
        }
        
        self.setFolders()
        self.logActions(with: doneString)
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



// Log
extension Queue {
    
    func logActions(with removeLogOutput: String) {
        
        let realActions = self.prototypes.filter { $0.action != .none }
        let actions = realActions.map { "\($0.name.origin) -> \($0.action.rawValue) (\($0.id))" }
        let actionsOutput = actions.reduce("") { "\($0)\($1)\n" }
        actionsOutput.writeFile("actions.txt")
        
        if actionsOutput != "" { print("Actions:\n\(removeLogOutput)\(actionsOutput)") }
    }
}
