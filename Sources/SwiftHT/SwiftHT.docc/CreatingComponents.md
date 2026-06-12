# Creating Components

Encapsulate reusable markup and styles in small Swift types.

## HTML Components

Conform to ``HTComponent`` when a piece of markup has a name, inputs, or repeated usage. A component exposes a computed ``HTComponent/body`` and automatically conforms to ``HTElement`` through the protocol extension.

```swift
struct Alert: HTComponent {
    let title: String
    let message: String

    var body: some HTElement {
        Section(.class("alert"), .role("status")) {
            H2 { title }
            P { message }
        }
    }
}
```

Use the component anywhere an element is accepted:

```swift
Main {
    Alert(title: "Saved", message: "Your changes are available now.")
}
```

## Parameterized Components

Components are normal Swift types, so use stored properties and initializers for inputs.

```swift
struct NavLink: HTComponent {
    let label: String
    let href: String
    let isCurrent: Bool

    var body: some HTElement {
        A(
            .href(href),
            isCurrent ? .attr("aria-current", "page") : .none,
            .class(isCurrent ? "nav-link current" : "nav-link")
        ) {
            label
        }
    }
}
```

## Lists and Repeated Views

Use `for` loops inside component bodies.

```swift
struct ProductList: HTComponent {
    let products: [String]

    var body: some HTElement {
        Ul(.class("products")) {
            for product in products {
                Li { product }
            }
        }
    }
}
```

## CSS Components

Use ``CSSComponent`` to group related CSS rules.

```swift
struct BaseStyles: CSSComponent {
    var style: some CSSElement {
        css(":root") {
            ("color-scheme", "light dark")
            ("font-family", "system-ui")
        }

        css("body") {
            ("margin", "0")
            ("line-height", "1.5")
        }
    }
}
```

Include CSS components inside ``Style(_:_:)``:

```swift
Head {
    Style {
        BaseStyles()
    }
}
```

## Component Best Practices

Keep components focused on one responsibility. Prefer plain Swift values for data and derive attributes or child content from those values. Avoid returning ``RawHTML`` from components unless the component's job is specifically to wrap trusted markup.
