# ``SwiftHT``

Build HTML and CSS with a small, strongly typed Swift DSL.

## Overview

SwiftHT, short for Swift Hyper Text, lets you compose HTML and CSS with Swift syntax and render the result as compact UTF-8 markup. The package is built around result builders, so markup reads like a tree of Swift function calls instead of manually concatenated strings.

For static websites and generated pages, SwiftHT's main advantage is zero runtime overhead in the delivered site. You generate plain HTML and CSS ahead of time or inside a Swift process, then serve the result directly without requiring PHP request-time template execution or shipping a React runtime and hydration work to the browser. If you choose to generate pages dynamically on each request, SwiftHT has measured generation-time overhead compared with direct manual buffer writes; see <doc:PerformanceNotes> for release benchmark results and interpretation.

```swift
import SwiftHT

let document = HTDocument {
    Html(.lang("en")) {
        Head {
            Title { "SwiftHT Example" }
            Style {
                css("body") {
                    ("font-family", "system-ui")
                    ("margin", "2rem")
                }
            }
        }
        Body {
            Main(.id("content")) {
                H1 { "Hello from SwiftHT" }
                P { "Text content is escaped automatically." }
            }
        }
    }
}

print(document.description)
```

SwiftHT is useful when you want to generate HTML from Swift on the server, in command-line tools, in tests, or anywhere a lightweight markup builder is enough.

## Core Ideas

SwiftHT has a few moving parts:

- ``HTElement`` is the base protocol for anything that can render as HTML.
- ``HTBuilder`` powers the trailing-closure syntax for nested markup.
- ``Tag`` and ``ClosedTag`` implement normal and void HTML elements.
- ``HTAttribute`` represents attributes such as `class`, `id`, and `href`.
- ``CSSElement`` and ``CSSBuilder`` provide the matching CSS DSL.
- ``HTDocument`` adds the HTML doctype before the document content.
- ``BufferedHTWriter`` collects rendered output as UTF-8 bytes.

## Rendering Model

Every element writes itself to an ``HTWriter``. The standard rendering helpers use ``BufferedHTWriter`` internally:

```swift
let html = Div(.class("message")) {
    "Saved"
}.description

let data = hyperData {
    P { "Ready" }
}
```

Strings and numeric values conform to ``HTElement`` and are escaped as text nodes. Attribute values are escaped too. Use ``RawHTML`` only for trusted markup that must bypass escaping.

## Topics

### Getting Started

- <doc:GettingStarted>
- <doc:Tutorial-BuildingYourFirstPage>

### Building Markup

- <doc:BuildingHTML>
- ``HTElement``
- ``HTBuilder``
- ``HTDocument``
- ``Tag``
- ``ClosedTag``
- ``HTAttribute``

### Styling

- <doc:StylingWithCSS>
- ``CSSElement``
- ``CSSBuilder``
- ``CSSProperty``
- ``Css``
- ``css(_:_:content:)``
- ``prop(_:_:)``

### Reuse

- <doc:CreatingComponents>
- ``HTComponent``
- ``CSSComponent``

### Safety, Output, and Performance

- <doc:EscapingAndRawHTML>
- <doc:RenderingOutput>
- <doc:PerformanceNotes>
- <doc:BestPractices>
- ``RawHTML``
- ``writeEncodedHtml(_:to:)``
- ``HTWriter``
- ``BufferedHTWriter``
