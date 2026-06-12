# Best Practices

Use SwiftHT effectively and keep generated markup predictable.

For static content, prefer generating final HTML and CSS during your build or publishing step. That keeps SwiftHT's work out of the request path and gives the deployed site zero runtime overhead beyond serving static files. If you generate pages dynamically per request, treat SwiftHT as a low-overhead typed rendering DSL rather than a zero-overhead path; see <doc:PerformanceNotes> for measured results.

## Prefer Typed Builders Over String Concatenation

Use tag functions, attribute helpers, and text nodes instead of manually assembling HTML strings.

```swift
// Prefer this.
A(.href("/account"), .class("nav-link")) {
    "Account"
}

// Avoid this when the values are dynamic.
RawHTML("<a href=\"/account\" class=\"nav-link\">Account</a>")
```

The typed form keeps escaping behavior consistent and makes structure visible in code review.

## Treat RawHTML as Trusted-Only

``RawHTML`` bypasses escaping. Reserve it for content you control, such as a known SVG snippet or already-sanitized HTML.

```swift
// Safe for normal text.
P { user.name }

// Trusted-only.
RawHTML(trustedSvgMarkup)
```

## Keep Components Small

Use ``HTComponent`` for repeated pieces of UI or markup. Keep each component focused on a single semantic section.

```swift
struct PageHeader: HTComponent {
    let title: String

    var body: some HTElement {
        Header {
            H1 { title }
        }
    }
}
```

## Use Semantic Tags

Prefer semantic elements such as ``Header(_:_:)``, ``Main(_:_:)``, ``Nav(_:_:)``, ``Article(_:_:)``, and ``Footer(_:_:)`` when they describe the content. Use ``Div(_:_:)`` and ``Span(_:_:)`` for generic grouping.

## Keep Tests Deterministic

SwiftHT output is compact and ordered. This makes exact string tests practical.

```swift
#expect(P { "Hello" }.description == "<p>Hello</p>")
```

Avoid dictionary-based CSS properties in exact string tests because dictionary iteration order is not guaranteed. Use tuples instead.

```swift
css(".card") {
    ("padding", "1rem")
    ("border", "1px solid #ddd")
}
```

## Be Intentional With Void Elements

Use void-element helpers such as ``Img(_:)``, ``Input(_:)``, ``Source(_:)``, and ``Track(_:)`` without child content. If you need a tag with children that SwiftHT does not include, use ``Tag``.

## Choose the Right Output API

Use `.description` for simple strings, ``hyperData(capacity:content:)`` for UTF-8 response bodies, and direct ``HTWriter`` rendering for custom output sinks.

## Keep CSS Close or Reusable

Small one-off styles can live inside ``Style(_:_:)``. Repeated style groups should move into ``CSSComponent`` types so they can be reused and tested independently.
