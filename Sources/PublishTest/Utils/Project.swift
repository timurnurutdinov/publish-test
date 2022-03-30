//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 3/19/22.
//

import Foundation
import Files

extension Queue {
    
    func getProjectlist() {
        let titles = self.prototypes.map { $0.name.project }

        var counts: [String: Int] = [:]
        for item in titles { counts[item] = (counts[item] ?? 0) + 1 }
        let sortedCounts = counts.sorted { $0.1 > $1.1 }

        var string = ""
        for (key, value) in sortedCounts {
            string.append("\(String(format: "%03d", value)): \(key)\n")
        }

        string.writeTempFile("projects.txt")

        let bigProjects = sortedCounts.filter { $0.1 > 10 }

        do {
            let folder = try Folder(path: "~/Desktop/\(OutputFolder.name)")
            try folder.createSubfolderIfNeeded(withName: "projects")
            
            for (key, _) in bigProjects {
                let keyTitles = self.prototypes.filter { $0.name.project == key }
                let keyStrings = keyTitles.map { "\($0.name.title)\n" }
                let sortedKeyStrings = keyStrings.sorted { $0 < $1 }
                let allKeyProjects = sortedKeyStrings.reduce("", +)
                allKeyProjects.writeTempFile("\(key).txt", toFolder: "projects")
            }
        }
        catch { print("Failed projects") }
    }
    
}
