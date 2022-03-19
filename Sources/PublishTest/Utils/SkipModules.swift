//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 8/1/21.
//

import Foundation


extension Queue {
    
    static var modulesToSkip = ["myModule.coffee", "data.coffee", "input.coffee", "ScrollRange.coffee", "TextLayer.coffee", "input backup.coffee", "animateOnSpline.coffee", "SVGLayer.coffee", "distributeLayers.coffee", "audio.coffee", "text.coffee", "Pointer.coffee", "ControlPanel.coffee", "result.coffee", "all.coffee", "blur.coffee", "dark.coffee", "SVGIcon.coffee", "OrientationSimulator.coffee", "System-Sensor.coffee", "System.coffee", "textlayer.coffee", "gradientData.coffee", "simpleripple.coffee", "yandexDevices.coffee"]
    
    static func notSkipped(module moduleName: String) -> Bool {
        return !modulesToSkip.contains(moduleName)
    }
    
    func logModules() {
        let sortedMLines = self.prototypes.sorted { $0.moduleLines > $1.moduleLines }
        let moduleArray = sortedMLines.map { String("\(String(format: "%04d", $0.moduleLines)) \($0.name.origin)") }
        moduleArray.writeFile(withName: "modules.txt", separatedBy: "\n")
    }
    
}

