# Getting Started

Create and render HTML with SwiftHT's result-builder DSL.

## Import the Library

Add SwiftHT as a dependency in your package or app, then import it where you generate markup.

```swift
import SwiftHT
```

## Create a Fragment

A fragment is any ``HTElement``. Tags are ordinary Swift functions whose trailing closures contain child content.

```swift
let message = Div(.class("notice")) {
    Strong { "Success" }
    ": your changes were saved."
}

print(message.description)
// <div class="notice"><strong>Success</strong>: your changes were saved.</div>
```

## Create a Complete Document

Use ``HTDocument`` when you want the output to start with `<!doctype html>`.

```swift
let page = HTDocument {
    Html(.lang("en")) {
        Head {
            Meta(.charset("utf-8"))
            Title { "Dashboard" }
        }
        Body {
            Main {
                H1 { "Dashboard" }
                P { "Generated with SwiftHT." }
            }
        }
    }
}

let html = page.description
```

## Add Attributes

Pass attributes before the content builder.

```swift
A(.href("/docs"), .class("nav-link")) {
    "Documentation"
}
```

Attributes are rendered in the order you pass them:

```html
<a href="/docs" class="nav-link">Documentation</a>
```

## Add CSS

Use ``Style(_:_:)`` with ``css(_:_:content:)`` rules.

```swift
Style {
    css(".nav-link") {
        ("color", "rebeccapurple")
        ("text-decoration", "none")
    }
}
```

This renders compact CSS:

```css
.nav-link{color:rebeccapurple;text-decoration:none;}
```

## Render to Data

Use ``hyperData(capacity:content:)`` when you need UTF-8 bytes instead of a `String`.

```swift
let responseBody = hyperData {
    HTDocument {
        Html {
            Body { "Hello" }
        }
    }
}
```

## Next Steps

Read <doc:BuildingHTML> for control flow, loops, custom tags, and raw fragments. Then read <doc:StylingWithCSS> for the CSS builder.
