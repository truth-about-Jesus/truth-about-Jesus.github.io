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
            htmlFactory: TruthAboutJesusTheme(),
            resourcePaths: ["Resources/css/styles.css"]
        )
    }
}

let translateSymbol = "🌐 "

private struct TruthAboutJesusTheme: HTMLFactory {

    func makeIndexHTML(for index: Index,
                       context: PublishingContext<TruthAboutJesusSite>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body {
                SiteHeader(context: context, selectedSelectionID: nil)
                Wrapper {
                    H1(index.title)
                        .class("nobreak")
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
                    H2("posts &nbsp; 帖子")
                    ItemList(
                        items: context.allItems(
                            sortedBy: \.date,
                            order: .ascending
                        ),
                        site: context.site
                    )
                }
                SiteFooter(translate0: context.site.translateLink)
            }
        )
    }

    func makeSectionHTML(for section: Section<TruthAboutJesusSite>,
                         context: PublishingContext<TruthAboutJesusSite>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body {
                SiteHeader(context: context, selectedSelectionID: section.id)
                Wrapper {
                    H1(section.title)
                    ItemList(items: section.items, site: context.site)
                }
                SiteFooter(translate0: context.site.translateLink)
            }
        )
    }

    func makeItemHTML(for item: Item<TruthAboutJesusSite>,
                      context: PublishingContext<TruthAboutJesusSite>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .class("item-page"),
                .components {
                    SiteHeader(context: context, selectedSelectionID: item.sectionID)
                    Wrapper {
                        Article {
                            let translateLink = context.site.translateLink + item.metadata.translateLink
                            Paragraph {
                                Text(translateSymbol)
                                Link("Translate this page with Google", url: translateLink)
                            }
                            .class("translate-link no-bottom-space")
                            Paragraph {
                                Text(translateSymbol)
                                Link("用谷歌翻譯此頁面", url: translateLink)
                            }
                            .class("translate-link bottom-space")
                            H1(String(item.title.part1))
                            H1(String(item.title.part2))
                                .class("bottom-space")
                            Div(item.content.body).class("content")
                            Span("Tagged with 標記為: ")
                            ItemTagList(item: item, site: context.site)
                        }
                    }
                    SiteFooter(translate0: context.site.translateLink)
                }
            )
        )
    }

    func makePageHTML(for page: Page,
                      context: PublishingContext<TruthAboutJesusSite>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body {
                SiteHeader(context: context, selectedSelectionID: nil)
                Wrapper(page.body)
                SiteFooter(translate0: context.site.translateLink)
            }
        )
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<TruthAboutJesusSite>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
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
                SiteFooter(translate0: context.site.translateLink)
            }
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<TruthAboutJesusSite>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
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
                SiteFooter(translate0: context.site.translateLink)
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
                let splitDescription = item.description.components(separatedBy: "  ")
                Paragraph(splitDescription[0])
                H6("&nbsp;")
                Paragraph(splitDescription[1])
                    .class("description")
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

    var translate0: String

    private var translateLink: String {
        "\(translate0)/?_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=wapp"
    }

    var body: Component {
        Footer {
            Paragraph {
                Text(translateSymbol)
                Link("Translate this website with Google", url: translateLink)
            }
            Paragraph {
                Text(translateSymbol)
                Link("用谷歌翻譯這個網站", url: translateLink)
            }
            Paragraph {
                Link("Generated using 使用生成的 Publish", url: "https://github.com/johnsundell/publish")
            }
            Paragraph {
                Link("RSS feed 提要", url: "/feed.rss")
            }
            .style("margin-bottom: 40px;")
        }
    }
}

