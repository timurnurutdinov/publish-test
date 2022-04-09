//
//  File.swift
//  
//
//  Created by tilllur on 03.04.2022.
//

import Foundation

enum IntBoolforJSON: Int, Codable {
    case opened = 1
    case closed = 0
}

struct PrototypeJSON: Codable {
    var i: Int // index
    var t: String // title
    var p: String // project title
    var y: String // year
    var f: IntBoolforJSON // fav
    var s: IntBoolforJSON // status
    var u: String // url
}

extension Queue {
    mutating func savePrototypesPageJSON(configFile:String = "m.json", toFolder: String = OutputFolder.path) {
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY"
            
            let reversedPrototypes = self.prototypes.reversed()
            let filtered = reversedPrototypes.filter { $0.status == Status.opened }
            
            
            let minimalState = filtered.map {
                PrototypeJSON(i: ($0.id + 1), t: $0.name.title, p: $0.name.project, y: $0.name.getYear(), f: .closed, s: .closed, u: $0.url)
            }
            
            
            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted
            
            let data = try encoder.encode(minimalState)
            if let jsonString = String(data: data, encoding: .utf8) { jsonString.writeFile(configFile, toFolder: toFolder) }
            
        } catch { print(error) }
    }
}
