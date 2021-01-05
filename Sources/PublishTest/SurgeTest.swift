//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 12/21/20.
//

import Foundation
import Surge

struct SurgeTest {
    var maxLines = 0
    var average: Double = 0.0
    var stdvar: Double = 1.0
    var zScore: [Double] = [Double]()
    
    // test
    init() {
        let n = [1.0, 2.0, 3.0, 4.0, 5.0, 100]
        let sum = Surge.sum(n)
        let average = sum / Double(n.count)
        print(average)
        
        let stdvar = Surge.std(n)
        print(stdvar)
        
        self.zScore = n.map { ($0 - average)/stdvar }
        print(self.zScore)
    }
    
    
    init(withPrototypes prototypes:[Prototype]) {
        let sumArray = prototypes.map { Double($0.lines) }
        let sum = Surge.sum(sumArray)
        
        self.average = sum / Double(sumArray.count)
        self.stdvar = Surge.std(sumArray)
        print("A: \(self.average), SV: \(self.stdvar)")
        
        for prototype in prototypes { prototype.setZScore(withAverage: self.average, andVariation: self.stdvar) }
        let extremePrototypes = prototypes.filter { $0.zScore > 2 }
        print("ECount: \(extremePrototypes.count)")
        
        for prototype in prototypes {
            if prototype.lines > self.maxLines { self.maxLines = prototype.lines }
        }
        print("M: \(self.maxLines)")
        
//        self.zScore = sumArray.map { ($0 - self.average)/self.stdvar }
//        print(self.zScore)
    }
}

