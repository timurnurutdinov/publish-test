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
        catch { print("📭 Modules Folder not found") }
        
        
        if self.lines < 10 { print("📭 Empty Prototype: \(folder.name)") }
    }
    
    
//    func countLines(forPath filePath: String) -> Int {
//        do { return try File(path: filePath).lines() }
//        catch { print("🛑 Failed to count lines in app.coffee") }
//        return 0
//    }
    
    
    
    
    static var modulesToSkip: [String] = ["myModule.coffee", "input.coffee", "ScrollRange.coffee", "TextLayer.coffee", "input backup.coffee", "animateOnSpline.coffee", "SVGLayer.coffee", "distributeLayers.coffee", "audio.coffee", "text.coffee", "Pointer.coffee", "ControlPanel.coffee", "result.coffee", "all.coffee", "blur.coffee", "dark.coffee", "SVGIcon.coffee", "OrientationSimulator.coffee", "System-Sensor.coffee", "System.coffee", "textlayer.coffee", "gradientData.coffee", "simpleripple.coffee", "yandexDevices.coffee"]
    
    static var skipMap: [String: Int] = Prototype.getModulesToSkipMap()
    
    static func getModulesToSkipMap() -> [String: Int] {
        var counts: [String: Int] = [:]
        for item in Prototype.modulesToSkip { counts[item] = (counts[item] ?? 0) + 1 }
        return counts
    }

}
