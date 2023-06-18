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
            resourcePaths: ["Resources/MyTheme/styles.css"]
        )
    }
}

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
//                    Paragraph(context.site.description)
                    Paragraph {
                        Text("\"...things into which angels long to look.\" ")
                        Text(" (1 Peter 1:12 ESV)")
                            .italic()
                    }
                    Paragraph {
                        Text("\"天使也渴想能知道一點。\"")
                        Text(" (1 Peter 1:12 Chinese NET (T))")
                            .italic()
                    }
                        .class("description")
                    H2("posts &nbsp; 帖子")
                    List(context.allItems(sortedBy: \.date, order: .ascending)) { item in
                        Article {
                            H1(Link(item.metadata.titleE, url: item.path.absoluteString))
                            H1(Link(item.metadata.titleT, url: item.path.absoluteString))
                            ItemTagList(item: item, site: context.site)
                            Paragraph(item.metadata.descriptionE)
                            H6("&nbsp;")
                            Paragraph(item.metadata.descriptionT)
                                .class("description")
                        }
                    }
                    .class("item-list")
                }
                SiteFooter()
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
                SiteFooter()
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
                            Div(item.content.body).class("content")
                            Span("Tagged with 標記為: ")
                            ItemTagList(item: item, site: context.site)
                        }
                    }
                    SiteFooter()
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
                SiteFooter()
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
                SiteFooter()
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
                        Span(page.tag.string).class("tag")
                    }

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
                H1(Link(item.title, url: item.path.absoluteString))
                ItemTagList(item: item, site: site)
                Paragraph(item.description)
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
    var body: Component {
        Footer {
            Paragraph {
                Text("🌐 ")
                Link("Translate this website with Google", url: "https://truthaboutjesus-github-io.translate.goog/?_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=wapp")
            }
            Paragraph {
                Text("🌐 ")
                Link("用谷歌翻譯這個網站", url: "https://truthaboutjesus-github-io.translate.goog/?_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=wapp")
            }
            Paragraph {
                Text("Generated using 使用生成的 ")
                Link("Publish", url: "https://github.com/johnsundell/publish")
            }
            Paragraph {
                Link("RSS feed 提要", url: "/feed.rss")
            }
        }
    }
}
