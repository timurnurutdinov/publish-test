//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 2/4/21.
//

import Foundation
import Files

extension Prototype {
    
    // Save Module Name & Example Path
    static var moduleNames: [String: String] = [:]
    
    func countLines() {
        if let appCoffeeURL = URL(string: Prototype.app, relativeTo: self.folder.url) {
            self.appLines = appCoffeeURL.lines()
            self.lines += self.appLines
        }
        
        do {
            let modulesPath = self.folder.path + Prototype.modules
            try Folder(path: modulesPath).files.enumerated().forEach { (index, folder) in

                if (folder.name.fileExtension() == "coffee" && folder.name.notSkipped()) {
                    // Save for logging
                    Prototype.moduleNames[folder.name] = (Prototype.moduleNames[folder.name] ?? "") + folder.path
                    
                    self.moduleLines = self.moduleLines + folder.url.lines()
                }
            }
            self.lines += self.moduleLines
        }
        catch {
//            print("📭 Modules Folder not found")
        }
        
        
        if self.lines < 10 { print("📭 Empty Prototype: \(folder.name)") }
    }
    
    
    static func logModules() {
        let mLines = Prototype.prototypes.map { $0 }
        let sortedMLines = mLines.sorted { $0.moduleLines > $1.moduleLines }
        let moduleArray = sortedMLines.map { String("\(String(format: "%04d", $0.moduleLines)) \($0.name.origin)") }
        moduleArray.writeFile(withName: "modules.txt", separatedBy: "\n")
    }
    
    
    
    
    
    static var modulesToSkip: [String] = ["myModule.coffee", "data.coffee", "input.coffee", "ScrollRange.coffee", "TextLayer.coffee", "input backup.coffee", "animateOnSpline.coffee", "SVGLayer.coffee", "distributeLayers.coffee", "audio.coffee", "text.coffee", "Pointer.coffee", "ControlPanel.coffee", "result.coffee", "all.coffee", "blur.coffee", "dark.coffee", "SVGIcon.coffee", "OrientationSimulator.coffee", "System-Sensor.coffee", "System.coffee", "textlayer.coffee", "gradientData.coffee", "simpleripple.coffee", "yandexDevices.coffee"]
    
    static var skipMap: [String: Int] = Prototype.getModulesToSkipMap()
    
    static func getModulesToSkipMap() -> [String: Int] {
        var counts: [String: Int] = [:]
        for item in Prototype.modulesToSkip { counts[item] = (counts[item] ?? 0) + 1 }
        return counts
    }
    
}




extension Prototype {
    func framerCellData() -> String {
//        func t() -> String { return "\t" }
//        func dt() -> String { return "\(t())\(t())" }
//        func n() -> String { return "\n" }
        
        var string = "\t{\n"
        string.append("\t\tscore: \(self.getNormalizedComplexity()),\n")
        string.append("\t\tproject: \"\(self.name.title)\",\n")
        string.append("\t},\n")
        
        return string
    }
    
    static func framerGridData() -> String {
        var strArray = Prototype.prototypes.map { $0.framerCellData() }
        var string = strArray.reduce("exports.data = [\n", +)
        string.append("]\n\n")
        return string
    }
}

