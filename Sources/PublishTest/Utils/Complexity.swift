//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 2/4/21.
//

import Foundation
import Surge
import Files


extension Queue {
    
    func getExtremePrototypes() -> [Prototype] {
        return self.prototypes.filter { $0.zScore > 2 }
    }
    
    mutating func setScore() {
        return
        // TODO: FIX
        
//        // Sum lines of all prototypes
//        let sumArray = self.prototypes.map { Double($0.lines) }
//        let sum = Surge.sum(sumArray)
//
//        // Get Average & Standard Variation
//        self.setAvarage(sum / Double(sumArray.count))
//        self.setStandardVariation(Surge.std(sumArray))
//        print("Average: \(self.average), Standard Variation: \(self.standardVariation)")
//
//        // Select Extreme Prototypes
//        for prototype in self.prototypes { prototype.set(average: self.average, andVariation: self.standardVariation) }
//
//        print("Extreme Prototypes Count: \(self.getExtremePrototypes().count)")
//
//        let computedScore = sumArray.map { ($0 - self.average)/self.standardVariation }
//        self.setZScore(computedScore)
//
//        self.logExtremePrototypesNames()
//        self.logModules()
        
    }
    
    func logExtremePrototypesNames() {
        return
        
//        self.zScore.writeFile(withName: "zIndex.txt", separatedBy: ",")
//        
//        let extremeNames = self.getExtremePrototypes().map { $0.name.origin }
//        extremeNames.writeFile(withName: "extreme prototypes.txt", separatedBy: "\n")
    }
}



extension Prototype {
    
    func getNormalizedComplexity() -> Double {
        return self.difficulty.rounded(toPlaces: 2)
    }
    
    func set(average:Double, andVariation variation: Double) {
        self.zScore = (Double(self.lines) - average) / variation
        self.difficulty = min(Double(self.lines) / (average * 2.0), 1.0)
    }
    
    func countLines() {
        // Lines of app.coffee
        if let appCoffeeURL = URL(string: Prototype.app, relativeTo: self.folder.url) {
            self.appLines = appCoffeeURL.lines()
            self.lines += self.appLines
        }
        
        // Lines of modules
        do {
            let modulesPath = self.folder.path + Prototype.moduleFolder
            try Folder(path: modulesPath).files.enumerated().forEach { (index, file) in
                if (file.name.fileExtension() == "coffee" && Queue.notSkipped(module: file.name)) {
                    self.moduleLines += file.url.lines()
                }
            }
            
            self.lines += self.moduleLines
            
        }
        catch {
//            print("📭 Modules Folder not found")
        }
        
        if self.lines < 10 { print("📭 Empty Prototype: \(folder.name)") }
    }
}


