import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct EnglishSite: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://singular-niche.github.io")!
    var name = "Jesus"
    var description = "the truth about Jesus"
    var language: Language { .english }
    var imagePath: Path? { nil }
}



// This will generate your website using the built-in Foundation theme:
try EnglishSite().publish(withTheme: .myTheme)
//try EnglishSite()
//    .publish(using: [
//        .addMarkdownFiles(),
//        .copyResources(),
//        .generateHTML(withTheme: .myTheme),
//        .generateRSSFeed(including: [.posts]),
//        .generateSiteMap(),
//        .deploy(using: .gitHub("singular-niche/singular-niche.github.io",
//                               branch: "main",
//                               useSSH: false)
//        )
//    ])
