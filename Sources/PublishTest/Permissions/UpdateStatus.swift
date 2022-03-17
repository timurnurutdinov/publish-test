//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 3/1/22.
//

import Foundation

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
    
    func allow(byName name: String, withURL url: String) {
        let names = self.prototypes.map { $0.name.origin }
        if let firstIndex = names.firstIndex(of: name) {
            self.prototypes[firstIndex].setStaticURL(url)
        }
    }

}

