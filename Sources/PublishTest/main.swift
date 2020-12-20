

import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct PublishTest: Website {
    enum SectionID: String, WebsiteSectionID {
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://your-website-url.com")!
    var name = "Is it for me?"
    var description = "A description of PublishTest"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try PublishTest().publish(using: [
    .addMarkdownFiles(),
    .copyResources(at: "Content"),
//    .addFavoriteItems(),
//    .addDefaultSectionTitles(),
    .generateHTML(withTheme: .foundation),
    
    
//    .generateHTML(withTheme: .foundation),
//    .deploy(using: .gitHub("    timurnurutdinov/timurnurutdinov.github.io", useSSH: false))
    ]
)
