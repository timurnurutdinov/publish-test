//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 3/1/22.
//

import Foundation

extension Queue {
    
    static var existScope: [Prototype] = []
    
    func find() {
        self.prototypes.map { $0.findLine() }
        let foundNames = Queue.existScope.map { $0.name.origin }
        print(foundNames)
    }
}

extension Prototype {
    
    func findLine() {
        if let appCoffeeURL = URL(string: Prototype.app, relativeTo: self.folder.url) {
            let code = appCoffeeURL.string()
            
            if code.contains("emit") {
                Queue.existScope.append(self)
            }
        }
    }
}
