# Escaping and Raw HTML

Understand how SwiftHT protects text and when to bypass escaping.

## Default Escaping

SwiftHT escapes text nodes and attribute values by default. This behavior is provided by ``writeEncodedHtml(_:to:)`` and the `CustomStringConvertible` extension that lets strings and numbers render as ``HTElement`` values.

```swift
let html = P {
    "5 < 7 & 9 > 3"
}.description

// <p>5 &lt; 7 &amp; 9 &gt; 3</p>
```

Attribute values are escaped too:

```swift
let html = Button(.title("Save \"draft\"")) {
    "Save"
}.description

// <button title="Save &quot;draft&quot;">Save</button>
```

Escaping applies to:

- `String` text nodes
- `Int`, `Float`, and `Double` text nodes
- ``HTAttribute/attr(_:_:)`` values
- Attribute values created by convenience helpers such as ``HTAttribute/title(_:)`` and ``HTAttribute/href(_:)``

## RawHTML

Use ``RawHTML`` only when you already have trusted markup and you need SwiftHT to write it exactly as supplied.

```swift
let trustedIcon = RawHTML("<svg aria-hidden=\"true\"></svg>")

Button {
    trustedIcon
    "Search"
}
```

Do not use `RawHTML` with user input, request parameters, database fields, or remote content that has not already been sanitized.

```swift
// Avoid this if `comment.body` came from a user.
RawHTML(comment.body)
```

Prefer normal strings whenever possible:

```swift
// Safe: SwiftHT escapes the content.
P { comment.body }
```

## Custom Elements and Escaping

When you implement a custom ``HTElement``, choose escaping intentionally.

```swift
struct SafeText: HTElement {
    let value: String

    func write(to writer: inout some HTWriter) {
        writeEncodedHtml(value, to: &writer)
    }
}
```

Only call `writer.write(_:)` directly for markup syntax or for content that you know is already safe.

## Security Checklist

- Use plain strings for user-visible text.
- Use attribute helpers for attribute values.
- Treat ``RawHTML`` as trusted-only API.
- Keep sanitization outside SwiftHT if your app accepts rich HTML from users.
- Add tests for escaping when a component handles user-provided data.
