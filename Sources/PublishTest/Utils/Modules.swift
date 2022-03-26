//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 8/1/21.
//

import Foundation


extension Queue {
    
    static var modulesToSkip = [
        "myModule.coffee",
        
        "all.coffee",
        "blur.coffee",
        "dark.coffee",
        "data.coffee",
        "site.coffee",
        "gradientData.coffee",
        "yandexDevices.coffee",
        "result.coffee",
        "input.coffee", // REMOVE? personal input
        "input backup.coffee",
        
        "DynamicLoader.coffee",
        "iOSSegmentedControl.coffee",
        "iOSSwitch.coffee",
        "Names.coffee",
        "ScrollRange.coffee",
        "TextLayer.coffee",
        "animateOnSpline.coffee",
        "SVGLayer.coffee",
        "distributeLayers.coffee",
        "audio.coffee",
        "text.coffee",
        "Pointer.coffee",
        "ControlPanel.coffee",
        "SVGIcon.coffee",
        "OrientationSimulator.coffee",
        "System-Sensor.coffee",
        "System.coffee",
        "textlayer.coffee",
        "simpleripple.coffee",
        
        "PreviewComponent.coffee",
        "PreviewComponentAssets.coffee",
    ]
    
    static func notSkipped(module moduleName: String) -> Bool {
        return !modulesToSkip.contains(moduleName)
    }
    
    func logModules() {
        let haveModules = self.prototypes.filter { $0.moduleLines > 0 }
        let sortedMLines = haveModules.sorted { $0.moduleLines > $1.moduleLines }
        let moduleArray = sortedMLines.map { String("\(String(format: "%04d", $0.moduleLines)) \($0.name.origin)") }
        moduleArray.writeFile(withName: "modules.txt", separatedBy: "\n")
    }
    
}

