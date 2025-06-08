/**
*  Publish
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Plot
import Publish

extension Theme where Site == TruthAboutJesusSite {
    /// The default "Foundation" theme that Publish ships with, a very
    /// basic theme mostly implemented for demonstration purposes.
    static var truthAboutJesusTheme: Self {
        Theme(
            htmlFactory: TruthAboutJesusHTMLFactory(),
            resourcePaths: []
        )
    }
}

let translateSymbol = "🌐 "

private struct TruthAboutJesusHTMLFactory: HTMLFactory {

    func makeIndexHTML(for index: Index,
                       context: PublishingContext<TruthAboutJesusSite>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site, stylesheetPaths: context.site.stylesheetPaths),
            .body {
                SiteHeader(context: context, selectedSelectionID: nil)
                Wrapper {
                    Paragraph {
                        Text(translateSymbol)
                        Link("Translate this website with Google", url: TruthAboutJesusSite.TranslateInfo.translateToEnglish)
                    }
                    .class("translate-link no-bottom-space")
                    Paragraph {
                        Text(translateSymbol)
                        Link("用谷歌翻譯這個網站", url: TruthAboutJesusSite.TranslateInfo.translateToChinese)
                    }
                    .class("translate-link bottom-space")
                    H1(index.title)
                        .class("nobreak bottom-space")
                    Paragraph {
                        Text("\"\(context.site.descriptionE.part1)\" ")
                        Text(" \(context.site.descriptionE.part2)")
                            .italic()
                    }
                    Paragraph {
                        Text("\"\(context.site.descriptionT.part1)\"")
                        Text(" \(context.site.descriptionT.part2)")
                            .italic()
                    }
                    .class("description")
                    H2("Recent &nbsp; 最近")
                    ItemList(
                        items: context.allItems(
                            sortedBy: \.date,
                            order: .descending
                        ),
                        site: context.site
                    )
                }
                SiteFooter()
            }
        )
    }

    func makeSectionHTML(for section: Section<TruthAboutJesusSite>,
                         context: PublishingContext<TruthAboutJesusSite>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site, stylesheetPaths: context.site.stylesheetPaths),
            .body {
                SiteHeader(context: context, selectedSelectionID: section.id)
                Wrapper {
                    H1(section.title)
                    ItemList(items: section.items, site: context.site)
                }
                SiteFooter()
            }
        )
    }

    func makeItemHTML(for item: Item<TruthAboutJesusSite>,
                      context: PublishingContext<TruthAboutJesusSite>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site, stylesheetPaths: context.site.stylesheetPaths),
            .body(
                .class("item-page"),
                .components {
                    SiteHeader(context: context, selectedSelectionID: item.sectionID)
                    Wrapper {
                        Article {
                            let translateToEnglish = TruthAboutJesusSite.TranslateInfo.translateLink + "/\(item.sectionID.rawValue)/" + item.metadata.translateLink + TruthAboutJesusSite.TranslateInfo.chineseToEnglish
                            Paragraph {
                                Text(translateSymbol)
                                Link("Translate this page with Google", url: translateToEnglish)
                            }
                            .class("translate-link no-bottom-space")
                            let translateToChinese = TruthAboutJesusSite.TranslateInfo.translateLink + "/\(item.sectionID.rawValue)/" + item.metadata.translateLink + TruthAboutJesusSite.TranslateInfo.englishToChinese
                            Paragraph {
                                Text(translateSymbol)
                                Link("用谷歌翻譯此頁面", url: translateToChinese)
                            }
                            .class("translate-link bottom-space")
                            H1(String(item.title.part1))
                            H1(String(item.title.part2))
                                .class("bottom-space")
                            Div(item.content.body).class("content")
                            Span("Tagged with 標記為: ")
                            ItemTagList(item: item, site: context.site)
                        }
                        .class("article")
                    }
                    .class("wrapper-post")
                    SiteFooter()
                }
            )
        )
    }

    func makePageHTML(for page: Page,
                      context: PublishingContext<TruthAboutJesusSite>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site, stylesheetPaths: context.site.stylesheetPaths),
            .body {
                SiteHeader(context: context, selectedSelectionID: nil)
                Wrapper(page.body)
                SiteFooter()
            }
        )
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<TruthAboutJesusSite>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site, stylesheetPaths: context.site.stylesheetPaths),
            .body {
                SiteHeader(context: context, selectedSelectionID: nil)
                Wrapper {
                    H1("Browse all tags 瀏覽所有標籤")
                        .class("nobreak")
                    List(page.tags.sorted()) { tag in
                        ListItem {
                            Link(tag.string,
                                 url: context.site.path(for: tag).absoluteString
                            )
                        }
                        .class("tag")
                    }
                    .class("all-tags")
                }
                .style("padding-bottom: 30px;")
                SiteFooter()
            }
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<TruthAboutJesusSite>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site, stylesheetPaths: context.site.stylesheetPaths),
            .body {
                SiteHeader(context: context, selectedSelectionID: nil)
                Wrapper {
                    H1 {
                        Text("Tagged with 標記為 ")
                        Span(page.tag.string)/*.class("tag")*/
                    }
                    .class("nobreak")

                    Link("Browse all tags 瀏覽所有標籤",
                        url: context.site.tagListPath.absoluteString
                    )
                    .class("browse-all")

                    ItemList(
                        items: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        site: context.site
                    )
                }
                SiteFooter()
            }
        )
    }
}

private struct Wrapper: ComponentContainer {
    @ComponentBuilder var content: ContentProvider

    var body: Component {
        Div(content: content).class("wrapper")
    }
}

private struct SiteHeader<TruthAboutJesusSite: Website>: Component {
    var context: PublishingContext<TruthAboutJesusSite>
    var selectedSelectionID: TruthAboutJesusSite.SectionID?

    var body: Component {
        Header {
            Wrapper {
                Link(context.site.name, url: "/")
                    .class("site-name")

                if TruthAboutJesusSite.SectionID.allCases.count > 1 {
                    navigation
                }
            }
        }
    }

    private var navigation: Component {
        Navigation {
            List(TruthAboutJesusSite.SectionID.allCases) { sectionID in
                let section = context.sections[sectionID]

                return Link(section.title,
                    url: section.path.absoluteString
                )
                .class(sectionID == selectedSelectionID ? "selected" : "")
            }
        }
    }
}

private struct ItemList<TruthAboutJesusSite: Website>: Component {
    var items: [Item<TruthAboutJesusSite>]
    var site: TruthAboutJesusSite

    var body: Component {
        List(items) { item in
            Article {
                H1(Link(item.title.part1, url: item.path.absoluteString))
                H1(Link(item.title.part2, url: item.path.absoluteString))
                ItemTagList(item: item, site: site)
                if item.description != "?" {
                    let splitDescription = item.description.components(separatedBy: "  ")
                    Paragraph(splitDescription[0])
                    H6("&nbsp;")
                    Paragraph(splitDescription[1])
                        .class("description")
                }
            }
        }
        .class("item-list")
    }
}

private struct ItemTagList<TruthAboutJesusSite: Website>: Component {
    var item: Item<TruthAboutJesusSite>
    var site: TruthAboutJesusSite

    var body: Component {
        List(item.tags) { tag in
            Link(tag.string, url: site.path(for: tag).absoluteString)
        }
        .class("tag-list")
    }
}

private struct SiteFooter: Component {
    
    var body: Component {
        Footer {
            Paragraph {
                Text(translateSymbol)
                Link("Translate this website with Google", url: TruthAboutJesusSite.TranslateInfo.translateToEnglish)
            }
            Paragraph {
                Text(translateSymbol)
                Link("用谷歌翻譯這個網站", url: TruthAboutJesusSite.TranslateInfo.translateToChinese)
            }
            Paragraph {
                Link("Generated using 使用生成的 Publish", url: "https://github.com/johnsundell/publish")
            }
            Paragraph {
                Link("English font 英語字型: OpenDyslexic-Alta", url: "https://opendyslexic.org" )
            }
            Paragraph {
                Link("RSS feed 提要", url: "/feed.rss")
            }
            Paragraph {
                Text("© ")
                Text("Jesus of Nazareth, Messiah, Son of God, Son of Man, Creator, Sustainer and Ruler of the Universe.")
            }
            .style("margin-bottom: 40px;")
        }
        .class("translate-link")
    }
}

