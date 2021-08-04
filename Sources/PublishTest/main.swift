

import Foundation
import Publish
import Plot
import Files

// This type acts as the configuration for your website.
public struct PublishTest: Website {
    public enum SectionID: String, WebsiteSectionID {
        case prototypes
    }

    public struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    public var url = URL(string: "https://tilllur.ru")!
    public var name = "TillluR"
    public var description = "Work in Progress"
    public var language: Language { .english }
    public var imagePath: Path? { nil }
    
    public init() {}
}

// This will generate your website using the built-in Foundation theme:



let mainQueue = "~/Documents/Git/Prototyping-Queue/"
let testQueue = "~/Documents/testing-queue/"

var scope = Queue(withPath: testQueue)





try PublishTest().publish(using: [
    .readPrototypes(),
    ]
)



extension PublishingStep where Site == PublishTest {
    
    static func addDefaultSectionTitles() -> Self {
        .step(named: "Default section titles") { context in
            context.mutateAllSections { section in
                guard section.title.isEmpty else { return }

                switch section.id {
                case .prototypes:
                    section.title = "My Prototypes"
//                case .links:
//                    section.title = "External links"
//                case .about:
//                    section.title = "About this site"
                }
            }
        }
    }
    
    
    
    
    
    
    
    static func readPrototypes() -> Self {
        .step(named: "Read Prototype Queue") { context in
            
            try Folder(path: scope.path).subfolders.enumerated().forEach { (index, folder) in
                scope.add(Prototype(withFolder: folder))
            }
            
            scope.computeZScore()
            scope.setRestrictions()
        }
    }
    
    
    
    
    
    
    
    

    
    
    
//    static func helperLogModules() -> Self {
//        .step(named: "H: Count modules size for each project") { context in
//            Prototype.logModules()
//        }
//    }
    
//    static func helperGridData() -> Self {
//        .step(named: "H: Save Grid Data to Framer Prototype") { context in
//            Prototype.framerGridData().writeFile("data.coffee", toFolder: "/Users/tilllur/Documents/Git/Prototyping-Queue/2020-12-20 [d] Projects List – Grid.framer/modules/")
//        }
//    }
    
//    static func helperCommands() -> Self {
//        .step(named: "H: Generate SH scripts") { context in
//            Prototype.getTerminalCommandList()
//            Prototype.getTerminalCommandDeteleList()
//        }
//    }
    
//    static func helperProjectTitles() -> Self {
//        .step(named: "H: Write projects titles by prototypes' count") { context in
//            Prototype.getProjectlist()
//        }
//    }
    
    
    
    
}
