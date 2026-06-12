import Foundation
import Testing
@testable import SwiftHT

@Suite("Escaping and Raw HTML Integrity Tests")
struct EscapingAndRawHtmlIntegrityTests {
    @Test("Text and attribute values escape HTML special characters")
    func textAndAttributeValuesEscapeHtmlSpecialCharacters() async throws {
        let entity = Div(.title("5 > 3 & \"quoted\" 'single' <tag>")) {
            "5 > 3 & \"quoted\" 'single' <tag>"
        }

        #expect(entity.description == "<div title=\"5 &gt; 3 &amp; &quot;quoted&quot; &apos;single&apos; &lt;tag&gt;\">5 &gt; 3 &amp; &quot;quoted&quot; &apos;single&apos; &lt;tag&gt;</div>")
    }

    @Test("RawHTML bypasses escaping while neighboring text stays escaped")
    func rawHtmlBypassesEscapingWhileNeighboringTextStaysEscaped() async throws {
        let entity = Div {
            RawHTML("<span data-icon=\"check\"></span>")
            "safe <text>"
        }

        #expect(entity.description == "<div><span data-icon=\"check\"></span>safe &lt;text&gt;</div>")
    }
}

@Suite("Document and Builder Integrity Tests")
struct DocumentAndBuilderIntegrityTests {
    @Test("HTDocument prepends doctype and renders the complete tree")
    func documentPrependsDoctypeAndRendersCompleteTree() async throws {
        let document = HTDocument {
            Html(.lang("en")) {
                Head {
                    Meta(.charset("utf-8"))
                    Title { "Example" }
                }
                Body {
                    Main(.id("content")) {
                        H1 { "Example" }
                    }
                }
            }
        }

        #expect(document.description == "<!doctype html><html lang=\"en\"><head><meta charset=\"utf-8\"/><title>Example</title></head><body><main id=\"content\"><h1>Example</h1></main></body></html>")
    }

    @Test("HTBuilder supports conditionals, optionals, and loops")
    func builderSupportsConditionalsOptionalsAndLoops() async throws {
        let showFeatured = true
        let currentUser: String? = "Ava"
        let items = ["One", "Two", "Three"]

        let entity = Section {
            if showFeatured {
                H2 { "Featured" }
            } else {
                P { "Hidden" }
            }

            if let currentUser {
                Span(.class("user")) { currentUser }
            }

            Ul {
                for item in items {
                    Li { item }
                }
            }
        }

        #expect(entity.description == "<section><h2>Featured</h2><span class=\"user\">Ava</span><ul><li>One</li><li>Two</li><li>Three</li></ul></section>")
    }

    @Test("HTElements fragments and builder arrays render siblings in order")
    func fragmentsAndArraysRenderSiblingContentInOrder() async throws {
        let rows = ["A", "B", "C"]
        let fragment = HTElements {
            Header { "Top" }
            for row in rows {
                P { row }
            }
            Footer { "Bottom" }
        }

        #expect(fragment.description == "<header>Top</header><p>A</p><p>B</p><p>C</p><footer>Bottom</footer>")
    }
}

@Suite("Attribute and Tag Integrity Tests")
struct AttributeAndTagIntegrityTests {
    @Test("Attributes support boolean, custom, escaped, and none values")
    func attributesSupportBooleanCustomEscapedAndNoneValues() async throws {
        let entity = Input(
            .type("checkbox"),
            .name("agree"),
            .checked(),
            .attr("data-label", "Accept & continue"),
            .none
        )

        #expect(entity.description == "<input type=\"checkbox\" name=\"agree\" checked data-label=\"Accept &amp; continue\"/>")
    }

    @Test("Custom Tag and ClosedTag render expected markup")
    func customTagsAndClosedTagsRenderExpectedMarkup() async throws {
        let custom = HTElements {
            Tag(name: "custom-card", .id("featured")) {
                "Custom"
            }
            ClosedTag(name: "custom-icon", .attr("name", "search"))
        }

        #expect(custom.description == "<custom-card id=\"featured\">Custom</custom-card><custom-icon name=\"search\"/>")
    }
}

@Suite("CSS Integrity Tests")
struct CssIntegrityTests {
    @Test("CSSBuilder renders properties, nested rules, and conditionals")
    func cssBuilderRendersPropertiesNestedRulesAndConditionals() async throws {
        let includeDarkMode = true

        let style = Style {
            css("body", prop("margin", "0")) {
                ("font-family", "system-ui")
            }

            if includeDarkMode {
                css("@media (prefers-color-scheme: dark)") {
                    css("body") {
                        ("background", "black")
                        ("color", "white")
                    }
                }
            }

            css("a:hover") {
                ("text-decoration", "underline")
            }
            css("a:focus") {
                ("text-decoration", "underline")
            }
        }

        #expect(style.description == "<style>body{margin:0;font-family:system-ui;}@media (prefers-color-scheme: dark){body{background:black;color:white;}}a:hover{text-decoration:underline;}a:focus{text-decoration:underline;}</style>")
    }
}

@Suite("Component and Type Erasure Integrity Tests")
struct ComponentAndTypeErasureIntegrityTests {
    @Test("HTComponent and CSSComponent render their body content")
    func htmlAndCssComponentsRenderTheirBodies() async throws {
        struct Badge: HTComponent {
            let label: String

            var body: some HTElement {
                Span(.class("badge")) { label }
            }
        }

        struct BadgeStyles: CSSComponent {
            var style: some CSSElement {
                css(".badge") {
                    ("display", "inline-block")
                    ("font-weight", "700")
                }
            }
        }

        let entity = Div {
            Style { BadgeStyles() }
            Badge(label: "New")
        }

        #expect(entity.description == "<div><style>.badge{display:inline-block;font-weight:700;}</style><span class=\"badge\">New</span></div>")
    }

    @Test("AnyHTElement and AnyCSSElement forward rendering")
    func typeErasedElementsAndCssElementsForwardRendering() async throws {
        let element = AnyHTElement(P { "Erased" })
        let style = Style {
            AnyCSSElement(css("p") { ("color", "red") })
        }

        #expect(element.description == "<p>Erased</p>")
        #expect(style.description == "<style>p{color:red;}</style>")
    }
}

@Suite("Output Encoding Integrity Tests")
struct OutputEncodingIntegrityTests {
    @Test("Numeric values render as text nodes")
    func numericElementsRenderAsText() async throws {
        let entity = P {
            "Values: "
            42
            ", "
            Float(3.5)
            ", "
            Double(9.25)
        }

        #expect(entity.description == "<p>Values: 42, 3.5, 9.25</p>")
    }

    @Test("hyperData and BufferedHTWriter produce UTF-8 output")
    func hyperDataAndBufferedWriterProduceUtf8Output() async throws {
        let data = hyperData {
            Div(.class("message")) { "Hello" }
        }

        #expect(String(data: data, encoding: .utf8) == "<div class=\"message\">Hello</div>")

        var writer = BufferedHTWriter(capacity: 8)
        P { "Buffered" }.write(to: &writer)

        #expect(String(bytes: writer.data, encoding: .utf8) == "<p>Buffered</p>")
    }
}
