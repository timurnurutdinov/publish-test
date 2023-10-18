//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 17.10.2023.
//

import Foundation

public struct ScopeEnum {
    public static var production    = Scope("~/Documents/Git/Prototyping-Queue/",
                                            static: "s",
                                            dynamic: "d")
    
//    public static var presentations = Scope("~/Documents/Git/Presentation-Queue",
//                                            static: "p",
//                                            dynamic: "remove")
    
//    public static var components = Scope("~/Documents/Git/FramerComponents/Component-Queue",
//                                            static: "remove",
//                                            dynamic: "remove")
    
    public static var utils         = Scope("~/Documents/Git/FramerComponents/Experiment-Queue",
                                            static: "utils",
                                            dynamic: "remove")
    
    
    
    
    public static var previewComponent = Scope("~/Documents/Git/PreviewComponent",
                                            static: "remove",
                                            dynamic: "remove")
    
//    public static var presentationComponent = Scope("~/Documents/Git/PresentationComponent",
//                                            static: "remove",
//                                            dynamic: "remove")
    
//    public static var showcaseComponent = Scope("~/Documents/Git/ShowcaseComponent",
//                                            static: "remove",
//                                            dynamic: "remove")

    public static var templateComponent = Scope("~/Documents/Git/publish-test/template",
                                            static: "remove",
                                            dynamic: "remove")
}


public struct Scope: Equatable {
    public var input: String
    
    public var staticShort: String
    public var staticLong: String
    
    
    public var dynamicShort: String
    public var dynamicLong: String
    

    init(_ input:String, static outputStatic: String, dynamic outputDynamic: String) {
        self.input = input
        
        staticShort = outputStatic
        dynamicShort = outputDynamic
        
        staticLong = StaticSite.with(staticShort)
        dynamicLong = Site.with(dynamicShort)
        
    }
    
    public static func == (lhs: Scope, rhs: Scope) -> Bool {
        return (lhs.input == rhs.input)
    }
}
