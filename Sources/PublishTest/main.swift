

import Foundation
import Publish
import Plot
import Files

// This type acts as the configuration for your website.
struct PublishTest: Website {
    enum SectionID: String, WebsiteSectionID {
        case prototypes
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://tilllur.ru")!
    var name = "TillluR"
    var description = "Work in Progress"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try PublishTest().publish(using: [
    .addMarkdownFiles(),
    
    .readPrototypes(),
    .setRestrictions(),
    .computeComplexity(),
    
    .helperLogModules(),
//    .helperCommands(),
    .helperProjectTitles(),
    
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
            
            try Folder(path: Prototype.queue).subfolders.enumerated().forEach { (index, folder) in
                Prototype(withFolder: folder)
            }
            
            let folder = try Folder(path: "~/Desktop/")
            try folder.createSubfolderIfNeeded(withName: Prototype.outputFolderName)
            
        }
    }
    
    
    
    static func computeComplexity() -> Self {
        .step(named: "Compute Complexity Score") { context in
            Prototype.computeZScore()
        }
    }
    
    
    
    
    
    
    

    
    
    
    static func helperLogModules() -> Self {
        .step(named: "H: Count modules size for each project") { context in
            Prototype.logModules()
        }
    }
    
    static func helperGridData() -> Self {
        .step(named: "H: Save Grid Data to Framer Prototype") { context in
            Prototype.framerGridData().writeFile("data.coffee", toFolder: "/Users/tilllur/Documents/Git/Prototyping-Queue/2020-12-20 [d] Projects List – Grid.framer/modules/")
        }
    }
    
    static func helperCommands() -> Self {
        .step(named: "H: Generate SH scripts") { context in
            Prototype.getTerminalCommandList()
            Prototype.getTerminalCommandDeteleList()
        }
    }
    
    static func helperProjectTitles() -> Self {
        .step(named: "H: Write projects titles by prototypes' count") { context in
            Prototype.getProjectlist()
        }
    }
    
    
    
    
    
    
    static func setRestrictions() -> Self {
        .step(named: "Setting Restrictions") { context in
            
            Prototype.setRestrictions()
            
//            let folder = try Folder(path: "~/Desktop/")
//            try folder.createSubfolderIfNeeded(withName: Prototype.outputFolderName)
            
        }
    }
    
}
