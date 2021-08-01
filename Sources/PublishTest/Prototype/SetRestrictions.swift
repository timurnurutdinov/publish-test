//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 7/24/21.
//

import Foundation
import Checksum

extension Queue {
    
    func setRestrictions() {
        
        var toEdgePrototypes:[Prototype] = self.prototypes
        
        // Slice to Edge
        let titles = self.prototypes.map { $0.name.origin }
        if let indexOfRestrictedTillName = titles.firstIndex(of: self.restrictedTillName) {
            toEdgePrototypes = Array(prototypes.prefix(upTo: indexOfRestrictedTillName))
        }
        
        // Remove restricted
        let remainingPrototypes = toEdgePrototypes.filter {
            !restrictedList.contains($0.name.origin)
        }
        
        // Add allowed
        let allowedPrototypes = prototypes.filter { prototype in
            return allowedList.contains(prototype.name.origin)
        }
        
        
        // Result
        let uniquePrototypes = Array(Set(remainingPrototypes + allowedPrototypes))
        let sortedPrototypes = uniquePrototypes.sorted { $0.name.origin > $1.name.origin }
        
        self.duplicatePrototypes(allowedPrototypes: sortedPrototypes)
        
        
        // Output
        let allowedOutput = sortedPrototypes.map { $0.name.origin }
        allowedOutput.writeFile(withName: "allowed.txt", separatedBy: "\n")
        
        let test = sortedPrototypes.map { String($0.id) }
        test.writeFile(withName: "allowedPaths.txt", separatedBy: "\n")
        
    }
}



extension Queue {
    
    mutating func testRestrictins() {
        self.restrict(till: "2021-01-24 [pp] Geo View – Arrow Playground.framer")
        self.restrict(byName: "2018-10-10 [abro] Menu – Open 11.framer")
        
        self.allow(byName: "2019-05-18 [utils] Utils – Size.framer")
        self.allow(byName: "2019-05-18 [ios] Purify – Swipe.framer")
    }
}
