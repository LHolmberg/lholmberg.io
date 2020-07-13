import Foundation
import Publish
import Plot

// site config
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

// allows me to sequentially create n amounts of html (project) elements
private extension Node where Context == HTML.BodyContext {
    static func projectList<T: Website>(for item: ProjectData, on site: T) -> Node {
        return .div(.class("thecard"),
                    .div(.class("card-img"), .img(.src(item.img1)), .img(.src(item.img2)), .img(.src(item.img3))),
            .div(.class("card-caption"),
                 .i(.id("like-btn"), .class("fa fa-thumbs-o-up"), .a("GitHub", .href(item.link), .target(HTMLAnchorTarget.blank))),
                .h1(item.title),
                .p(item.desc)
            )
        )
    }
}

struct SiteHTMLFactory<Site: Website>: HTMLFactory {
    // "index.html"
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
                        .a("CV (pdf)", .href("../LukasHolmberg_CV.pdf"), .class("links"))
                    )
                )
            )
        )
    }
    // "projects.html"
    var projectsData = Projects().data
    func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .head(for: section, on: context.site),
            .body(
                .class("projects"),
                .div(.class("topnav"), .id("myTopnav"),
                    .a("LHolmberg", .href("/"), .id("logo")),
                    .a("Projects", .href("/"), .class("active"))
                ),
                .h1("Projects", .class("projectsTitle")),
                .forEach(projectsData) { data in
                    .projectList(for: data, on: context.site)
                }
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
        Theme(htmlFactory: SiteHTMLFactory(), resourcePaths: ["Resources/Theme/styles.css",
                                                              "Resources/Theme/jobfinder_home1.png",
                                                              "Resources/Theme/tictactoe_home.png",
                                                              "Resources/Theme/ifHome.png",
                                                              "Resources/Theme/lf1.png",
                                                              "Resources/Theme/vsMain.png",
                                                              "Resources/Theme/fs1.png",
                                                              "Resources/Theme/vs1.png",
                                                              "Resources/Theme/vs2.png",
                                                              "Resources/Theme/fs2.png",
                                                              "Resources/Theme/fs3.png",
                                                              "Resources/Theme/lf3.png",
                                                              "Resources/Theme/lf5.png",
                                                              "Resources/Theme/ifFeed.png",
                                                              "Resources/Theme/ifDrop.png",
                                                              "Resources/Theme/jobSearcher2.png",
                                                              "Resources/Theme/jobPoster1.png",
                                                              "Resources/Theme/ticinvites.png",
                                                              "Resources/Theme/ticsignin.png",
                                                              "Resources/Theme/ticinvite.png",
                                                              "Resources/Theme/LukasHolmberg_CV.pdf"])
    }
}

try LHolmberg().publish(withTheme: .LHTheme, deployedUsing: .git("ssh://git@github.com:LHolmberg/lholmberg.github.io.git"))
