import Foundation
import Publish
import Plot

struct LHolmberg: Website {
    enum SectionID: String, WebsiteSectionID {
        case projects
    }
    struct ItemMetadata: WebsiteItemMetadata {}
    var url = URL(string: "https://your-website-url.com")!
    var name = "LHolmberg"
    var description = "Lukas Holmbergs portfolio"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

struct SiteHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .head(for: index, on: context.site),
            .body(
                .section(
                    .id("banner"),
                    .div(
                        .class("inner"),
                        .h1("Lukas Holmberg"),
                        .a("19 years old with a burning interest in software development, physics and fitness."),
                        .br(),
                        .br(),
                        .br(),
                        .a("Projects", .href("projects"), .class("links")),
                        .a("CV (pdf)", .href("ds"), .class("links"))
                    )
                )
            )
        )
    }

    func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .head(for: section, on: context.site),
            .body(
                .class("projects"),
                .div(.class("topnav"), .id("myTopnav"),
                    .a("LHolmberg", .href("/"), .id("logo")),
                    .a("Projects", .href("/"), .class("active")),
                    .a("CV", .href("/"))
                ),
                .h1("Projects", .class("projectsTitle")),
                .div(.class("thecard"),
                    .div(.class("card-img"), .img(.src("../feed.png"))),
                    .div(.class("card-caption"),
                        .i(.id("like-btn"), .class("fa fa-thumbs-o-up"), .a("More Info", .href("https://github.com/LHolmberg/job-finder"), .target(HTMLAnchorTarget.blank))),
                        .h1("Job Finder"),
                        .p("iOS application that allows people who are looking for a quick job (e.g. mow someone’s lawn) to easily find available jobs in the vicinity. If you are someone that is looking to hire, you can create a special account that allows you to post jobs.")
                    )
                ),
                .div(.class("thecard"),
                    .div(.class("card-img"), .img(.src("../ticmain.png"))),
                    .div(.class("card-caption"),
                         .i(.id("like-btn"), .class("fa fa-thumbs-o-up"), .a("More Info")),
                        .h1("Tic Tac Toe (Multiplayer)"),
                        .p("iOS application that is a multiplayer Tic Tac Toe game. You create an account and then you are able to invite other people to a new game using their created username. Once you have invited a person and they accepted, you can play tic tac toe in real-time.")
                    )
                )
            )
        )
    }
    
    func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .head(for: item, on: context.site)
        )
    }
    
    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        try makeIndexHTML(for: context.index, context: context)
    }
    
    func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? {
        nil
    }
    
    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Site>) throws -> HTML? {
        nil
    }
}

extension Theme {
    static var LHTheme: Theme {
        Theme(htmlFactory: SiteHTMLFactory(), resourcePaths: ["Resources/Theme/styles.css", "Resources/Theme/feed.png", "Resources/Theme/ticmain.png"])
    }
}

try LHolmberg().publish(withTheme: .LHTheme)
