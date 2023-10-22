//
//  Extensions.swift
//  
//
//  Created by Enid Ning on 2023-10-01.
//

import Foundation
//import Plot
//import Publish

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

// this func from Publish API PlotComponents.swift generates the html head for every page -- place to make changes to <head>
//extension Node where Context == HTML.DocumentContext {
//    static func head<T: Website>(
//        for location: Location,
//        on site: T,
//        titleSeparator: String = " | ",
//        // changed stylesheetPath to include ?version=0 so that stylesheet will be refreshed by client browsers, not just use old cached stylesheet
//        stylesheetPaths: [Path] = ["/styles.css?version=22"],
//        stylesheetPaths: [Path] = ["/styles.css"],
//        rssFeedPath: Path? = .defaultForRSSFeed,
//        rssFeedTitle: String? = nil
//    ) -> Node {
//        var title = location.title
//
//        if title.isEmpty {
//            title = site.name
//        } else {
//            title.append(titleSeparator + site.name)
//        }
//
//        var description = location.description
//
//        if description.isEmpty {
//            description = site.description
//        }
//
//        return .head(
//            .encoding(.utf8),
//            .siteName(site.name),
//            .url(site.url(for: location)),
//            .title(title),
//            .description(description),
//            .twitterCardType(location.imagePath == nil ? .summary : .summaryLargeImage),
//            .forEach(stylesheetPaths, { .stylesheet($0) }),
//            .viewport(.accordingToDevice),
////            .script(.src("/scripts/test.js")),
//            .unwrap(site.favicon, { .favicon($0) }),
//            .unwrap(rssFeedPath, { path in
//                let title = rssFeedTitle ?? "Subscribe to \(site.name)"
//                return .rssFeedLink(path.absoluteString, title: title)
//            }),
//            .unwrap(location.imagePath ?? site.imagePath, { path in
//                let url = site.url(for: path)
//                return .socialImageLink(url)
//            })
//        )
//    }
//
//}

