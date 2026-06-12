# Rendering Output

Choose the right rendering API for strings, byte data, or custom sinks.

SwiftHT output is plain HTML and CSS. When you generate static files, the deployed site has zero SwiftHT runtime overhead: there is no template engine running per request and no client-side framework required to display the content. Dynamic generation still has generation-time cost; see <doc:PerformanceNotes> for release benchmark results.

## Render to String

Every ``HTElement`` conforms to `CustomStringConvertible`, so `.description` renders the element as a UTF-8 string.

```swift
let html = Div(.id("notice")) {
    "Ready"
}.description

// <div id="notice">Ready</div>
```

This is the simplest choice for tests, logs, previews, and small generated pages.

## Render to Data

Use ``hyperData(capacity:content:)`` when you want UTF-8 bytes.

```swift
let body = hyperData {
    HTDocument {
        Html {
            Body {
                H1 { "Status" }
                P { "OK" }
            }
        }
    }
}
```

The `capacity` parameter reserves initial storage for the writer. Increase it when generating larger documents to reduce buffer growth.

```swift
let largePage = hyperData(capacity: 64 * 1024) {
    HTDocument {
        Html {
            Body {
                for index in 0..<1_000 {
                    P { "Row \(index)" }
                }
            }
        }
    }
}
```

## Render with a Writer

For custom output handling, create a type that conforms to ``HTWriter``.

```swift
struct CountingWriter: HTWriter {
    var bytesWritten = 0

    mutating func write(_ value: some CustomStringConvertible) {
        bytesWritten += value.description.utf8.count
    }
}

var writer = CountingWriter()
Div { "Count me" }.write(to: &writer)
```

Use direct writer rendering when you want streaming, custom metrics, or integration with an output type that is not `String` or `Data`.

## BufferedHTWriter

``BufferedHTWriter`` stores UTF-8 bytes in its ``BufferedHTWriter/data`` array.

```swift
var writer = BufferedHTWriter()
HTDocument {
    Html { Body { "Hello" } }
}.write(to: &writer)

let html = String(bytes: writer.data, encoding: .utf8)
```

## Output Format

SwiftHT emits compact markup. It does not insert indentation or line breaks.

```swift
Div {
    P { "One" }
    P { "Two" }
}
```

Renders as:

```html
<div><p>One</p><p>Two</p></div>
```

If you need pretty-printed HTML, run the generated output through a formatter outside SwiftHT.
