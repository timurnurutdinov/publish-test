//
//  File.swift
//  
//
//  Created by Timur Nurutdinov on 16.10.2023.
//

import Foundation


public enum FramerComponentEnum {
    
    public static var PreviewComponent = FramerComponent(nameFile:          "PreviewComponent.coffee",
                                                         assetsFolderName:  "PreviewComponentAssets",
                                                         componentFolder:   "~/Documents/Git/PreviewComponent/Preview.framer",
                                                         moduleFolder:      "~/Documents/Git/PreviewComponent/Preview.framer/modules",
                                                         assetsFolder:      "~/Documents/Git/PreviewComponent/Preview.framer/modules/PreviewComponentAssets",
                                                         appFile:           "~/Documents/Git/PreviewComponent/Preview.framer/app.coffee")
    
//    public static var PresentationComponent = FramerComponent(nameFile:     "PresentationComponent.coffee",
//                                                         assetsFolderName:  "PresentationComponentAssets",
//                                                         componentFolder:   "~/Documents/Git/PresentationComponent/Presentation.framer",
//                                                         moduleFolder:      "~/Documents/Git/PresentationComponent/Presentation.framer/modules",
//                                                         assetsFolder:      "~/Documents/Git/PresentationComponent/Presentation.framer/modules/PresentationComponentAssets",
//                                                         appFile:           "~/Documents/Git/PresentationComponent/Presentation.framer/app.coffee")
    
    public static var TemplateComponent = FramerComponent(nameFile:     "PresentationComponent.coffee",
                                                         assetsFolderName:  "PresentationComponentAssets",
                                                         componentFolder:   "~/Documents/Git/publish-test/template/Template.framer",
                                                         moduleFolder:      "~/Documents/Git/publish-test/template/Template.framer/modules",
                                                         assetsFolder:      "~/Documents/Git/publish-test/template/Template.framer/modules/PresentationComponentAssets",
                                                         appFile: "~/Documents/Git/publish-test/template/Template.framer/app.coffee")
}

