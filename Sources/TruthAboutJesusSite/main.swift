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
    var url = URL(string: "https://truth-about-jesus.github.io")!
    var name = "The Truth about Jesus &nbsp; 關於耶穌的真相"
    let descriptionE = "...things into which angels long to look.  (1 Peter 1:12 ESV)"
    let descriptionT = "天使也渴想能知道一點。  (1 Peter 1:12 Chinese NET (T))"
    var description: String {
        "\(descriptionE) -- in traditional Chinese and English. \(descriptionT) -- 用繁體中文和英語。"
    }
    var translateLink = "https://truth--about--jesus-github-io.translate.goog"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try TruthAboutJesusSite().publish(withTheme: .truthAboutJesusTheme)


// helps with breaking up strings containing translation (or verse and reference) with 2 spaces between the 2 parts
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

// this func from Publish API PlotComponents.swift generates the html header
extension Node where Context == HTML.DocumentContext {
    static func head<T: Website>(
        for location: Location,
        on site: T,
        titleSeparator: String = " | ",
        // changed stylesheetPath to include ?version=0 so that stylesheet will be refreshed by client browsers, not just use old cached stylesheet
        stylesheetPaths: [Path] = ["/styles.css?version=22"],
//        stylesheetPaths: [Path] = ["/styles.css"],
        rssFeedPath: Path? = .defaultForRSSFeed,
        rssFeedTitle: String? = nil
    ) -> Node {
        var title = location.title

        if title.isEmpty {
            title = site.name
        } else {
            title.append(titleSeparator + site.name)
        }

        var description = location.description

        if description.isEmpty {
            description = site.description
        }

        return .head(
            .encoding(.utf8),
            .siteName(site.name),
            .url(site.url(for: location)),
            .title(title),
            .description(description),
            .twitterCardType(location.imagePath == nil ? .summary : .summaryLargeImage),
            .forEach(stylesheetPaths, { .stylesheet($0) }),
            .viewport(.accordingToDevice),
//            .script(.src("/scripts/test.js")),
            .unwrap(site.favicon, { .favicon($0) }),
            .unwrap(rssFeedPath, { path in
                let title = rssFeedTitle ?? "Subscribe to \(site.name)"
                return .rssFeedLink(path.absoluteString, title: title)
            }),
            .unwrap(location.imagePath ?? site.imagePath, { path in
                let url = site.url(for: path)
                return .socialImageLink(url)
            })
        )
    }

}

