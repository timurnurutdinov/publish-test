

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
    
//    .showTitleStats(),
//    .showPlatformStats(),
//    .showTimelineStats(),
    
    .readPrototypes(),
    
//    .addDefaultSectionTitles(),
//    .generateHTML(withTheme: .testTheme),
    
    
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
//            let mainFolderPath = "~/Desktop/test/"
            let mainFolderPath = "~/Documents/Git/Prototyping-Queue/"
//            var prototypes = [Prototype]()
            
            try Folder(path: mainFolderPath).subfolders.enumerated().forEach { (index, folder) in
//                if (folder.name == "2020-01-26 [abro] Wallpapers – Compare App 3.framer") {
//                    Prototype(withFolder: folder)
//                }
                Prototype(withFolder: folder)
            }
            
            
            Prototype.computeZScore()
            Prototype.logModules()
            Prototype.framerGridData().writeFile("data.coffee", toFolder: "/Users/tilllur/Documents/Git/Prototyping-Queue/2020-12-20 [d] Projects List – Grid.framer/modules/")
            
            
        }
    }
    
    
    
    static func testSurge() -> Self {
        .step(named: "testSurge") { context in
            
        }
    }
    
    
    
    
    
    static func showPlatformStats() -> Self {
        .step(named: "Show Platform Stats") { context in
            let mainFolderPath = "~/Documents/Git/Prototyping-Queue/"
            var names = [Name]()
            
            try Folder(path: mainFolderPath).subfolders.enumerated().forEach { (index, folder) in
                names.append(Name(folder.name))
            }
            
            Name.printPlatform(names)
        }
    }
    
    static func showTimelineStats() -> Self {
        .step(named: "Read Prototype Name") { context in
            let mainFolderPath = "~/Documents/Git/Prototyping-Queue/"
            var names = [Name]()
            
            try Folder(path: mainFolderPath).subfolders.enumerated().forEach { (index, folder) in
                names.append(Name(folder.name))
            }
            
            Name.printTimeline(names)
        }
    }
    
    static func showTitleStats() -> Self {
        .step(named: "Read Prototype Name") { context in
            let mainFolderPath = "~/Documents/Git/Prototyping-Queue/"
            var names = [Name]()
            
            try Folder(path: mainFolderPath).subfolders.enumerated().forEach { (index, folder) in
                names.append(Name(folder.name))
            }
            
            Name.printTitles(names)
        }
    }
    
    
//    private func
    
}
