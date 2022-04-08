//
//  File.swift
//  
//
//  Created by tilllur on 06.04.2022.
//

import Foundation

extension Queue {
    static var customHTML: [Prototype] = []

    func find(inHTML line:String, _ contains: Bool = true) {
        self.prototypes.map { $0.find(inHTML: line, contains) }
        Queue.customHTML.map { print($0.name.origin) }
    }
}

extension Prototype {
    static let framerIndexHTMLName = "index.html"
    
    func find(inHTML line: String, _ contains: Bool) {
        if let appCoffeeURL = URL(string: Prototype.framerIndexHTMLName, relativeTo: self.folder.url) {
            let codeOrigin = appCoffeeURL.string()
            let code = String(codeOrigin.filter { !" \n\t\r".contains($0) })
//            print(code)
            
            if contains && code.contains(line) {
                Queue.customHTML.append(self)
            }
            else if !contains && !code.contains(line) {
                Queue.customHTML.append(self)
            }
        }
    }
}

