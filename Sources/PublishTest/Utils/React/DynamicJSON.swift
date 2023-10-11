//
//  File.swift
//  
//
//  Created by tilllur on 03.04.2022.
//

import Foundation
import Files

struct ExportPrototypeJSON: Codable {
    var i: Int // index
    var t: String // title
    var p: String // project title
    var y: String // year
    var f: Bool // fav
    var s: Bool // status
    var u: String // url
}


extension Prototype {
    static var blankURL = "blank"
    
    func closedDescription() -> String { return "Soon" }
}


extension Queue {
    mutating func savePrototypesPageJSON(configFile:String = "m.json", toFolder: String = Site.host) {
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY"
            
            
            let minimalState = self.prototypes.reversed().enumerated().map { (index, prototype) -> ExportPrototypeJSON in
                if (prototype.json.open) {
                    return ExportPrototypeJSON(i: (index + 1),
                                         t: prototype.name.title,
                                         p: prototype.name.project,
                                         y: prototype.name.getYear(),
                                        f: prototype.json.star,
                                               s: prototype.json.open,
                                         u: prototype.json.url)
                }
                else {
                    return ExportPrototypeJSON(i: (index + 1),
                                         t: "NDA",
                                         p: prototype.closedDescription(),
                                         y: prototype.name.getYear(),
                                               f: prototype.json.star,
                                               s: prototype.json.open,
                                         u: Prototype.blankURL)
                }
                
            }
            
            
            let encoder = JSONEncoder()
            
            let data = try encoder.encode(minimalState.reversed())
            if let jsonString = String(data: data, encoding: .utf8) { jsonString.writeFile(configFile, toFolder: toFolder) }
            
        } catch { print(error) }
    }
}

