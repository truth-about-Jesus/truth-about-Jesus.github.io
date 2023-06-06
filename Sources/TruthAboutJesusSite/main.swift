import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct TruthAboutJesusSite: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
        var title2: String?
        var description2: String?
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://truthaboutjesus.github.io")!
    var name = "the truth about Jesus &nbsp; 關於耶穌的真相"
    var description = "...things into which angels long to look. (1 Peter 1:12 ESV) -- in traditional Chinese and English"
    var language: Language { .english }
    var imagePath: Path? { nil }
}



// This will generate your website using the built-in Foundation theme:
try TruthAboutJesusSite().publish(withTheme: .truthAboutJesusTheme)
//try TruthAboutJesusSite()
//    .publish(using: [
//        .addMarkdownFiles(),
//        .copyResources(),
//        .generateHTML(withTheme: .truthAboutJesusTheme),
//        .generateRSSFeed(including: [.posts]),
//        .generateSiteMap(),
//        .deploy(using: .gitHub("truthaboutjesus/truthaboutjesus.github.io",
//                               branch: "main",
//                               useSSH: false)
//        )
//    ])
