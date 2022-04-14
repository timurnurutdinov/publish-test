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


extension Prototype {
    static var blankURL = "blank"
}

extension Queue {
    mutating func savePrototypesPageJSON(configFile:String = "m.json", toFolder: String = OutputFolder.path) {
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY"
            
//            let reversedPrototypes = self.prototypes.reversed()
//            let filtered = reversedPrototypes.filter { $0.status == Status.opened }
            
            
            let minimalState = self.prototypes.enumerated().map { (index, prototype) -> PrototypeJSON in
                if (prototype.status == .opened) {
                    return PrototypeJSON(i: (index + 1),
                                         t: prototype.name.title,
                                         p: prototype.name.project,
                                         y: prototype.name.getYear(),
                                         f: prototype.featured,
                                         s: prototype.status,
                                         u: prototype.dynamicURL)
                }
                else {
                    return PrototypeJSON(i: (index + 1),
                                         t: "NDA",
                                         p: "Temporarily Unavailable",
                                         y: prototype.name.getYear(),
                                         f: prototype.featured,
                                         s: prototype.status,
                                         u: Prototype.blankURL)
                }
                
            }
            
            
            let encoder = JSONEncoder()
            
            let data = try encoder.encode(minimalState.reversed())
            if let jsonString = String(data: data, encoding: .utf8) { jsonString.writeFile(configFile, toFolder: toFolder) }
            
        } catch { print(error) }
    }
}
