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
    
    let stylesheetPaths: [Path] = ["/styles.css?version=22"]
    
    struct TranslateInfo {
        static let translateLink = "https://truth--about--jesus-github-io.translate.goog"
        static let chineseToEnglish = "/?_x_tr_sl=zh-TW&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=wapp"
        static let englishToChinese = "/?_x_tr_sl=en&_x_tr_tl=zh-TW&_x_tr_hl=zh-TW&_x_tr_pto=wapp"
        static var translateToEnglish: String {
            translateLink + chineseToEnglish
        }
        static var translateToChinese: String {
            translateLink + englishToChinese
        }
    }
    
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try TruthAboutJesusSite().publish(withTheme: .truthAboutJesusTheme)

var home: String = ""
if #available(macOS 13.0, *) {
    home = FileManager.default.homeDirectoryForCurrentUser.path()
    print("home using path(): " + home)
} else {
    home = FileManager.default.homeDirectoryForCurrentUser.path
}

let originPath =
home + "Library/Mobile Documents/com~apple~CloudDocs/Websites/truth-about-Jesus.github.io/Output"
let targetPath = home + "Library/Mobile Documents/com~apple~CloudDocs/Websites/truth-about-Jesus.github.io/docs"
print("origin: " + originPath)
print("target: " + targetPath)

try FileManager.default.removeItem(atPath: targetPath)
try FileManager.default.copyItem(atPath: originPath, toPath: targetPath)


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
