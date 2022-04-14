//
//  File.swift
//  
//
//  Created by tilllur on 03.04.2022.
//

import Foundation

struct PrototypeJSON: Codable {
    var i: Int // index
    var t: String // title
    var p: String // project title
    var y: String // year
    var f: Featured // fav
    var s: Status // status
    var u: String // url
}


extension Queue {
    mutating func savePrototypesPageJSON(configFile:String = "m.json", toFolder: String = OutputFolder.path) {
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY"
            
            let reversedPrototypes = self.prototypes.reversed()
            let filtered = reversedPrototypes.filter { $0.status == Status.opened }
            
            
            let minimalState = filtered.reversed().enumerated().map { (index, prototype) in
                PrototypeJSON(i: index,
                              t: prototype.name.title,
                              p: prototype.name.project,
                              y: prototype.name.getYear(),
                              f: prototype.featured,
                              s: prototype.status,
                              u: prototype.dynamicURL)
            }
            
            
            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted
            
            let data = try encoder.encode(minimalState)
            if let jsonString = String(data: data, encoding: .utf8) { jsonString.writeFile(configFile, toFolder: toFolder) }
            
        } catch { print(error) }
    }
}
