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
    var url = URL(string: "https://your-website-url.com")!
    var name = "Jesus cares..."
    var description = "“When he saw the crowds, he felt sorry for them, because they were exhausted and scattered, like sheep without a shepherd.” (Matthew 9:36)"
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
