//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 7/24/21.
//

import Foundation

extension Prototype {
    
    static var restrictedTillName: String = "2019-05-18 [ios] Purify – Swipe.framer";
    
    static var restrictedList = [String]()
    static var allowedList = [String]()
    
    static func setRestrictions(prototypes:[Prototype] = Prototype.prototypes) {
        
        var allowedPrototypes = prototypes
        
        let titles = Prototype.prototypes.map { $0.name.origin }
        if let indexOfRestrictedTillName = titles.firstIndex(of: Prototype.restrictedTillName) {
            allowedPrototypes = prototypes[0...indexOfRestrictedTillName]
        }
        
        // TODO: Remove restricted
        
        // TODO: Add allowed
        
    }
    
}
