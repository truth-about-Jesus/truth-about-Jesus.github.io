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
    var url = URL(string: "https://truthaboutjesus.github.io")!
    var name = "the truth about Jesus &nbsp; 關於耶穌的真相"
    var description = "...things into which angels long to look. (1 Peter 1:12 ESV) -- in traditional Chinese and English"
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
//        .deploy(using: .gitHub("truthaboutjesus/truthaboutjesus.github.io",
//                               branch: "main",
//                               useSSH: false)
//        )
//    ])
