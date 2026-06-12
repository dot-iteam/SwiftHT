# Styling With CSS

Generate compact CSS with SwiftHT's CSS builder.

## CSS Rules

Use ``css(_:_:content:)`` to create a rule and place it inside a ``Style(_:_:)`` tag.

```swift
Style {
    css("body") {
        ("font-family", "system-ui")
        ("line-height", "1.5")
        ("margin", "0")
    }

    css(".button") {
        ("display", "inline-flex")
        ("padding", "0.5rem 0.75rem")
        ("border-radius", "6px")
    }
}
```

SwiftHT renders CSS without formatting whitespace:

```css
body{font-family:system-ui;line-height:1.5;margin:0;}.button{display:inline-flex;padding:0.5rem 0.75rem;border-radius:6px;}
```

## Properties

Inside a CSS builder, a `(String, String)` tuple becomes a ``CSSProperty``.

```swift
css("h1") {
    ("font-size", "2rem")
    ("margin", "0")
}
```

You can also use ``prop(_:_:)`` when you prefer explicit function calls.

```swift
css("h1", prop("font-size", "2rem"), prop("margin", "0"))
```

## Dictionaries

A `[String: String]` dictionary can be used as a compact property source.

```swift
css(".card") {
    [
        "border": "1px solid #ddd",
        "padding": "1rem"
    ]
}
```

Dictionary iteration order is not guaranteed. Prefer tuples or ``prop(_:_:)`` when deterministic output matters, especially in tests.

## Conditional Rules

`CSSBuilder` supports the same control-flow patterns as ``HTBuilder``.

```swift
let highContrast = true

Style {
    css("body") {
        ("background", "white")
        ("color", "#222")
    }

    if highContrast {
        css("a") {
            ("text-decoration", "underline")
            ("font-weight", "700")
        }
    }
}
```

## CSS Components

Move reusable style groups into ``CSSComponent`` types.

```swift
struct ButtonStyles: CSSComponent {
    var style: some CSSElement {
        css(".button") {
            ("display", "inline-flex")
            ("gap", "0.5rem")
        }

        css(".button.primary") {
            ("background", "black")
            ("color", "white")
        }
    }
}

Style {
    ButtonStyles()
}
```

## At-Rules

`css` accepts any selector string, so it can render simple at-rules too.

```swift
Style {
    css("@media (max-width: 600px)") {
        css(".layout") {
            ("display", "block")
        }
    }
}
```

This renders nested braces exactly as written by the DSL.
