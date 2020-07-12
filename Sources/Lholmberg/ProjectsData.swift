import Foundation
import Plot

class ProjectData {
    // Data for each project on /projects
    private(set) var title: Node<HTML.BodyContext>
    private(set) var img1: String
    private(set) var img2: String
    private(set) var img3: String
    private(set) var desc: Node<HTML.BodyContext>
    private(set) var link: String
    
    init(title: Node<HTML.BodyContext>, img1: String, img2: String, img3: String, desc: Node<HTML.BodyContext>, link: String) {
        self.title = title
        self.img1 = img1
        self.img2 = img2
        self.img3 = img3
        self.desc = desc
        self.link = link
    }
}

struct Projects {
    let data = [
        ProjectData(title: "Job Finder", img1: "../jobPoster1.png", img2: "../jobfinder_home1.png", img3: "../jobSearcher2.png", desc: "iOS application that allows people who are looking for a quick job (e.g. mow someone’s lawn) to easily find available jobs in the vicinity. If you are someone that is looking to hire, you can create a special account that allows you to post jobs.", link: "https://github.com/LHolmberg/job-finder"),
            
        ProjectData(title: "Tic Tac Toe (Multiplayer)", img1: "../tictactoe_home.png", img2: "../ticinvite.png", img3: "../ticinvites.png", desc: "iOS application that is a multiplayer Tic Tac Toe game. You create an account and then you are able to invite other people to a new game using their created username. Once you have invited a person and they accepted, you can play tic tac toe in real-time.", link: "https://github.com/LHolmberg/tic-tac-toe-iOS"),
            
        ProjectData(title: "Sorting Visualizer", img1: "../vs1.png", img2: "../vsMain.png", img3: "../vs2.png", desc: "iOS application that allows the user to visualize 4 different sorting algorithms (shell, bubble, selection & bogo-sort).", link: "https://github.com/LHolmberg/sorting-visualizer"),
            
        ProjectData(title: "Life", img1: "../lf1.png", img2: "../lf3.png", img3: "../lf5.png", desc: "iOS application that includes: Calorie diary (fetches food and their nutritional values from an API and then presents your current daily intake), To-Do list and a section for taking Notes.", link: "https://github.com/LHolmberg/life"),
            
        ProjectData(title: "Försäkringskunskap", img1: "../fs1.png", img2: "../fs2.png", img3: "../fs3.png", desc: "iOS application published for Försäkringskunskap AB that help enrolled students through including a forum section to get in touch with the course holder, study material and a section for testing your knowledge (related to the course).", link: ""),
            
        ProjectData(title: "Imagefinder", img1: "../ifHome.png", img2: "../ifDrop.png", img3: "../ifFeed.png", desc: "iOS application that fetches and show randomized pictures from pixabays API. The user can then either like/dislike the picture and the liked pictures are saved and presented in a feed-like manner.", link: "https://github.com/LHolmberg/imagefinder")
        ]
}
