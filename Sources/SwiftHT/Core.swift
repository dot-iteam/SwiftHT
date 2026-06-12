//
//  Core.swift
//  SwiftHT
//
//  Created by Dot iTeam on 2026-05-27.
//

/// A value that can render itself as HTML.
///
/// Conform to `HTElement` when you want a type to participate in SwiftHT's
/// result-builder DSL. Implement ``write(to:)`` to append the element's HTML
/// representation to the supplied writer.
public protocol HTElement : CustomStringConvertible {
    /// A byte-buffer representation used internally by grouped elements.
    typealias Regions = [[UInt8]]

    /// Writes the element's HTML representation to a writer.
    ///
    /// - Parameter writer: The destination that receives the rendered markup.
    func write(to writer: inout some HTWriter)
}

public extension HTElement {
    /// Renders the element into a UTF-8 string.
    ///
    /// This property uses ``BufferedHTWriter`` and returns an empty string if
    /// the produced bytes cannot be decoded as UTF-8.
    var description: String {
        var writer = BufferedHTWriter()
        self.write(to: &writer)
        return String(bytes: writer.data, encoding: .utf8) ?? ""
    }
}

/// A variadic group of HTML elements that renders each element in order.
///
/// `HTGroup` is the concrete type that ``HTBuilder`` uses for blocks with
/// multiple child elements.
public struct HTGroup<each E: HTElement> : HTElement {
    /// The grouped elements, stored as a Swift variadic value pack.
    public let value: (repeat each E)

    /// Creates a group from one or more elements.
    ///
    /// - Parameter value: The elements to render in order.
    public init(value: repeat each E) {
        self.value = (repeat each value)
    }

    /// Writes each grouped element to the writer in source order.
    ///
    /// - Parameter writer: The destination that receives the rendered markup.
    public func write(to writer: inout some HTWriter) {
        repeat (each value).write(to: &writer)
    }
}

/// Writes a string-convertible value with HTML escaping applied.
///
/// SwiftHT uses this function for text nodes and attribute values. The function
/// escapes `>`, `<`, `&`, `"`, and `'` to their corresponding HTML entities.
/// Use ``RawHTML`` only when you intentionally need to bypass this escaping.
///
/// - Parameters:
///   - value: The value to convert and escape.
///   - writer: The destination that receives the escaped output.
public func writeEncodedHtml(
    _ value: some CustomStringConvertible,
    to writer: inout some HTWriter
) {
    value.description.forEach {
        switch $0 {
        case ">":
            writer.write("&gt;")
        case "<":
            writer.write("&lt;")
        case "&":
            writer.write("&amp;")
        case "\"":
            writer.write("&quot;")
        case "\'":
            writer.write("&apos;")
        default:
            writer.write($0)
        }
    }
}

/// An HTML attribute that can be attached to a tag.
///
/// Use `.attr("name", "value")` for name/value attributes, `.single("name")`
/// for boolean attributes, and `.none` when conditional code should omit an
/// attribute without changing surrounding builder logic.
public enum HTAttribute : HTElement {
    /// A name/value attribute such as `class="primary"`.
    case attr(String, String)

    /// A boolean attribute such as `disabled` or `required`.
    case single(String)

    /// An attribute placeholder that renders no output.
    case none

    /// Writes the attribute to the writer, including the leading space.
    ///
    /// Name/value attributes escape their values with ``writeEncodedHtml(_:to:)``.
    ///
    /// - Parameter writer: The destination that receives the rendered attribute.
    public func write(to writer: inout some HTWriter) {
        switch self {
        case .attr(let name, let value):
            writer.write(" \(name)=\"")
            writeEncodedHtml(value, to: &writer)
            writer.write("\"")
        case .single(let name):
            writer.write(" \(name)")
        case .none:
            break
        }
    }
}

/// An empty HTML element used by builders and generic defaults.
public struct Empty : HTElement {
    /// Creates an empty element.
    public init() {}

    /// Writes no output.
    ///
    /// - Parameter writer: The destination writer, unused for empty content.
    public func write(to _: inout some HTWriter) {

    }
}

/// A wrapper that conditionally renders an optional HTML element.
public struct HTOptional<E: HTElement> : HTElement {
    /// The optional element to render.
    public let value: E?

    /// Creates an optional wrapper.
    ///
    /// - Parameter value: The optional element to render when present.
    public init(_ value: E?) {
        self.value = value
    }

    /// Writes the wrapped element when it exists.
    ///
    /// - Parameter writer: The destination that receives the rendered markup.
    public func write(to writer: inout some HTWriter) {
        if let value {
            value.write(to: &writer)
        }
    }
}

/// A type-erased HTML element.
///
/// Use `AnyHTElement` when you need to store heterogeneous element values in a
/// single variable or collection.
public struct AnyHTElement : HTElement {
    /// The wrapped element value.
    public let value: any HTElement

    /// Erases the concrete type of an HTML element.
    ///
    /// - Parameter value: The element to wrap.
    public init<E: HTElement>(_ value: E) {
        self.value = value
    }

    /// Writes the wrapped element to the writer.
    ///
    /// - Parameter writer: The destination that receives the rendered markup.
    public func write(to writer: inout some HTWriter) {
        value.write(to: &writer)
    }
}

/// A collection of HTML elements that renders each element in order.
public struct HTArray<E: HTElement> : HTElement {
    /// The elements to render.
    public let value: [E]

    /// Creates an array wrapper.
    ///
    /// - Parameter value: The elements to render in order.
    public init(_ value: [E]) {
        self.value = value
    }

    /// Writes each element in array order.
    ///
    /// - Parameter writer: The destination that receives the rendered markup.
    public func write(to writer: inout some HTWriter) {
        value.forEach { $0.write(to: &writer) }
    }
}

/// A result-builder conditional that renders either the true or false branch.
public struct HTConditional<TrueContent: HTElement, FalseContent: HTElement> : HTElement {
    /// The condition that selected the branch.
    public let condition: Bool

    /// The element from the true branch, when selected.
    public let first: TrueContent?

    /// The element from the false branch, when selected.
    public let second: FalseContent?

    /// Creates a conditional wrapper.
    ///
    /// - Parameters:
    ///   - condition: The condition that selected the branch.
    ///   - first: The element to render for the true branch.
    ///   - second: The element to render for the false branch.
    public init(condition: Bool, first: TrueContent?, second: FalseContent?) {
        self.condition = condition
        self.first = first
        self.second = second
    }

    /// Writes the selected branch to the writer.
    ///
    /// - Parameter writer: The destination that receives the rendered markup.
    public func write(to writer: inout some HTWriter) {
        if condition {
            if let first {
                first.write(to: &writer)
            }
        } else {
            if let second {
                second.write(to: &writer)
            }
        }
    }
}

/// A result builder for composing HTML elements.
///
/// `HTBuilder` powers the trailing-closure syntax used by tags and documents.
/// It supports plain element expressions, multiple child elements, optionals,
/// conditionals, and `for` loops.
@resultBuilder
public struct HTBuilder {
    /// Accepts a single HTML element expression.
    ///
    /// - Parameter element: The element expression in the builder body.
    /// - Returns: The same element.
    public static func buildExpression<C: HTElement>(_ element: C) -> C {
        element
    }

    /// Combines zero or more elements into a group.
    ///
    /// - Parameter components: The elements in the builder block.
    /// - Returns: A group that renders the elements in order.
    public static func buildBlock<each E: HTElement>(_ components: repeat each E) -> HTGroup<repeat each E> {
        HTGroup<repeat each E>(value: repeat each components)
    }

    /// Starts an incremental builder block.
    ///
    /// - Parameter first: The first element in the block.
    /// - Returns: A group containing the first element.
    public static func buildPartialBlock<C1: HTElement>(first: C1) -> HTGroup<C1> {
        return HTGroup<C1>(value: first)
    }

    /// Appends an element to an incremental builder block.
    ///
    /// - Parameters:
    ///   - accumulated: The elements collected so far.
    ///   - next: The next element in the block.
    /// - Returns: A group containing the accumulated elements and the next element.
    public static func buildPartialBlock<each E: HTElement, C: HTElement>(accumulated: HTGroup<repeat each E>, next: C) -> HTGroup<repeat each E, C> {
        return HTGroup<repeat each E, C>(value: repeat each accumulated.value, next)
    }

    /// Wraps an optional element from an `if` statement without an `else` branch.
    ///
    /// - Parameter component: The optional builder result.
    /// - Returns: A wrapper that renders the component when present.
    public static func buildOptional<C: HTElement>(_ component: C?) -> HTOptional<C> {
        return HTOptional(component)
    }

    /// Wraps the true branch of an `if`/`else` statement.
    ///
    /// - Parameter first: The true branch content.
    /// - Returns: A conditional wrapper for the true branch.
    public static func buildEither<TrueContent: HTElement, FalseContent: HTElement>(first: TrueContent) -> HTConditional<TrueContent, FalseContent> {
        HTConditional(condition: true, first: first, second: nil)
    }

    /// Wraps the false branch of an `if`/`else` statement.
    ///
    /// - Parameter second: The false branch content.
    /// - Returns: A conditional wrapper for the false branch.
    public static func buildEither<TrueContent: HTElement, FalseContent: HTElement>(second: FalseContent) -> HTConditional<TrueContent, FalseContent> {
        HTConditional(condition: false, first: nil, second: second)
    }

    /// Wraps elements produced by a `for` loop.
    ///
    /// - Parameter components: The elements produced by the loop.
    /// - Returns: An array wrapper that renders the elements in order.
    public static func buildArray<C: HTElement>(_ components: [C]) -> HTArray<C> {
        HTArray(components)
    }
}

/// Builds a group of HTML elements without wrapping them in a tag.
///
/// Use this helper when you need a top-level fragment, for example in tests or
/// when rendering repeated rows.
///
/// - Parameter content: A builder that returns the fragment content.
/// - Returns: The built element or group.
public func HTElements<E: HTElement>(@HTBuilder content: () -> E) -> E {
    content()
}

/// Renders HTML content directly into `Data`.
///
/// Use `hyperData` when sending generated HTML over a network response or
/// writing it to a file as UTF-8 bytes.
///
/// - Parameters:
///   - capacity: The initial byte capacity reserved by the buffered writer.
///   - content: A builder that returns the HTML content to render.
/// - Returns: UTF-8 data containing the rendered HTML.
public func hyperData<E: HTElement>(capacity: Int = 4*1024, @HTBuilder content: () -> E) -> Data {
    var writer = BufferedHTWriter(capacity: capacity)
    content().write(to: &writer)
    return Data(bytes: writer.data, count: writer.data.count)
}

/// A complete HTML document that starts with a doctype declaration.
///
/// `HTDocument` renders `<!doctype html>` before the content supplied in its
/// builder. Pair it with ``Html(_:_:)``, ``Head(_:_:)``, and ``Body(_:_:)`` for
/// complete pages.
public struct HTDocument<Content: HTElement> : HTElement {
    /// The document content rendered after the doctype.
    public let content: Content

    /// Creates an HTML document.
    ///
    /// - Parameter content: A builder that returns the document content.
    public init(@HTBuilder content: () -> Content) {
        self.content = content()
    }

    /// Writes the doctype and document content to the writer.
    ///
    /// - Parameter writer: The destination that receives the rendered document.
    public func write(to writer: inout some HTWriter) {
        writer.write("<!doctype html>")
        content.write(to: &writer)
    }
}

/// A non-void HTML tag with child content and attributes.
///
/// Conform to `HTTag` to define a custom tag type. Most users can use the
/// generic ``Tag`` type or the provided tag helper functions instead.
public protocol HTTag : HTElement {
    /// The type of content nested inside the tag.
    associatedtype Content: HTElement

    /// The HTML tag name to render.
    var name : () -> String { get }

    /// The child content rendered between the start and end tags.
    var content: Content { get }

    /// The attributes rendered in the start tag.
    var attributes: [HTAttribute] { get set }
}

public extension HTTag {
    /// Writes the start tag, attributes, content, and end tag.
    ///
    /// - Parameter writer: The destination that receives the rendered tag.
    func write(to writer: inout some HTWriter) {
        writer.write("<\(name())")
        attributes.forEach { attribute in
            attribute.write(to: &writer)
        }
        writer.write(">")
        content.write(to: &writer)
        writer.write("</\(name())>")
    }

    /// Returns a copy of the tag with additional attributes appended.
    ///
    /// - Parameter attributes: Attributes to append to the tag.
    /// - Returns: The updated tag.
    mutating func attr(_ attributes: HTAttribute...) -> Self {
        self.attributes.append(contentsOf: attributes)
        return self
    }
}

/// A generic non-void HTML tag.
///
/// Use `Tag` to create custom tags that are not covered by the built-in helper
/// functions.
public struct Tag<Content: HTElement>: HTTag {
    /// The child content rendered between the start and end tags.
    public var content: Content

    /// The attributes rendered in the start tag.
    public var attributes: [HTAttribute] = []

    /// The HTML tag name to render.
    public var name: () -> String

    /// Creates a tag from variadic attributes and a content builder.
    ///
    /// - Parameters:
    ///   - name: The HTML tag name.
    ///   - attributes: Attributes to render in the start tag.
    ///   - build: A builder that returns the tag's child content.
    public init(name: @autoclosure @escaping () -> String, _ attributes: HTAttribute..., @HTBuilder build: () -> Content) {
        self.name = name
        self.attributes = attributes
        self.content = build()
    }

    /// Creates a tag from an attribute array and a content builder.
    ///
    /// - Parameters:
    ///   - name: The HTML tag name.
    ///   - attributes: Attributes to render in the start tag.
    ///   - build: A builder that returns the tag's child content.
    public init(name: @autoclosure @escaping () -> String, _ attributes: [HTAttribute] = [], @HTBuilder build: () -> Content) {
        self.name = name
        self.attributes = attributes
        self.content = build()
    }
}

/// An HTML void element that has attributes but no child content.
///
/// `HTClosedTag` is used by helpers such as ``Img(_:)`` and ``Input(_:)``. The
/// current renderer emits XML-style closed syntax, for example `<img/>`.
public protocol HTClosedTag : HTElement {
    /// The HTML tag name to render.
    var name : () -> String { get }

    /// The attributes rendered in the tag.
    var attributes: [HTAttribute] { get set }
}

public extension HTClosedTag {
    /// Writes the tag name and attributes without child content.
    ///
    /// - Parameter writer: The destination that receives the rendered tag.
    func write(to writer: inout some HTWriter) {
        writer.write("<\(name())")
        attributes.forEach { attribute in attribute.write(to: &writer) }
        writer.write("/>")
    }
}

/// A generic void HTML tag.
///
/// Use `ClosedTag` for HTML void elements that do not accept child content.
public struct ClosedTag : HTClosedTag {
    /// The HTML tag name to render.
    public var name: () -> String

    /// The attributes rendered in the tag.
    public var attributes: [HTAttribute] = []

    /// Creates a closed tag from variadic attributes.
    ///
    /// - Parameters:
    ///   - name: The HTML tag name.
    ///   - attributes: Attributes to render in the tag.
    public init(name: @autoclosure @escaping () -> String, _ attributes: HTAttribute...) {
        self.name = name
        self.attributes = attributes
    }

    /// Creates a closed tag from an attribute array.
    ///
    /// - Parameters:
    ///   - name: The HTML tag name.
    ///   - attributes: Attributes to render in the tag.
    public init(name: @autoclosure @escaping () -> String, _ attributes: [HTAttribute] = []) {
        self.name = name
        self.attributes = attributes
    }
}

/// Unescaped HTML markup.
///
/// Use `RawHTML` only for trusted markup. Text values written as `String`,
/// `Int`, `Float`, and `Double` are escaped automatically; `RawHTML` bypasses
/// that protection and writes its content exactly as provided.
public struct RawHTML: HTElement {
    /// The raw markup to write.
    public var content: String

    /// Creates a raw HTML element.
    ///
    /// - Parameter content: Trusted markup to write without escaping.
    public init(_ content: String) {
        self.content = content
    }

    /// Writes the raw markup without escaping.
    ///
    /// - Parameter writer: The destination that receives the markup.
    public func write(to writer: inout some HTWriter) {
        writer.write(content)
    }
}

extension CustomStringConvertible {
    /// Writes a string-convertible value as escaped HTML text.
    ///
    /// - Parameter writer: The destination that receives the escaped text.
    public func write(to writer: inout some HTWriter) {
        writeEncodedHtml(self, to: &writer)
    }
}

extension String : HTElement {

}

extension Int : HTElement {

}

extension Float : HTElement {

}

extension Double : HTElement {

}

#if canImport(SwiftUI) && canImport(WebKit)
    import SwiftUI
    import WebKit

    /// A SwiftUI view that renders SwiftHT content in a WebKit-backed view.
    ///
    /// `HTView` rebuilds the supplied HTML element in a task and loads the
    /// rendered string into a `WebPage`. It is available only on platforms where
    /// the required SwiftUI and WebKit APIs are present.
    @available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, visionOS 26.0, *)
    public struct HTView<U: View, E: HTElement> : View {
        /// The page that receives the rendered HTML.
        @State public var page: WebPage

        /// The SwiftUI view used to display the page.
        public let view: U

        /// A builder closure that creates the HTML element to display.
        public let element: () -> E

        /// Creates a SwiftUI-backed HTML view.
        ///
        /// - Parameters:
        ///   - page: A factory that creates the WebKit page.
        ///   - view: A factory that creates the SwiftUI view for the page.
        ///   - element: A builder that returns the HTML content to load.
        public init(page: () -> WebPage = { WebPage() }, view: (WebPage) -> U = { WebView($0) }, @HTBuilder _ element: @escaping () -> E) {
            let p = page()
            self._page = State(initialValue: p)
            self.view = view(p)
            self.element = element
        }

        /// The SwiftUI body that loads rendered HTML into the page.
        public var body: some View {
            view.task {
                var writer = BufferedHTWriter()
                element().write(to: &writer)
                self.page.load(html: String(bytes: writer.data, encoding: .utf8) ?? "")
            }
        }
    }
#endif
