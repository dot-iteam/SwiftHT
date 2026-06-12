# Tutorial: Building Your First Page

Create a complete HTML page with SwiftHT, add styles, extract components, and render the result.

## Goal

In this tutorial you will build a small profile page. The final result includes:

- A full ``HTDocument`` with `html`, `head`, and `body` sections.
- Reusable ``HTComponent`` and ``CSSComponent`` types.
- Dynamic list rendering with a `for` loop.
- Safe text rendering and compact output.

## Step 1: Create the Data Model

Start with plain Swift data.

```swift
struct ProfileLink {
    let label: String
    let url: String
}

let links = [
    ProfileLink(label: "Website", url: "https://example.com"),
    ProfileLink(label: "Documentation", url: "/docs"),
    ProfileLink(label: "Support", url: "/support")
]
```

SwiftHT does not require a special model layer. Use the same Swift structs you would use elsewhere in your app.

## Step 2: Build a Link List Component

Create a component for the repeated link markup.

```swift
struct ProfileLinks: HTComponent {
    let links: [ProfileLink]

    var body: some HTElement {
        Nav(.class("profile-links"), .attr("aria-label", "Profile links")) {
            Ul {
                for link in links {
                    Li {
                        A(.href(link.url)) {
                            link.label
                        }
                    }
                }
            }
        }
    }
}
```

SwiftHT includes helpers for many common attributes. For attributes that do not have a dedicated helper, use `.attr("name", "value")`.

## Step 3: Build the Page Component

Compose the page's main content from semantic HTML tags.

```swift
struct ProfilePage: HTComponent {
    let name: String
    let bio: String
    let links: [ProfileLink]

    var body: some HTElement {
        Main(.class("profile")) {
            Header(.class("profile-header")) {
                H1 { name }
                P(.class("bio")) { bio }
            }

            ProfileLinks(links: links)
        }
    }
}
```

`name` and `bio` are plain strings. SwiftHT escapes them automatically, which is the right default for user-visible text.

## Step 4: Add CSS

Extract the stylesheet into a CSS component.

```swift
struct ProfileStyles: CSSComponent {
    var style: some CSSElement {
        css("body") {
            ("font-family", "system-ui")
            ("margin", "0")
            ("line-height", "1.5")
        }

        css(".profile") {
            ("max-width", "48rem")
            ("margin", "0 auto")
            ("padding", "2rem")
        }

        css(".profile-links ul") {
            ("display", "grid")
            ("gap", "0.5rem")
            ("padding", "0")
            ("list-style", "none")
        }
    }
}
```

Use tuples instead of a dictionary here because tuple order is stable in rendered output.

## Step 5: Create the Document

Put the page and stylesheet into a complete document.

```swift
let document = HTDocument {
    Html(.lang("en")) {
        Head {
            Meta(.charset("utf-8"))
            Meta(.name("viewport"), .content("width=device-width, initial-scale=1"))
            Title { "Profile" }
            Style {
                ProfileStyles()
            }
        }
        Body {
            ProfilePage(
                name: "Ava",
                bio: "Builds small tools with Swift.",
                links: links
            )
        }
    }
}
```

## Step 6: Render the Output

Render to a string for inspection or tests.

```swift
let html = document.description
```

Render to `Data` for response bodies or files.

```swift
let data = hyperData {
    document
}
```

## Complete Example

```swift
import SwiftHT

struct ProfileLink {
    let label: String
    let url: String
}

struct ProfileLinks: HTComponent {
    let links: [ProfileLink]

    var body: some HTElement {
        Nav(.class("profile-links"), .attr("aria-label", "Profile links")) {
            Ul {
                for link in links {
                    Li {
                        A(.href(link.url)) { link.label }
                    }
                }
            }
        }
    }
}

struct ProfilePage: HTComponent {
    let name: String
    let bio: String
    let links: [ProfileLink]

    var body: some HTElement {
        Main(.class("profile")) {
            Header(.class("profile-header")) {
                H1 { name }
                P(.class("bio")) { bio }
            }
            ProfileLinks(links: links)
        }
    }
}

struct ProfileStyles: CSSComponent {
    var style: some CSSElement {
        css("body") {
            ("font-family", "system-ui")
            ("margin", "0")
            ("line-height", "1.5")
        }
        css(".profile") {
            ("max-width", "48rem")
            ("margin", "0 auto")
            ("padding", "2rem")
        }
        css(".profile-links ul") {
            ("display", "grid")
            ("gap", "0.5rem")
            ("padding", "0")
            ("list-style", "none")
        }
    }
}

let links = [
    ProfileLink(label: "Website", url: "https://example.com"),
    ProfileLink(label: "Documentation", url: "/docs"),
    ProfileLink(label: "Support", url: "/support")
]

let document = HTDocument {
    Html(.lang("en")) {
        Head {
            Meta(.charset("utf-8"))
            Meta(.name("viewport"), .content("width=device-width, initial-scale=1"))
            Title { "Profile" }
            Style { ProfileStyles() }
        }
        Body {
            ProfilePage(
                name: "Ava",
                bio: "Builds small tools with Swift.",
                links: links
            )
        }
    }
}

let html = document.description
```

## What You Learned

You built a complete page with SwiftHT, split repeated markup into components, added CSS through the CSS builder, rendered dynamic collections with loops, and used SwiftHT's default escaping for text and attributes.
