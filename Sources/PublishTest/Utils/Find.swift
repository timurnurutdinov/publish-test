//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 3/1/22.
//

import Foundation

extension Queue {
    
    static var existScope: [Prototype] = []
    
    func find(_ line:String) {
        self.prototypes.map { $0.find(line) }
        Queue.existScope.map { print($0.name.origin) }
    }
}

extension Prototype {
    
    func find(_ line: String) {
        if let appCoffeeURL = URL(string: Prototype.app, relativeTo: self.folder.url) {
            let code = appCoffeeURL.string()
            
            if code.contains(line) {
                Queue.existScope.append(self)
            }
        }
    }
}
