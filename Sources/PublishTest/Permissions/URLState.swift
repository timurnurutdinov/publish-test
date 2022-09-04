//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 3/1/22.


//import Foundation
//import Files
//
//
//
//extension Queue {
//    
//    public mutating func readURLState(configFile:String = "urls.json", fromFolder: String = "~/Documents/Git/publish-test/Content/") -> Set<PrototypeConfig> {
//        
//        do {
//            let file = try Folder(path: fromFolder).file(at: configFile)
//            let decoder = JSONDecoder()
//
//            do {
//                return try decoder.decode(Set<PrototypeConfig>.self, from: file.testData())
//            } catch { print("Failed to decode JSON State") }
//
//        }
//        catch { print(error) }
//        
//        return Set<PrototypeConfig>()
//    }
//
//
////    mutating func saveURLState(configFile:String = "urls.json", toFolder: String = "~/Documents/Git/publish-test/Content/") {
////        do {
////
////            print("Read: \(self.prototypes.count)")
////
////            let encoder = JSONEncoder()
////            encoder.outputFormatting = .prettyPrinted
////
////            let data = try encoder.encode(self.urlState.sorted(by: >))
////            if let jsonString = String(data: data, encoding: .utf8) { jsonString.writeFile(configFile, toFolder: toFolder) }
////
////        } catch { print(error) }
////    }
//
//
////    mutating func readURLMap(configFile:String = "urls.json", fromFolder: String = "~/Documents/Git/publish-test/Content/") {
////
////        do {
////            let file = try Folder(path: fromFolder).file(at: configFile)
////            let decoder = JSONDecoder()
////
////            do {
////                self.urls = try decoder.decode([String].self, from: file.testData())
////            } catch { print("Failed to decode JSON State") }
////
////            print(self.urls[0])
////
////        }
////        catch { print(error) }
////    }
////
////    mutating func updateURLMap(configFile:String = "urls.json", toFolder: String = "~/Documents/Git/publish-test/Content/") {
////
////        do {
////            var file: [String] = []
////            for _ in 1...2000 { file.append(String.randomStringForURL()) }
////
////            let encoder = JSONEncoder()
////            encoder.outputFormatting = .prettyPrinted
////
////            let data = try encoder.encode(file)
////            if let jsonString = String(data: data, encoding: .utf8) { jsonString.writeFile(configFile, toFolder: toFolder) }
////
////        } catch { print(error) }
////    }
//        
//}
//
//
//
//
//
//
