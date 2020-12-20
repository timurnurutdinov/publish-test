

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
//    .copyResources(at: "Content"),
//    .addFavoriteItems(),
    .addDefaultSectionTitles(),
    .generateHTML(withTheme: .foundation),
    
    
//    .generateHTML(withTheme: .foundation),
//    .deploy(using: .gitHub("    timurnurutdinov/timurnurutdinov.github.io", useSSH: false))
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
        .step(named: "Read Prototype Folder") { context in
            let mainFolderPath = "~/Desktop/test/"
            try Folder(path: mainFolderPath).subfolders.enumerated().forEach { (index, folder) in
                Prototype(withFolder: folder)
            }
        }
    }
    
    
    static func readFiles() -> Self {
        .step(named: "Read Prototype Folder") { context in
            
//            var prototypes = [ParsePrototype]()
            let mainFolderPath = "~/Desktop/test/"
            
            try Folder(path: mainFolderPath).subfolders.enumerated().forEach { (index, folder) in
//                prototypes.append(ParsePrototype.init(name: folder.nameExcludingExtension))
                
                // read each prototype
                // count stats:
                // 1. creation date
                // 2. line count
                // 3. tags
            }
            
            
        }
    }
    
}
