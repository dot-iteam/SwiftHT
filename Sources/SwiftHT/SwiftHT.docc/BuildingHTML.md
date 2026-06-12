# Building HTML

Compose tags, attributes, text, loops, and conditionals with Swift syntax.

## Tags

Most HTML elements are exposed as Swift functions. Non-void elements accept attributes followed by a trailing ``HTBuilder`` closure.

```swift
Article(.class("post")) {
    Header {
        H1 { "Release Notes" }
        P(.class("summary")) { "A compact summary of the release." }
    }
    Section {
        H2 { "Changes" }
        P { "The markup is built with ordinary Swift expressions." }
    }
}
```

Void elements return ``ClosedTag`` and do not accept child content:

```swift
Img(.src("/logo.png"), .alt("Company logo"))
Input(.type("email"), .name("email"), .required())
Br()
```

## Text Nodes

`String`, `Int`, `Float`, and `Double` conform to ``HTElement``. You can place them directly in builders.

```swift
P {
    "Total: "
    42
}
```

Text is escaped automatically. For example, `<script>` in a string renders as `&lt;script&gt;`.

## Attributes

Use ``HTAttribute`` helpers for common HTML attributes.

```swift
Button(.type("submit"), .class("primary"), .title("Save changes")) {
    "Save"
}
```

Use `.single("name")` for custom boolean attributes and `.attr("name", "value")` for custom name/value attributes.

```swift
Div(.attr("data-controller", "menu"), .single("hidden")) {
    "Menu"
}
```

## Conditional Content

`HTBuilder` supports `if`, `if let`, and `if`/`else`.

```swift
let isSignedIn = true
let displayName: String? = "Sam"

Nav {
    A(.href("/")) { "Home" }

    if isSignedIn {
        A(.href("/account")) { "Account" }
    } else {
        A(.href("/sign-in")) { "Sign in" }
    }

    if let displayName {
        Span(.class("user")) { displayName }
    }
}
```

## Loops

Use `for` loops to render repeated elements.

```swift
let links = [
    ("Home", "/"),
    ("Docs", "/docs"),
    ("Support", "/support")
]

Ul(.class("nav")) {
    for link in links {
        Li {
            A(.href(link.1)) { link.0 }
        }
    }
}
```

## Fragments

Use ``HTElements(content:)`` to build a fragment without wrapping it in another tag.

```swift
let rows = HTElements {
    Tr { Td { "A" } }
    Tr { Td { "B" } }
}
```

Fragments are useful in tests and helper functions that return several sibling elements.

## Custom Tags

Use ``Tag`` when the package does not include a convenience function for an element.

```swift
let custom = Tag(name: "my-widget", .id("featured")) {
    "Widget content"
}
```

Use ``ClosedTag`` for custom void-style elements that should not accept child content.

```swift
let icon = ClosedTag(name: "my-icon", .attr("name", "search"))
```

## Complete Example

```swift
struct ProductPage: HTComponent {
    let products: [String]

    var body: some HTElement {
        Main(.class("products")) {
            H1 { "Products" }
            Ul {
                for product in products {
                    Li { product }
                }
            }
        }
    }
}

let html = HTDocument {
    Html {
        Body {
            ProductPage(products: ["Keyboard", "Mouse", "Display"])
        }
    }
}.description
```
