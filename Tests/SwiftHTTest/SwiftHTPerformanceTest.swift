import Foundation
import Testing
@testable import SwiftHT

private struct BenchmarkArticle {
    let title: String
    let summary: String
    let href: String
}

@Suite("Performance Benchmark Tests")
struct PerformanceBenchmarkTests {
    @Test("SwiftHT static generation stays close to manual buffered writing")
    func swiftHTStaticGenerationStaysCloseToManualBufferedWriting() async throws {
        let articles = benchmarkArticles(count: 200)

        let manualOutput = renderManualBufferedPage(articles)
        let swiftHTOutput = renderSwiftHTPage(articles)

        #expect(swiftHTOutput == manualOutput)

        let manualTime = bestBenchmarkTime {
            repeatedByteCount(repetitions: 25) {
                renderManualBufferedPage(articles)
            }
        }

        let swiftHTTime = bestBenchmarkTime {
            repeatedByteCount(repetitions: 25) {
                renderSwiftHTPage(articles)
            }
        }

        let ratio = logBenchmarkComparison(
            baselineName: "manual buffered writing",
            baselineTime: manualTime,
            candidateName: "SwiftHT static generation",
            candidateTime: swiftHTTime
        )

        // This is intentionally a regression guard, not a formal benchmark.
        // SwiftHT provides type-safe composition and escaping; the generation cost
        // should stay in the same broad range as direct writes to one byte buffer.
        #expect(ratio < 6.0, "SwiftHT rendering took \(ratio)x the manual buffered writer baseline")
    }

    @Test("Generic HTWriter abstraction stays close to concrete buffer writing")
    func genericWriterAbstractionStaysCloseToConcreteBufferWriting() async throws {
        let articles = benchmarkArticles(count: 300)

        let concreteOutput = renderManualBufferedPage(articles)
        let genericOutput = renderGenericWriterPage(articles)

        #expect(genericOutput == concreteOutput)

        let concreteTime = bestBenchmarkTime {
            repeatedByteCount(repetitions: 40) {
                renderManualBufferedPage(articles)
            }
        }

        let genericTime = bestBenchmarkTime {
            repeatedByteCount(repetitions: 40) {
                renderGenericWriterPage(articles)
            }
        }

        let ratio = logBenchmarkComparison(
            baselineName: "concrete BufferedHTWriter writing",
            baselineTime: concreteTime,
            candidateName: "generic HTWriter writing",
            candidateTime: genericTime
        )

        // SwiftHT passes writers as `some HTWriter`, which gives the compiler a
        // concrete writer type instead of forcing existential dispatch per write.
        // Keep the threshold broad enough for debug test runs and shared machines.
        #expect(ratio < 2.5, "Generic HTWriter rendering took \(ratio)x the concrete writer baseline")
    }

    @Test("Type-erased AnyHTElement adds small top-level dispatch cost")
    func typeErasedElementDispatchAddsSmallTopLevelCost() async throws {
        let articles = benchmarkArticles(count: 200)
        let element = benchmarkElement(articles)
        let erased = AnyHTElement(element)

        let concreteOutput = renderElement(element)
        let erasedOutput = renderElement(erased)

        #expect(erasedOutput == concreteOutput)

        let concreteTime = bestBenchmarkTime {
            repeatedByteCount(repetitions: 40) {
                renderElement(element)
            }
        }

        let erasedTime = bestBenchmarkTime {
            repeatedByteCount(repetitions: 40) {
                renderElement(erased)
            }
        }

        let ratio = logBenchmarkComparison(
            baselineName: "concrete element rendering",
            baselineTime: concreteTime,
            candidateName: "type-erased AnyHTElement rendering",
            candidateTime: erasedTime
        )

        // Type erasure adds one top-level dynamic dispatch before the generic
        // element tree writes into the same buffer. This guard catches accidental
        // large overhead without pretending to be a lab-grade benchmark.
        #expect(ratio < 2.0, "Type-erased element rendering took \(ratio)x the concrete element baseline")
    }

    @Test("Repeated web page request simulation shows generation and static serving costs")
    func repeatedWebPageRequestSimulationShowsGenerationAndStaticServingCosts() async throws {
        let articles = benchmarkArticles(count: 120)
        let requests = 1_000
        let reusableElement = benchmarkElement(articles)
        let staticOutput = renderSwiftHTPage(articles)

        #expect(renderManualBufferedPage(articles) == staticOutput)
        #expect(renderElement(reusableElement) == staticOutput)

        let manualDynamicTime = bestBenchmarkTime(samples: 5, warmups: 2) {
            repeatedByteCount(repetitions: requests) {
                renderManualBufferedPage(articles)
            }
        }

        let swiftHTDynamicTime = bestBenchmarkTime(samples: 5, warmups: 2) {
            repeatedByteCount(repetitions: requests) {
                renderSwiftHTPage(articles)
            }
        }

        let swiftHTReusableTreeTime = bestBenchmarkTime(samples: 5, warmups: 2) {
            repeatedByteCount(repetitions: requests) {
                renderElement(reusableElement)
            }
        }

        let staticServingTime = bestBenchmarkTime(samples: 5, warmups: 2) {
            repeatedStaticByteCount(repetitions: requests, bytes: staticOutput)
        }

        let dynamicRatio = logBenchmarkComparison(
            baselineName: "manual dynamic request generation",
            baselineTime: manualDynamicTime,
            candidateName: "SwiftHT dynamic request generation",
            candidateTime: swiftHTDynamicTime
        )

        let reusableTreeRatio = logBenchmarkComparison(
            baselineName: "manual dynamic request generation",
            baselineTime: manualDynamicTime,
            candidateName: "SwiftHT reusable element-tree request rendering",
            candidateTime: swiftHTReusableTreeTime
        )

        logBenchmarkComparison(
            baselineName: "SwiftHT dynamic request generation",
            baselineTime: swiftHTDynamicTime,
            candidateName: "pre-rendered static byte serving",
            candidateTime: staticServingTime
        )

        print(
            "Performance: repeated request simulation used \(requests) requests; per-request best times: " +
            "manual dynamic \(formatMicroseconds(manualDynamicTime / Double(requests))) us, " +
            "SwiftHT dynamic \(formatMicroseconds(swiftHTDynamicTime / Double(requests))) us, " +
            "SwiftHT reusable tree \(formatMicroseconds(swiftHTReusableTreeTime / Double(requests))) us, " +
            "static bytes \(formatMicroseconds(staticServingTime / Double(requests))) us."
        )

        // These thresholds are intentionally broad because this runs inside the
        // normal debug test suite. The important signal is that repeated generation
        // stays bounded, while pre-rendered static bytes avoid generation entirely.
        #expect(dynamicRatio < 6.0, "Repeated SwiftHT dynamic generation took \(dynamicRatio)x the manual dynamic baseline")
        #expect(reusableTreeRatio < 4.0, "Repeated SwiftHT reusable-tree rendering took \(reusableTreeRatio)x the manual dynamic baseline")
        #expect(staticServingTime < swiftHTDynamicTime, "Pre-rendered static bytes should be faster than regenerating SwiftHT output per request")
    }
}

private func benchmarkArticles(count: Int) -> [BenchmarkArticle] {
    (0..<count).map { index in
        BenchmarkArticle(
            title: "Article \(index)",
            summary: "A short static summary for article \(index).",
            href: "/articles/\(index)"
        )
    }
}

private func benchmarkElement(_ articles: [BenchmarkArticle]) -> some HTElement {
    Main(.class("content")) {
        for article in articles {
            Article(.class("card")) {
                H2 { article.title }
                P { article.summary }
                A(.href(article.href)) {
                    "Read more"
                }
            }
        }
    }
}

private func renderSwiftHTPage(_ articles: [BenchmarkArticle]) -> [UInt8] {
    renderElement(benchmarkElement(articles))
}

private func renderElement(_ element: some HTElement) -> [UInt8] {
    var writer = BufferedHTWriter(capacity: 64 * 1024)
    element.write(to: &writer)
    return writer.data
}

private func renderManualBufferedPage(_ articles: [BenchmarkArticle]) -> [UInt8] {
    var writer = BufferedHTWriter(capacity: 64 * 1024)
    writer.write("<main class=\"content\">")
    for article in articles {
        writer.write("<article class=\"card\"><h2>")
        writeEncodedHtml(article.title, to: &writer)
        writer.write("</h2><p>")
        writeEncodedHtml(article.summary, to: &writer)
        writer.write("</p><a href=\"")
        writeEncodedHtml(article.href, to: &writer)
        writer.write("\">Read more</a></article>")
    }
    writer.write("</main>")
    return writer.data
}

private func renderGenericWriterPage(_ articles: [BenchmarkArticle]) -> [UInt8] {
    var writer = BufferedHTWriter(capacity: 64 * 1024)
    writeManualPage(articles, to: &writer)
    return writer.data
}

private func writeManualPage<W: HTWriter>(_ articles: [BenchmarkArticle], to writer: inout W) {
    writer.write("<main class=\"content\">")
    for article in articles {
        writer.write("<article class=\"card\"><h2>")
        writeEncodedHtml(article.title, to: &writer)
        writer.write("</h2><p>")
        writeEncodedHtml(article.summary, to: &writer)
        writer.write("</p><a href=\"")
        writeEncodedHtml(article.href, to: &writer)
        writer.write("\">Read more</a></article>")
    }
    writer.write("</main>")
}

private func repeatedByteCount(repetitions: Int, render: () -> [UInt8]) -> Int {
    var byteCount = 0
    for _ in 0..<repetitions {
        byteCount &+= render().count
    }
    return byteCount
}

private func repeatedStaticByteCount(repetitions: Int, bytes: [UInt8]) -> Int {
    var byteCount = 0
    for _ in 0..<repetitions {
        byteCount &+= bytes.count
    }
    return byteCount
}

private func bestBenchmarkTime(samples: Int = 7, warmups: Int = 2, operation: () -> Int) -> Double {
    let clock = ContinuousClock()
    var checksum = 0

    for _ in 0..<warmups {
        checksum &+= operation()
    }

    var best = Double.greatestFiniteMagnitude
    for _ in 0..<samples {
        let elapsed = clock.measure {
            checksum &+= operation()
        }
        best = min(best, seconds(elapsed))
    }

    #expect(checksum > 0)
    return best
}

private func seconds(_ duration: Duration) -> Double {
    let components = duration.components
    return Double(components.seconds) + Double(components.attoseconds) / 1_000_000_000_000_000_000
}

@discardableResult
private func logBenchmarkComparison(
    baselineName: String,
    baselineTime: Double,
    candidateName: String,
    candidateTime: Double
) -> Double {
    let ratio = candidateTime / max(baselineTime, .leastNonzeroMagnitude)
    let percent = abs(ratio - 1) * 100
    let direction = ratio < 1 ? "faster" : "slower"

    print(
        "Performance: \(candidateName) is \(formatPercent(percent))% \(direction) than \(baselineName) " +
        "(candidate: \(formatMilliseconds(candidateTime)) ms, baseline: \(formatMilliseconds(baselineTime)) ms, ratio: \(formatRatio(ratio))x)."
    )

    return ratio
}

private func formatPercent(_ value: Double) -> String {
    String(format: "%.2f", value)
}

private func formatMilliseconds(_ seconds: Double) -> String {
    String(format: "%.3f", seconds * 1_000)
}

private func formatMicroseconds(_ seconds: Double) -> String {
    String(format: "%.3f", seconds * 1_000_000)
}

private func formatRatio(_ value: Double) -> String {
    String(format: "%.3f", value)
}
