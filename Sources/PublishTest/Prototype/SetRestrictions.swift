//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 7/24/21.
//

import Foundation
import Checksum

extension Queue {
    
    mutating func applyRestrictionRules() {
        self.restrict(byName: "2021-01-24 [pp] Geo View – Arrow Playground.framer", tillEnd: true)
        self.restrict(byName: "2018-10-10 [abro] Menu – Open 11.framer")
        
        self.allow(byName: "2019-05-18 [utils] Utils – Size.framer")
        self.allow(byName: "2019-05-18 [ios] Purify – Swipe.framer")
    }
    
    mutating func setRestrictions() {
        readConfig()
//        self.applyRestrictionRules()
        
        let allowedPrototypes = self.prototypes.filter { $0.status == .opened }
//        self.duplicate(allowedPrototypes)

        self.saveConfig()
        
    }
    
    
    func saveConfig() {
        let config = self.prototypes.reduce("") { $0 + $1.getConfig() + "\n" }
        config.writeFile("config.txt", toFolder: "~/Documents/publish-test/")
    }
    
    func readConfig() {
        if let lines = URL(string: "~/Documents/publish-test/config.txt")?.read().split(separator: "\n", omittingEmptySubsequences: true) {
            print(lines.first)
        }
        else { print("🛑 Config was not found") }
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


extension Prototype {
    func getConfig() -> String {
        if let date = self.folder.modificationDate {
            return "\(self.id), \(self.name.origin), \(date), \(self.status)"
        }
        return "-1, Unknown, +0000, closed"
    }
}
