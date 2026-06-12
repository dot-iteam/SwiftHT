//
//  Tags.swift
//  SwiftHT
//
//  Created by Dot iTeam on 2026-05-27.
//

/// Creates an `<a>` hyperlink element with attributes and child content.
public func A<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "a", attributes, build: build)
}

/// Creates an `<abbr>` abbreviation element with attributes and child content.
public func Abbr<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "abbr", attributes, build: build)
}

/// Creates an `<address>` contact-information element with attributes and child content.
public func Address<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "address", attributes, build: build)
}

/// Creates an `<area>` image-map area element.
public func Area(_ attributes: HTAttribute...) -> ClosedTag {
    .init(name: "area", attributes)
}

/// Creates an `<article>` element with attributes and child content.
public func Article<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "article", attributes, build: build)
}

/// Creates an `<aside>` complementary-content element with attributes and child content.
public func Aside<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "aside", attributes, build: build)
}

/// Creates an `<audio>` media element with attributes and child content.
public func Audio<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "audio", attributes, build: build)
}

/// Creates a `<b>` bring-attention element with attributes and child content.
public func B<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "b", attributes, build: build)
}

/// Creates a `<base>` document-base URL element.
public func Base(_ attributes: HTAttribute...) -> ClosedTag {
    .init(name: "base", attributes)
}

/// Creates a `<bdi>` bidirectional-isolation element with attributes and child content.
public func Bdi<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "bdi", attributes, build: build)
}

/// Creates a `<bdo>` bidirectional-override element with attributes and child content.
public func Bdo<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "bdo", attributes, build: build)
}

/// Creates a `<blockquote>` quotation element with attributes and child content.
public func Blockquote<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "blockquote", attributes, build: build)
}

/// Creates a `<body>` document body element with attributes and child content.
public func Body<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "body", attributes, build: build)
}

/// Creates a `<br>` line-break element.
public func Br(_ attributes: HTAttribute...) -> ClosedTag {
    .init(name: "br", attributes)
}

/// Creates a `<button>` interactive button element with attributes and child content.
public func Button<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "button", attributes, build: build)
}

/// Creates a `<canvas>` drawing surface element with attributes and child content.
public func Canvas<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "canvas", attributes, build: build)
}

/// Creates a `<caption>` table-caption element with attributes and child content.
public func Caption<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "caption", attributes, build: build)
}

/// Creates a `<cite>` citation element with attributes and child content.
public func Cite<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "cite", attributes, build: build)
}

/// Creates a `<code>` inline-code element with attributes and child content.
public func Code<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "code", attributes, build: build)
}

/// Creates a `<col>` table-column element.
public func Col(_ attributes: HTAttribute...) -> ClosedTag {
    .init(name: "col", attributes)
}

/// Creates a `<colgroup>` table-column-group element with attributes and child content.
public func Colgroup<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "colgroup", attributes, build: build)
}

/// Creates a `<data>` machine-readable data element with attributes and child content.
public func Data<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "data", attributes, build: build)
}

/// Creates a `<datalist>` predefined-options element with attributes and child content.
public func DataList<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "datalist", attributes, build: build)
}

/// Creates a `<dd>` description-detail element with attributes and child content.
public func Dd<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "dd", attributes, build: build)
}

/// Creates a `<del>` deleted-text element with attributes and child content.
public func Del<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    .init(name: "del", attributes, build: build)
}

/// Creates a `<details>` disclosure element with attributes and child content.
public func Details<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    .init(name: "details", attributes, build: build)
}

/// Creates a `<dfn>` defining-instance element with attributes and child content.
public func Dfn<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "dfn", attributes, build: build)
}

/// Creates a `<dialog>` dialog element with attributes and child content.
public func Dialog<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "dialog", attributes, build: build)
}

/// Creates a `<div>` generic flow-content element with attributes and child content.
public func Div<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "div", attributes, build: build)
}

/// Creates a `<dl>` description-list element with attributes and child content.
public func Dl<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "dl", attributes, build: build)
}

/// Creates a `<dt>` description-term element with attributes and child content.
public func Dt<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "dt", attributes, build: build)
}

/// Creates an `<em>` emphasis element with attributes and child content.
public func Em<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "em", attributes, build: build)
}

/// Creates an `<embed>` external-content element.
public func Embed(_ attributes: HTAttribute...) -> ClosedTag {
    .init(name: "embed", attributes)
}

/// Creates a `<fencedframe>` embedded fenced-frame element with attributes and child content.
public func FencedFrame<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "fencedframe", attributes, build: build)
}

/// Creates a `<fieldset>` form-fieldset element with attributes and child content.
public func Fieldset<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    .init(name: "fieldset", attributes, build: build)
}

/// Creates a `<figcaption>` figure-caption element with attributes and child content.
public func Figcaption<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "figcaption", attributes, build: build)
}

/// Creates a `<figure>` self-contained figure element with attributes and child content.
public func Figure<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "figure", attributes, build: build)
}

/// Creates a `<footer>` footer element with attributes and child content.
public func Footer<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "footer", attributes, build: build)
}

/// Creates a `<form>` form element with attributes and child content.
public func Form<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "form", attributes, build: build)
}

/// Creates a `<geolocation>` element with attributes and child content.
public func Geolocation<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "geolocation", attributes, build: build)
}

/// Creates an `<h1>` top-level heading element with attributes and child content.
public func H1<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "h1", attributes, build: build)
}

/// Creates an `<h2>` heading element with attributes and child content.
public func H2<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "h2", attributes, build: build)
}

/// Creates an `<h3>` heading element with attributes and child content.
public func H3<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "h3", attributes, build: build)
}

/// Creates an `<h4>` heading element with attributes and child content.
public func H4<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "h4", attributes, build: build)
}

/// Creates an `<h5>` heading element with attributes and child content.
public func H5<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "h5", attributes, build: build)
}

/// Creates an `<h6>` heading element with attributes and child content.
public func H6<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "h6", attributes, build: build)
}

/// Creates a `<head>` metadata container with attributes and child content.
public func Head<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "head", attributes, build: build)
}

/// Creates a `<header>` introductory-content element with attributes and child content.
public func Header<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "header", attributes, build: build)
}

/// Creates an `<hgroup>` heading-group element with attributes and child content.
public func Hgroup<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "hgroup", attributes, build: build)
}

/// Creates an `<hr>` thematic-break element.
public func Hr(_ attributes: HTAttribute...) -> ClosedTag {
    .init(name: "hr", attributes)
}

/// Creates an `<html>` document-root element with attributes and child content.
public func Html<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "html", attributes, build: build)
}

/// Creates an `<i>` idiomatic-text element with attributes and child content.
public func I<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    .init(name: "i", attributes, build: build)
}

/// Creates an `<iframe>` inline-frame element with attributes and child content.
public func Iframe<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "iframe", attributes, build: build)
}

/// Creates an `<img>` image element.
public func Img(_ attributes: HTAttribute...) -> ClosedTag {
    .init(name: "img", attributes)
}

/// Creates an `<input>` form-input element.
public func Input(_ attributes: HTAttribute...) -> ClosedTag {
    ClosedTag(name: "input", attributes)
}

/// Creates an `<ins>` inserted-text element with attributes and child content.
public func Ins<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "ins", attributes, build: build)
}

/// Creates a `<kbd>` keyboard-input element with attributes and child content.
public func Kbd<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "kbd", attributes, build: build)
}

/// Creates a `<label>` form-label element with attributes and child content.
public func Label<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "label", attributes, build: build)
}

/// Creates an `<li>` list-item element with attributes and child content.
public func Li<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "li", attributes, build: build)
}

/// Creates a `<link>` external-resource link element.
public func Link(_ attributes: HTAttribute...) -> ClosedTag {
    .init(name: "link", attributes)
}

/// Creates a `<main>` main-content element with attributes and child content.
public func Main<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "main", attributes, build: build)
}

/// Creates a `<map>` image-map element with attributes and child content.
public func Map<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "map", attributes, build: build)
}

/// Creates a `<mark>` highlighted-text element with attributes and child content.
public func Mark<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "mark", attributes, build: build)
}

/// Creates a `<menu>` menu/list element with attributes and child content.
public func Menu<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "menu", attributes, build: build)
}

/// Creates a `<meta>` metadata element.
public func Meta(_ attributes: HTAttribute...) -> ClosedTag {
    .init(name: "meta", attributes)
}

/// Creates a `<meter>` scalar-measurement element with attributes and child content.
public func Meter<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    .init(name: "meter", attributes, build: build)
}

/// Creates a `<nav>` navigation element with attributes and child content.
public func Nav<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "nav", attributes, build: build)
}

/// Creates a `<noscript>` fallback-content element with attributes and child content.
public func Noscript<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "noscript", attributes, build: build)
}

/// Creates an `<object>` external-object element with attributes and child content.
public func Object<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "object", attributes, build: build)
}

/// Creates an `<ol>` ordered-list element with attributes and child content.
public func Ol<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "ol", attributes, build: build)
}

/// Creates an `<optgroup>` option-group element with attributes and child content.
public func Optgroup<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "optgroup", attributes, build: build)
}

/// Creates an `<output>` calculation-output element with attributes and child content.
public func Output<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "output", attributes, build: build)
}

/// Creates a `<p>` paragraph element with attributes and child content.
public func P<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "p", attributes, build: build)
}

/// Creates a `<picture>` responsive-image container with attributes and child content.
public func Picture<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "picture", attributes, build: build)
}

/// Creates a `<pre>` preformatted-text element with attributes and child content.
public func Pre<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "pre", attributes, build: build)
}

/// Creates a `<progress>` progress-indicator element with attributes and child content.
public func Progress<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "progress", attributes, build: build)
}

/// Creates a `<q>` inline-quotation element with attributes and child content.
public func Q<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "q", attributes, build: build)
}

/// Creates an `<rp>` ruby-parenthesis fallback element with attributes and child content.
public func Rp<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "rp", attributes, build: build)
}

/// Creates an `<rt>` ruby-text element with attributes and child content.
public func Rt<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "rt", attributes, build: build)
}

/// Creates a `<ruby>` ruby-annotation element with attributes and child content.
public func Ruby<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "ruby", attributes, build: build)
}

/// Creates an `<s>` strikethrough element with attributes and child content.
public func S<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "s", attributes, build: build)
}

/// Creates a `<samp>` sample-output element with attributes and child content.
public func Samp<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "samp", attributes, build: build)
}

/// Creates a `<script>` script element with attributes and child content.
public func Script<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "script", attributes, build: build)
}

/// Creates a `<search>` search-region element with attributes and child content.
public func Search<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "search", attributes, build: build)
}

/// Creates a `<section>` section element with attributes and child content.
public func Section<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "section", attributes, build: build)
}

/// Creates a `<select>` option-picker element with attributes and child content.
public func Select<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "select", attributes, build: build)
}

/// Creates a `<selectedcontent>` selected-content element with attributes and child content.
public func SelectedContent<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "selectedcontent", attributes, build: build)
}

/// Creates a `<slot>` web-component slot element with attributes and child content.
public func Slot<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "slot", attributes, build: build)
}

/// Creates a `<small>` side-comment element with attributes and child content.
public func Small<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "small", attributes, build: build)
}

/// Creates a `<source>` media-source element.
public func Source(_ attributes: HTAttribute...) -> ClosedTag {
    .init(name: "source", attributes)
}

/// Creates a `<span>` generic phrasing-content element with attributes and child content.
public func Span<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "span", attributes, build: build)
}

/// Creates a `<strong>` strong-importance element with attributes and child content.
public func Strong<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "strong", attributes, build: build)
}

/// Creates a `<style>` embedded stylesheet element with attributes and child content.
public func Style<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "style", attributes, build: build)
}

/// Creates a `<sub>` subscript element with attributes and child content.
public func Sub<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "sub", attributes, build: build)
}

/// Creates a `<summary>` disclosure-summary element with attributes and child content.
public func Summary<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "summary", attributes, build: build)
}

/// Creates a `<sup>` superscript element with attributes and child content.
public func Sup<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "sup", attributes, build: build)
}

/// Creates a `<table>` table element with attributes and child content.
public func Table<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "table", attributes, build: build)
}

/// Creates a `<td>` table-data-cell element with attributes and child content.
public func Td<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "td", attributes, build: build)
}

/// Creates a `<template>` inert-template element with attributes and child content.
public func Template<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "template", attributes, build: build)
}

/// Creates a `<textarea>` multiline-text-input element with attributes and child content.
public func Textarea<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "textarea", attributes, build: build)
}

/// Creates a `<tfoot>` table-footer-group element with attributes and child content.
public func TFoot<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "tfoot", attributes, build: build)
}

/// Creates a `<th>` table-header-cell element with attributes and child content.
public func Th<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "th", attributes, build: build)
}

/// Creates a `<thead>` table-header-group element with attributes and child content.
public func THead<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "thead", attributes, build: build)
}

/// Creates a `<time>` date/time element with attributes and child content.
public func Time<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "time", attributes, build: build)
}

/// Creates a `<title>` document-title element with attributes and child content.
public func Title<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "title", attributes, build: build)
}

/// Creates a `<tr>` table-row element with attributes and child content.
public func Tr<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    Tag(name: "tr", attributes, build: build)
}

/// Creates a `<track>` media-text-track element.
public func Track(_ attributes: HTAttribute...) -> ClosedTag {
    .init(name: "track", attributes)
}

/// Creates a `<u>` unarticulated-annotation element with attributes and child content.
public func U<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    .init(name: "u", attributes, build: build)
}

/// Creates a `<ul>` unordered-list element with attributes and child content.
public func Ul<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    .init(name: "ul", attributes, build: build)
}

/// Creates a `<var>` variable element with attributes and child content.
public func Var<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    .init(name: "var", attributes, build: build)
}

/// Creates a `<video>` media element with attributes and child content.
public func Video<Content: HTElement>(_ attributes: HTAttribute..., @HTBuilder build: () -> Content) -> Tag<Content> {
    .init(name: "video", attributes, build: build)
}

/// Creates a `<wbr>` word-break-opportunity element.
public func Wbr(_ attributes: HTAttribute...) -> ClosedTag {
    .init(name: "wbr", attributes)
}
