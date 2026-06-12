# SwiftHT

SwiftHT, or Swift Hyper Text, is a Swift 6 package for generating compact HTML and CSS with a result-builder DSL. For static websites, SwiftHT can produce zero-runtime-overhead output: plain HTML and CSS that can be served directly without PHP request-time execution or a React runtime/hydration cost in the browser. When pages are generated dynamically, release benchmarks show modest generation-time overhead compared with direct manual buffer writes, with static byte serving removing generation cost from the request path.

```swift
import SwiftHT

let page = HTDocument {
    Html(.lang("en")) {
        Head {
            Title { "SwiftHT" }
            Style {
                css("body") {
                    ("font-family", "system-ui")
                    ("margin", "2rem")
                }
            }
        }
        Body {
            Main {
                H1 { "Hello from SwiftHT" }
                P { "Text and attribute values are escaped automatically." }
            }
        }
    }
}

print(page.description)
```

## Documentation

The package includes a Swift-DocC catalog at `Sources/SwiftHT/SwiftHT.docc` with guides, examples, best practices, and a tutorial. In Xcode, choose **Product > Build Documentation** to view it.

The documentation is hosted on [docs.iteam.studio](https://docs.iteam.studio), iTeam's documentation website for published package and API references. The SwiftHT documentation is available directly at [docs.iteam.studio/docc/documentation/swiftht](https://docs.iteam.studio/docc/documentation/swiftht).

## Tests

Tests are grouped with Swift Testing suites so you can run focused subsets from Xcode's test navigator:

- `Smoke Rendering Tests`
- `Escaping and Raw HTML Integrity Tests`
- `Document and Builder Integrity Tests`
- `Attribute and Tag Integrity Tests`
- `CSS Integrity Tests`
- `Component and Type Erasure Integrity Tests`
- `Output Encoding Integrity Tests`
- `Performance Benchmark Tests`

For fast daily checks, run the smoke and integrity suites and skip `Performance Benchmark Tests`. Run `Performance Benchmark Tests` separately when you specifically want the benchmark output.

The repository includes two Xcode test plans:

- `SwiftHTIntegrityTest.xctestplan` for smoke and integrity suites.
- `SwiftHTPerformanceTest.xctestplan` for benchmark suites.
