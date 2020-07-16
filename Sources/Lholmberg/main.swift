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
                                                              "Resources/Theme/Images/jobfinder_home1.png",
                                                              "Resources/Theme/Images/tictactoe_home.png",
                                                              "Resources/Theme/Images/ifHome.png",
                                                              "Resources/Theme/Images/lf1.png",
                                                              "Resources/Theme/Images/vsMain.png",
                                                              "Resources/Theme/Images/fs1.png",
                                                              "Resources/Theme/Images/vs1.png",
                                                              "Resources/Theme/Images/vs2.png",
                                                              "Resources/Theme/Images/fs2.png",
                                                              "Resources/Theme/Images/fs3.png",
                                                              "Resources/Theme/Images/lf3.png",
                                                              "Resources/Theme/Images/lf5.png",
                                                              "Resources/Theme/Images/ifFeed.png",
                                                              "Resources/Theme/Images/ifDrop.png",
                                                              "Resources/Theme/Images/jobSearcher2.png",
                                                              "Resources/Theme/Images/jobPoster1.png",
                                                              "Resources/Theme/Images/ticinvites.png",
                                                              "Resources/Theme/Images/ticsignin.png",
                                                              "Resources/Theme/Images/ticinvite.png",
                                                              "Resources/Theme/LukasHolmberg_CV.pdf"])
    }
}

try LHolmberg().publish(withTheme: .LHTheme, deployedUsing: .git("ssh://git@github.com:LHolmberg/lholmberg.github.io.git"))
