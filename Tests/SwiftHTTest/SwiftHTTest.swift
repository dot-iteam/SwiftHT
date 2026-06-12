import Testing
@testable import SwiftHT

@Suite("Smoke Rendering Tests")
struct SmokeRenderingTests {
    @Test("Basic nested HTML and CSS renders compact output")
    func basicNestedHtmlAndCssRendersCompactOutput() async throws {
        let entity : some HTElement = Div {
            Style {
                css("button") {
                    ("background", "white")
                }
            }
            Button(.title("Click me")) {
                "Button"
            }
        }

        #expect(entity.description == "<div><style>button{background:white;}</style><button title=\"Click me\">Button</button></div>")
    }

    @Test("Corrected attribute helpers use expected HTML names")
    func correctedAttributeHelpersUseExpectedHtmlNames() async throws {
        #expect(Div(.accessKey("k")) { "Shortcut" }.description == "<div accesskey=\"k\">Shortcut</div>")
        #expect(Div(.slot("header")) { "Header" }.description == "<div slot=\"header\">Header</div>")
    }

    @Test("HTML void tag helpers render closed tags")
    func htmlVoidTagHelpersRenderClosedTags() async throws {
        let entity: some HTElement = HTElements {
            Area(.href("/map"))
            Base(.href("/"))
            Embed(.src("movie.mp4"))
            Source(.src("clip.mp4"))
            Track(.src("captions.vtt"))
            Wbr()
        }

        #expect(entity.description == "<area href=\"/map\"/><base href=\"/\"/><embed src=\"movie.mp4\"/><source src=\"clip.mp4\"/><track src=\"captions.vtt\"/><wbr/>")
    }
}
