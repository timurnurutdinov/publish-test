//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 17.10.2023.
//

import Foundation

public struct ScopeEnum {
    public static var production    = Scope("~/Documents/Git/Prototyping-Queue/",
                                            static: "~/Documents/Git/tilllur-prototypes-static/",
                                            dynamic: "~/Documents/Git/tilllur-prototypes/")
    
    public static var utils         = Scope("~/Documents/Git/FramerComponents/Experiment-Queue",
                                            static: "remove",
                                            dynamic: "remove")
    
    public static var previewComponent = Scope("~/Documents/Git/PreviewComponent",
                                            static: "remove",
                                            dynamic: "remove")

    public static var templateComponent = Scope("~/Documents/Git/publish-test/template",
                                            static: "remove",
                                            dynamic: "remove")
}


public struct Scope: Equatable {
    public var input: String
    public var staticPath: String
    public var dynamicPath: String
    
    public func cleanStaticFolder() { self.staticPath.cleanSubfolders() }
    public func cleanDynamicFolder() { self.dynamicPath.cleanSubfolders() }
    

    init(_ input:String, static sPath: String, dynamic dPath: String) {
        self.input = input
        
        self.staticPath = sPath
        self.dynamicPath = dPath
        
    }
    
    public static func == (lhs: Scope, rhs: Scope) -> Bool {
        return (lhs.input == rhs.input)
    }
}

