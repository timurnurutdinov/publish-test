

import Foundation
import Publish
import Plot
import Files



public struct Test {
    public func test() -> String { return "wow2" }
    public init() {}
}


// This type acts as the configuration for your website.
public struct PublishProcess: Website {
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




let mainQueue = "~/Documents/Git/Prototyping-Queue/"
let testQueue = "~/Documents/testing-queue/"

var scope = Queue(withPath: mainQueue)





try PublishProcess().publish(using: [
    .read(),
//    .setScore(),
//    .setProjects(),
    
//    .publish(),
//    .publishPresentation(),

    
    .findText("originX"),
//    .updatePComponent(),
    ]
)




extension PublishingStep where Site == PublishProcess {
    
    static func read() -> Self {
        .step(named: "Read Prototypes") { context in
            try Folder(path: scope.path).subfolders.enumerated().forEach { (index, folder) in
                scope.add(Prototype(withFolder: folder))
            }
        }
    }
    
    static func publish() -> Self {
        .step(named: "Publish Prototypes") { context in scope.publish() }
    }
    
    
    
    
    static func setScore() -> Self {
        .step(named: "Get Score") { context in scope.setScore() }
    }
    
    static func setProjects() -> Self {
        .step(named: "🔗 Get Project List") { context in scope.getProjectlist() }
    }
    
    static func findText(_ line: String) -> Self {
        .step(named: "🔗 Looking for \"\(line)\"") { context in scope.find(line) }
    }
    
    static func updatePComponent() -> Self {
        .step(named: "🔗 Update PComponent") { context in PresentationComponent().update() }
    }
    
    static func publishPresentation() -> Self {
        .step(named: "Publish Presentations") { context in PresentQueue().publish() }
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
