//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 8/1/21.
//

import Foundation

//extension Prototype {
//    func framerCellData() -> String {
//        
//        var string = "\t{\n"
//        string.append("\t\tscore: \(self.getNormalizedComplexity()),\n")
//        string.append("\t\tproject: \"\(self.name.title)\",\n")
//        string.append("\t},\n")
//        
//        return string
//    }
//    
//    static func framerGridData() -> String {
//        let strArray = Prototype.prototypes.map { $0.framerCellData() }
//        var string = strArray.reduce("exports.data = [\n", +)
//        string.append("]\n\n")
//        return string
//    }
//    
//    
//    func terminalImageOptimCommand() -> String {
//        var imagesPath = "imageoptim \"\(self.folder.path)images/\"\n"
//        do {
//            try Folder(path: "\(self.folder.path)imported/").subfolders.enumerated().forEach { (index, folder) in
//                imagesPath += "imageoptim \"\(folder.path)images/\"\n"
//            }
//        }
//        catch {}
//        return imagesPath
//    }
//    
//    static func getTerminalCommandList() -> String {
//        let shString = "#!/bin/sh\n"
//        let slicedArray = Array(Prototype.prototypes[151...170])
//        
//        let strArray = slicedArray.map { $0.terminalImageOptimCommand() }
//        let string = strArray.reduce(shString, +)
//        string.writeFile("optim.sh", toFolder: "~/Desktop/")
//        return string
//    }
//    
//    
//    static func getProjectlist() -> String {
//        let titles = Prototype.prototypes.map { $0.name.title }
//        
//        var counts: [String: Int] = [:]
//        for item in titles { counts[item] = (counts[item] ?? 0) + 1 }
//        let sortedCounts = counts.sorted { $0.1 > $1.1 }
//        
//        var string = ""
//        for (key, value) in sortedCounts {
//            string.append("\(String(format: "%03d", value)): \(key)\n")
//        }
//        
//        string.writeFile("projectTitles.txt", toFolder: Prototype.outputFolderPath)
//        
//        let bigProjects = sortedCounts.filter { $0.1 > 10 }
//        
//        do { try Folder(path: Prototype.outputFolderPath).createSubfolderIfNeeded(withName: "big projects") }
//        catch {}
//        
//        for (key, _) in bigProjects {
//            let keyTitles = Prototype.prototypes.filter { $0.name.title == key }
//            let keyStrings = keyTitles.map { "\($0.name.scene)\n" }
//            let sortedKeyStrings = keyStrings.sorted { $0 < $1 }
//            let allKeyProjects = sortedKeyStrings.reduce("", +)
//            allKeyProjects.writeFile("\(key).txt", toFolder: "\(Prototype.outputFolderPath)big projects")
//        }
//        
//        return string
//    }
//    
//    
//    
//    
//    func terminalDeleteBackupCommand() -> String {
//        var string = ""
////        print("\(self.folder.path)framer/backups/")
//        do {
//            try Folder(path: "\(self.folder.path)framer/backups/").files.enumerated().forEach { (index, folder) in
//                string += "rm \"\(folder.path)\"\n"
////                print("rm2 \"\(folder.path)\"\n")
//            }
//        } catch {}
//        return string
//    }
//    
//    static func getTerminalCommandDeteleList() -> String {
//        let shString = "#!/bin/sh\n"
//        let slicedArray = Array(Prototype.prototypes[...])
////        print(slicedArray[slicedArray.count-1].folder.name)
//        
//        let strArray = slicedArray.map { $0.terminalDeleteBackupCommand() }
//        let string = strArray.reduce(shString, +)
//        string.writeFile("rm.sh", toFolder: "~/Desktop/")
//        return string
//    }
//}
