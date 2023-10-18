//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 16.10.2023.
//

import Foundation
import Files


extension Queue {
    mutating public func createNewPrototype(component: FramerComponent = FramerComponentEnum.TemplateComponent) {
        
        var files = [File]()
        var folders = [Folder]()
        
        do {
            
            let refFolder = try Folder(path: component.componentFolder)
            let queueFolder = try Folder(path: self.scope.input)
            
            let newPrototypeFolder = try refFolder.copy(to: queueFolder)
            try newPrototypeFolder.rename(to: Date().toStringWithFormat("yyyy-MM-dd") + " [platform] Project — Title ")
            
            var newPrototype = self.addPrototypeReversed(for: newPrototypeFolder)
            if let validPrototype = newPrototype {
                if self.scope == ScopeEnum.production { self.updateSeed(forNewPrototype: validPrototype) }
            }
            
        }
        catch {
            print("Failed to create new prototype")
        }
        
    }
}


extension Date {
    func toStringWithFormat(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
