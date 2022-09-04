//
//  File.swift
//  
//
//  Created by tilllur on 17.06.2022.
//

import Foundation
import Files

struct Seed: Codable, Hashable {
    var nameStatic: String
    var nameDynamic: String
    
    static func == (lhs: Seed, rhs: Seed) -> Bool {
        return (lhs.nameStatic == rhs.nameStatic && lhs.nameDynamic == rhs.nameDynamic)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(nameStatic)
        hasher.combine(nameDynamic)
    }
}


extension Prototype {
    
    func getPermissionWithTag() {
        
        do {
            let resourceValues = try self.folder.url.resourceValues(forKeys: [.tagNamesKey])
            
            if let tags = resourceValues.tagNames {
                if (tags.contains("Private")) {
                    self.restrict()
                }
                else if (tags.contains("Public")) {
                    self.allow()
                }
                else {
                    self.restrict()
                }
            }

        } catch {
            print(error)
        }
    }
    
    
    
    func readSeed(configFile:String = "seed.json") {
        
        do {
            let folder = try Folder(path: folder.path + "tilllur/")
            let file = try Folder(path: folder.path + "tilllur/").file(at: configFile)
            let decoder = JSONDecoder()

            do {
                self.seed = try decoder.decode(Seed.self, from: file.testData())
            } catch { print("Failed to decode JSON State") }

        }
        catch { print(error) }
    }


    func saveSeed(configFile:String = "seed.json") {
        do {

            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted

            let data = try encoder.encode(self.seed)
            if let jsonString = String(data: data, encoding: .utf8) { jsonString.writeFile(configFile, toFolder: folder.path + "tilllur/") }

        } catch { print(error) }
    }
}
