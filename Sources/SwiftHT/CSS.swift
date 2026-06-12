//
//  CSS.swift
//  SwiftHT
//
//  Created by Dot iTeam on 2026-05-27.
//

/// A value that can render itself as CSS inside SwiftHT markup.
///
/// CSS elements also conform to ``HTElement`` so they can be placed inside a
/// ``Style(_:_:)`` tag and written by the same rendering pipeline.
public protocol CSSElement : HTElement {

}

/// A variadic group of CSS elements that renders each element in order.
///
/// `CSSGroup` is the concrete type that ``CSSBuilder`` uses for blocks with
/// multiple CSS rules or properties.
public struct CSSGroup<each E: CSSElement> : CSSElement {
    /// The grouped CSS elements, stored as a Swift variadic value pack.
    public let value: (repeat each E)

    /// Creates a group from one or more CSS elements.
    ///
    /// - Parameter value: The elements to render in order.
    public init(value: repeat each E) {
        self.value = (repeat each value)
    }

    /// Writes each grouped CSS element to the writer in source order.
    ///
    /// - Parameter writer: The destination that receives the rendered CSS.
    public func write(to writer: inout some HTWriter) {
        repeat (each value).write(to: &writer)
    }
}

/// An empty CSS element used by builders and generic defaults.
public struct EmptyCSS : CSSElement {
    /// Creates an empty CSS element.
    public init() {}

    /// Writes no output.
    ///
    /// - Parameter writer: The destination writer, unused for empty content.
    public func write(to _: inout some HTWriter) {

    }
}

/// A wrapper that conditionally renders an optional CSS element.
public struct CSSOptional<E: CSSElement> : CSSElement {
    /// The optional CSS element to render.
    public let value: E?

    /// Creates an optional CSS wrapper.
    ///
    /// - Parameter value: The optional element to render when present.
    public init(_ value: E?) {
        self.value = value
    }

    /// Writes the wrapped element when it exists.
    ///
    /// - Parameter writer: The destination that receives the rendered CSS.
    public func write(to writer: inout some HTWriter) {
        if let value {
            value.write(to: &writer)
        }
    }
}

/// A type-erased CSS element.
///
/// Use `AnyCSSElement` when you need to store heterogeneous CSS element values
/// in a single variable or collection.
public struct AnyCSSElement : CSSElement {
    /// The wrapped CSS element value.
    public let value: any CSSElement

    /// Erases the concrete type of a CSS element.
    ///
    /// - Parameter value: The element to wrap.
    public init<E: CSSElement>(_ value: E) {
        self.value = value
    }

    /// Writes the wrapped CSS element to the writer.
    ///
    /// - Parameter writer: The destination that receives the rendered CSS.
    public func write(to writer: inout some HTWriter) {
        value.write(to: &writer)
    }
}

/// A collection of CSS elements that renders each element in order.
public struct CSSArray<E: CSSElement> : CSSElement {
    /// The CSS elements to render.
    public let value: [E]

    /// Creates an array wrapper.
    ///
    /// - Parameter value: The elements to render in order.
    public init(_ value: [E]) {
        self.value = value
    }

    /// Writes each element in array order.
    ///
    /// - Parameter writer: The destination that receives the rendered CSS.
    public func write(to writer: inout some HTWriter) {
        value.forEach { $0.write(to: &writer) }
    }
}

/// A result-builder conditional that renders either the true or false CSS branch.
public struct CSSConditional<TrueContent: CSSElement, FalseContent: CSSElement> : CSSElement {
    /// The condition that selected the branch.
    public let condition: Bool

    /// The element from the true branch, when selected.
    public let first: TrueContent?

    /// The element from the false branch, when selected.
    public let second: FalseContent?

    /// Creates a CSS conditional wrapper.
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
    /// - Parameter writer: The destination that receives the rendered CSS.
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

/// A result builder for composing CSS rules and properties.
///
/// `CSSBuilder` supports CSS elements, `(String, String)` property tuples,
/// `[String: String]` dictionaries, optionals, conditionals, and loops. Prefer
/// tuples or explicit ``prop(_:_:)`` calls when property order matters.
@resultBuilder
public struct CSSBuilder {
    /// Accepts a single CSS element expression.
    ///
    /// - Parameter element: The CSS element expression in the builder body.
    /// - Returns: The same element.
    public static func buildExpression<C: CSSElement>(_ element: C) -> C {
        element
    }

    /// Converts a `(property, value)` tuple into a CSS property.
    ///
    /// - Parameter element: A tuple containing the CSS property name and value.
    /// - Returns: A ``CSSProperty`` that renders as `name:value;`.
    public static func buildExpression(_ element: (String, String)) -> CSSProperty {
        .prop(element.0, element.1)
    }

    /// Converts a string dictionary into CSS properties.
    ///
    /// Dictionary iteration order is not guaranteed. Use tuples or ``prop(_:_:)``
    /// when stable output order is important.
    ///
    /// - Parameter element: A dictionary of CSS property names and values.
    /// - Returns: An array wrapper containing one property for each entry.
    public static func buildExpression(_ element: [String: String]) -> CSSArray<CSSProperty> {
        CSSArray(element.map { entry in CSSProperty.prop(entry.key, entry.value) })
    }

    /// Combines zero or more CSS elements into a group.
    ///
    /// - Parameter components: The elements in the builder block.
    /// - Returns: A group that renders the elements in order.
    public static func buildBlock<each E: CSSElement>(_ components: repeat each E) -> CSSGroup<repeat each E> {
        CSSGroup<repeat each E>(value: repeat each components)
    }

    /// Starts an incremental builder block.
    ///
    /// - Parameter first: The first CSS element in the block.
    /// - Returns: A group containing the first element.
    public static func buildPartialBlock<C1: CSSElement>(first: C1) -> CSSGroup<C1> {
        return CSSGroup<C1>(value: first)
    }

    /// Appends a CSS element to an incremental builder block.
    ///
    /// - Parameters:
    ///   - accumulated: The elements collected so far.
    ///   - next: The next element in the block.
    /// - Returns: A group containing the accumulated elements and the next element.
    public static func buildPartialBlock<each E: CSSElement, C: CSSElement>(accumulated: CSSGroup<repeat each E>, next: C) -> CSSGroup<repeat each E, C> {
        return CSSGroup<repeat each E, C>(value: repeat each accumulated.value, next)
    }

    /// Wraps an optional CSS element from an `if` statement without an `else` branch.
    ///
    /// - Parameter component: The optional builder result.
    /// - Returns: A wrapper that renders the component when present.
    public static func buildOptional<C: CSSElement>(_ component: C?) -> CSSOptional<C> {
        return CSSOptional(component)
    }

    /// Wraps the true branch of an `if`/`else` statement.
    ///
    /// - Parameter first: The true branch content.
    /// - Returns: A conditional wrapper for the true branch.
    public static func buildEither<TrueContent: CSSElement, FalseContent: CSSElement>(first: TrueContent) -> CSSConditional<TrueContent, FalseContent> {
        CSSConditional(condition: true, first: first, second: nil)
    }

    /// Wraps the false branch of an `if`/`else` statement.
    ///
    /// - Parameter second: The false branch content.
    /// - Returns: A conditional wrapper for the false branch.
    public static func buildEither<TrueContent: CSSElement, FalseContent: CSSElement>(second: FalseContent) -> CSSConditional<TrueContent, FalseContent> {
        CSSConditional(condition: false, first: nil, second: second)
    }

    /// Wraps CSS elements produced by a `for` loop.
    ///
    /// - Parameter components: The elements produced by the loop.
    /// - Returns: An array wrapper that renders the elements in order.
    public static func buildArray<C: CSSElement>(_ components: [C]) -> CSSArray<C> {
        CSSArray(components)
    }
}

/// A CSS declaration that renders as `property:value;`.
public enum CSSProperty : CSSElement {
    /// A CSS property and value pair.
    case prop(String, String)

    /// A placeholder that renders no CSS.
    case none

    /// Writes the CSS property to the writer.
    ///
    /// - Parameter writer: The destination that receives the rendered CSS.
    public func write(to writer: inout some HTWriter) {
        switch self {
        case .prop(let key, let value):
            writer.write("\(key):\(value);")
        case .none:
            break
        }
    }
}

extension Dictionary: HTElement where Key == String, Value == String {
    /// Writes each dictionary entry as a CSS property.
    ///
    /// Dictionary iteration order is not guaranteed. Use this convenience for
    /// compact examples or unordered declarations, not for tests that require
    /// stable output.
    ///
    /// - Parameter writer: The destination that receives the rendered CSS.
    public func write(to writer: inout some HTWriter) {
        self.forEach { key, value in
            CSSProperty.prop(key, value).write(to: &writer)
        }
    }
}

/// Creates a CSS property declaration.
///
/// - Parameters:
///   - key: The CSS property name.
///   - value: The CSS property value.
/// - Returns: A property that renders as `key:value;`.
public func prop(_ key: String, _ value: String) -> CSSProperty {
    .prop(key, value)
}

/// A CSS rule with a selector, optional leading properties, and builder content.
///
/// `Css` renders compact CSS such as `button{background:white;}`. Use the
/// `css` helper functions for the normal DSL spelling.
public struct Css<Content: CSSElement>: CSSElement {
    /// The CSS selector or at-rule header.
    public let value: String

    /// Properties rendered before the builder content.
    public let properties: [CSSProperty]

    /// Additional CSS content rendered inside the rule.
    public let content: Content

    /// Creates a CSS rule from variadic properties and a content builder.
    ///
    /// - Parameters:
    ///   - value: The selector or at-rule header.
    ///   - properties: Properties rendered before the builder content.
    ///   - content: A builder that returns additional declarations or nested rules.
    public init(_ value: String, _ properties: CSSProperty..., @CSSBuilder content: () -> Content) {
        self.value = value
        self.properties = properties
        self.content = content()
    }

    /// Creates a CSS rule from an array of properties and a content builder.
    ///
    /// - Parameters:
    ///   - value: The selector or at-rule header.
    ///   - properties: Properties rendered before the builder content.
    ///   - content: A builder that returns additional declarations or nested rules.
    public init(_ value: String, _ properties: [CSSProperty] = [], @CSSBuilder content: () -> Content) {
        self.value = value
        self.properties = properties
        self.content = content()
    }

    /// Writes the selector, properties, content, and closing brace.
    ///
    /// - Parameter writer: The destination that receives the rendered CSS.
    public func write(to writer: inout some HTWriter) {
        writer.write("\(value){")
        properties.forEach { $0.write(to: &writer) }
        content.write(to: &writer)
        writer.write("}")
    }
}

extension Css where Content == EmptyCSS {
    /// Creates a CSS rule that contains only variadic properties.
    ///
    /// - Parameters:
    ///   - value: The selector or at-rule header.
    ///   - properties: Properties rendered inside the rule.
    public init(_ value: String, _ properties: CSSProperty...) {
        self.value = value
        self.properties = properties
        self.content = EmptyCSS()
    }
}

/// Creates a CSS rule that contains only properties.
///
/// - Parameters:
///   - value: The selector or at-rule header.
///   - properties: Properties rendered inside the rule.
/// - Returns: A CSS rule element.
public func css(_ value: String, _ properties: CSSProperty...) -> Css<CSSGroup<EmptyCSS>> {
    .init(value, properties, content: { EmptyCSS() })
}

/// Creates a CSS rule from properties and builder content.
///
/// - Parameters:
///   - value: The selector or at-rule header.
///   - properties: Properties rendered before the builder content.
///   - content: A builder that returns additional declarations or nested rules.
/// - Returns: A CSS element that renders the rule.
public func css(_ value: String, _ properties: CSSProperty..., @CSSBuilder content: () -> some CSSElement) -> some CSSElement {
    Css(value, properties, content: content)
}
