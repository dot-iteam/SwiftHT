//
//  Component.swift
//  SwiftHT
//
//  Created by Dot iTeam on 2026-05-28.
//

/// A reusable HTML component with a computed body.
///
/// `HTComponent` follows the same broad shape as SwiftUI's `View`: define a
/// type, provide a ``body`` made from SwiftHT elements, and use the component
/// anywhere an ``HTElement`` is accepted.
public protocol HTComponent : HTElement where Content: HTElement {
    /// The concrete element tree rendered by the component.
    associatedtype Content

    /// The HTML content produced by the component.
    var body: Content { get }
}

public extension HTComponent {
    /// Writes the component's body to the writer.
    ///
    /// - Parameter writer: The destination that receives the rendered markup.
    func write(to writer: inout some HTWriter) {
        body.write(to: &writer)
    }
}

/// A reusable CSS component with a computed style body.
///
/// Use `CSSComponent` to encapsulate related CSS rules and include them inside a
/// ``Style(_:_:)`` tag.
public protocol CSSComponent : CSSElement where Content: CSSElement {
    /// The concrete CSS element tree rendered by the component.
    associatedtype Content

    /// The CSS content produced by the component.
    var style: Content { get }
}

public extension CSSComponent {
    /// Writes the component's style body to the writer.
    ///
    /// - Parameter writer: The destination that receives the rendered CSS.
    func write(to writer: inout some HTWriter) {
        style.write(to: &writer)
    }
}
