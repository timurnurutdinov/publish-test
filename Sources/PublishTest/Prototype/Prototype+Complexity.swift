//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 2/4/21.
//

import Foundation
import Surge

extension Prototype {
    
    static var maxLines = 0
    static var average: Double = 0.0
    static var stdvar: Double = 1.0
    static var zScore: [Double] = [Double]()
    
    
//    func getNormalizedZScore() -> Double {
//        return self.zScore.rounded(toPlaces: 2)
//    }
    
    func getNormalizedComplexity() -> Double {
        return self.difficulty.rounded(toPlaces: 2)
    }
    
    func set(average:Double, andVariation variation: Double) {
        self.zScore = (Double(self.lines) - average) / variation
        self.difficulty = min(Double(self.lines) / (average * 2.0), 1.0)
        
//        if self.zScore < -2 || self.zScore > 2 { print("L: \(self.appLines) \(self.getID())") }
//        if self.difficulty < 0.03 { print("Check: \(self.getID())") }
    }
    
    
    static func getExtremePrototypes(fromPrototypes prototypes:[Prototype] = Prototype.prototypes) -> [Prototype] {
        return prototypes.filter { $0.zScore > 2 }
    }
    
    
    
    static func computeZScore(prototypes:[Prototype] = Prototype.prototypes) {
        
        // Sum lines of all prototypes
        let sumArray = prototypes.map { Double($0.lines) }
        let sum = Surge.sum(sumArray)
        
        // Get Average & Standard Variation
        Prototype.average = sum / Double(sumArray.count)
        Prototype.stdvar = Surge.std(sumArray)
        print("Average: \(Prototype.average), Standard Variation: \(Prototype.stdvar)")
        
        // Select Extreme Prototypes
        for prototype in prototypes { prototype.set(average: Prototype.average, andVariation: Prototype.stdvar) }
        
        let extremePrototypes = getExtremePrototypes()
        print("Extreme Prototypes Count: \(extremePrototypes.count)")
        
        Prototype.zScore = sumArray.map { ($0 - Prototype.average)/Prototype.stdvar }
        Prototype.zScore.writeFile(withName: "zIndex.txt", separatedBy: ",")
        
    }
    
//    static func copyZScoreResultFramer() {
//        let framerProjectPath = "/Users/tilllur/Documents/Git/Prototyping-Queue/2020-12-20\ \[d\]\ Projects\ List\ –\ Grid.framer"
//        
//    }

}


