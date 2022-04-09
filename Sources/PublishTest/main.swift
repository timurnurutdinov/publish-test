

import Foundation
import Publish
import Plot
import Files




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
    public var name = "tilllur"
    public var description = ""
    public var language: Language { .english }
    public var imagePath: Path? { nil }
    
    public init() {}
}





var scope = Queue(withPath: Queue.production)


try PublishProcess().publish(using: [
    .read(),
//    .readLast(),
    
//    .setScore(),
//    .setProjects(),
    
//    .updatePreviewComponent(),
//    .updateFramerLibrary(),
    
    .publishDynamic(),
//    .publishStatic(),
    
//    .updatePresentationComponent(),
//    .publishPresentation(),

    
//    .findText("query"),
//    .notFoundText(inHTML: "<body></body>"),
    .makeTimestamp()
    ]
)



extension PublishingStep where Site == PublishProcess {
    
    static func read() -> Self {
        .step(named: "Read Prototypes") { context in scope.read() }
    }
    
    static func readLast() -> Self {
        .step(named: "Read Last Prototype") { context in scope.readLast() }
    }
    
    static func updatePreviewComponent() -> Self {
        .step(named: "🔗 Update Preview Component") { context in PreviewComponent().update(for: scope) }
    }
    
    static func publishStatic() -> Self {
        .step(named: "Publish Static Prototypes") { context in scope.publishStatic() }
    }
    
    static func publishDynamic() -> Self {
        .step(named: "Publish Dynamic Prototypes") { context in scope.publishDynamic() }
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
    
    static func findText(inHTML line: String) -> Self {
        .step(named: "🔗 Looking for \"\(line)\"") { context in scope.find(inHTML: line) }
    }
    
    static func notFoundText(inHTML line: String) -> Self {
        .step(named: "🔗 Looking for \"\(line)\"") { context in scope.find(inHTML: line, false) }
    }
    
    static func updatePresentationComponent() -> Self {
        .step(named: "🔗 Update Presentation Component") { context in PresentationComponent().update() }
    }
    
    static func updateFramerLibrary() -> Self {
        .step(named: "🔗 Update Library") { context in UpdateLibrary().update() }
    }
    
    static func publishPresentation() -> Self {
        .step(named: "Publish Presentations") { context in PresentQueue().publish() }
    }
    
    static func makeTimestamp() -> Self {
        .step(named: "Timestamped") { context in Timestamp() }
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
