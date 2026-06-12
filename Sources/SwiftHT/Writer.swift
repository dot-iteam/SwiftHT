//
//  Writer.swift
//  SwiftHT
//
//  Created by Dot iTeam on 2026-05-27.
//

/// A destination that receives rendered SwiftHT output.
///
/// Writers let elements stream their HTML representation without requiring each
/// element to allocate an intermediate string.
public protocol HTWriter {
    /// Appends a value's textual representation to the output.
    ///
    /// `HTWriter` does not escape values by itself. Elements decide whether to
    /// call this method directly or route text through ``writeEncodedHtml(_:to:)``.
    ///
    /// - Parameter value: The value to append to the writer.
    mutating func write(_ value: some CustomStringConvertible)
}

/// A byte-buffered writer for UTF-8 HTML output.
///
/// `BufferedHTWriter` is the default writer used by ``HTElement/description``
/// and ``hyperData(capacity:content:)``.
public struct BufferedHTWriter : HTWriter {
    /// The rendered output bytes.
    public var data: Array<UInt8>

    /// Creates a buffered writer with reserved storage.
    ///
    /// - Parameter capacity: The initial byte capacity to reserve.
    public init(capacity: Int = 4*1024) {
        data = []
        data.reserveCapacity(capacity)
    }

    /// Appends a value's UTF-8 description bytes to the buffer.
    ///
    /// - Parameter value: The value to append.
    public mutating func write(_ value: some CustomStringConvertible) {
        data.append(contentsOf: value.description.utf8)
    }
}
