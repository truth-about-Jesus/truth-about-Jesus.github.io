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
        var translateLink: String
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://truthaboutjesus.github.io")!
    var name = "the truth about Jesus &nbsp; 關於耶穌的真相"
    let descriptionE = "...things into which angels long to look.  (1 Peter 1:12 ESV)"
    let descriptionT = "天使也渴想能知道一點。  (1 Peter 1:12 Chinese NET (T))"
    var description: String {
        "\(descriptionE) -- in traditional Chinese and English. \(descriptionT) -- 用繁體中文和英語。"
    }
    var language: Language { .english }
    var imagePath: Path? { nil }
}


extension String {

    var doubleSpaceArray: [String] {
        self.components(separatedBy: "  ")
    }

    var part1: String {
        return doubleSpaceArray[0]
    }

    var part2: String {
        return doubleSpaceArray[1]
    }
}


// This will generate your website using the built-in Foundation theme:
try TruthAboutJesusSite().publish(withTheme: .truthAboutJesusTheme)
