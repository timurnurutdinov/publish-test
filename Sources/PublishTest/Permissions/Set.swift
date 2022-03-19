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
    var url: String
    
    static func == (lhs: PrototypeConfig, rhs: PrototypeConfig) -> Bool {
        return lhs.id == rhs.id && lhs.originName == rhs.originName && lhs.date == rhs.date && lhs.status == rhs.status
    }
}


extension Queue {
    
    mutating func publish() {
        self.cleanFolders()
        
        self.setDynamicURL()
        self.setStaticURL()
        
        self.setFolders()
        
        self.saveState()
        self.saveState(configFile: OutputFolder.prototypesJSON, toFolder: OutputFolder.path)
    }
    
    mutating func setDynamicURL() { self.closeForProduction() }
    func setStaticURL() { self.openForProduction() }
}



extension Queue {
    
    func cleanFolders() {
        do {
            try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.prototypesDynamicFolder).delete()
            try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.prototypesDynamicFolder)
            try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.prototypesStaticFolder).delete()
            try Folder(path: OutputFolder.path).createSubfolderIfNeeded(withName: OutputFolder.prototypesStaticFolder)
        }
        catch { print() }
    }
    
    func setFolders() {
        let toAddDynamic: [Prototype] = self.prototypes.filter { $0.status == .opened }
        toAddDynamic.enumerated().forEach { $1.addFolder() }
        
        let toAddStatic:[Prototype] = self.prototypes.filter { $0.staticURL != "" }
        toAddStatic.enumerated().forEach { $1.addFolderByURL() }
    }
}






