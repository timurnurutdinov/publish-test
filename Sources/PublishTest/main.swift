

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
                Prototype(withFolder: folder)
            }
            
            let sortedModuleNames = Prototype.moduleNames.sorted { $0.1 > $1.1 }
            let moduleFilterMap = Prototype.getModulesToSkipMap()
            print(moduleFilterMap)
            
            let customModulesOnly = sortedModuleNames.filter { moduleFilterMap[$0.key] != 1 }
            
            for (key, value) in customModulesOnly {
                print("\(key): \(value)")
//                print("\(Prototype.modulesPathMap[key]!)")
            }
            
            
            Prototype.computeZScore()
//            
//            
//            
//            let isoDate = "2016-04-14"
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//            let date = dateFormatter.date(from:isoDate)! + 60 * 180
//            print(date)
//            
//
//            
//            
//            let temp3 = prototypes.map { String(format: "%.2f", $0.difficulty) }
//            Prototype.writeCSV(ofPrototypes: temp3, withName: "difficulty.txt")
            
        }
    }
    
    
    
    static func testSurge() -> Self {
        .step(named: "testSurge") { context in
            SurgeTest()
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
