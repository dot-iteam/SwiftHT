# Performance Notes

Interpret SwiftHT's static-output and dynamic-generation performance characteristics.

## Zero Runtime Overhead for Static Output

SwiftHT's strongest performance claim applies to pre-rendered static content. When you generate HTML and CSS ahead of time and deploy the generated files, the delivered website has zero SwiftHT runtime overhead. The server only serves static bytes, and the browser does not need a SwiftHT runtime, PHP template execution, React runtime, or hydration work to display the content.

This is different from dynamic generation. If an application renders SwiftHT markup on every request, SwiftHT still performs generation work for each request. That path has measurable but modest overhead compared with direct manual writes into a byte buffer.

## Release Benchmark Summary

The package includes benchmark-style Swift Testing checks in `SwiftHTPerformanceTest.swift`. The following results were collected from a release-configuration run and compare best sampled timings using `ContinuousClock`.

| Scenario | Baseline | Candidate | Result |
| --- | --- | --- | --- |
| Static generation | Manual buffered writing | SwiftHT static generation | SwiftHT was 79.28% slower, 1.793x the baseline |
| Writer abstraction | Concrete `BufferedHTWriter` writing | Generic `HTWriter` writing | Generic writing was 15.45% faster, 0.845x the baseline |
| Type erasure | Concrete element rendering | `AnyHTElement` rendering | Type-erased rendering was 22.69% faster, 0.773x the baseline |
| Repeated dynamic requests | Manual dynamic request generation | SwiftHT dynamic request generation | SwiftHT was 84.65% slower, 1.847x the baseline |
| Repeated reusable-tree requests | Manual dynamic request generation | SwiftHT reusable element-tree rendering | SwiftHT was 59.09% slower, 1.591x the baseline |
| Static byte serving | SwiftHT dynamic request generation | Pre-rendered static bytes | Static bytes were effectively 100.00% faster, 0.000x the baseline |

The repeated request simulation used 1,000 requests. Best sampled per-request timings were:

| Approach | Best per-request time |
| --- | ---: |
| Manual dynamic generation | 820.256 us |
| SwiftHT dynamic generation | 1514.610 us |
| SwiftHT reusable element-tree rendering | 1304.942 us |
| Pre-rendered static bytes | 0.066 us |

## Interpretation

The manual buffered baseline is intentionally close to a low-level implementation: reserve one byte buffer and append exact markup directly. SwiftHT adds a typed DSL, result-builder composition, tag objects, attributes, escaping, and reusable components. Being within roughly 1.6x to 1.9x of that manual baseline for dynamic generation is a modest abstraction cost for the safety and maintainability gained.

The writer-abstraction result is also important. Generic `HTWriter` rendering stayed in the same range as concrete writer rendering, which suggests the compiler can specialize this path well. In practice, most overhead comes from building and walking the higher-level HTML DSL, not from the writer protocol itself.

For production static sites, the most important result is the static byte serving row. Once SwiftHT output is pre-rendered, request-time generation disappears. That is the basis for the zero-runtime-overhead claim.

## Recommended Wording

Use precise wording based on how the site is deployed:

- For pre-rendered static sites: SwiftHT produces zero-runtime-overhead static HTML and CSS.
- For dynamic server-side rendering: SwiftHT has modest generation-time overhead compared with hand-written buffered output.
- For reusable server-rendered components: keeping reusable element trees can reduce repeated generation overhead.

Avoid claiming that dynamic SwiftHT rendering has zero overhead. The zero-overhead claim belongs to the deployed static output path.
