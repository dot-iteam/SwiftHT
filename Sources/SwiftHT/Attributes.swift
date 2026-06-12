//
//  Attributes.swift
//  SwiftHT
//
//  Created by Dot iTeam on 2026-05-27.
//

public extension HTAttribute {
    /// Creates an `accept` attribute.
    @inlinable
    static func accept(_ value: String) -> HTAttribute {
        .attr("accept", value)
    }

    /// Creates an `accept-charset` attribute.
    @inlinable
    static func acceptCharset(_ value: String) -> HTAttribute {
        .attr("accept-charset", value)
    }

    /// Creates an `accesskey` attribute.
    @inlinable
    static func accessKey(_ value: String) -> HTAttribute {
        .attr("accesskey", value)
    }

    /// Creates an `accesskey` attribute using the legacy misspelled helper.
    @available(*, deprecated, renamed: "accessKey(_:)")
    @inlinable
    static func acccessKey(_ value: String) -> HTAttribute {
        accessKey(value)
    }

    /// Creates an `action` attribute.
    @inlinable
    static func action(_ value: String) -> HTAttribute {
        .attr("action", value)
    }

    /// Creates an `allow` attribute.
    @inlinable
    static func allow(_ value: String) -> HTAttribute {
        .attr("allow", value)
    }

    /// Creates an `alpha` attribute.
    @inlinable
    static func alpha(_ value: String) -> HTAttribute {
        .attr("alpha", value)
    }

    /// Creates an `alt` attribute.
    @inlinable
    static func alt(_ value: String) -> HTAttribute {
        .attr("alt", value)
    }

    /// Creates an `as` attribute.
    @inlinable
    static func `as`(_ value: String) -> HTAttribute {
        .attr("as", value)
    }

    /// Creates an `async` attribute with an explicit value.
    @inlinable
    static func `async`(_ value: String) -> HTAttribute {
        .attr("async", value)
    }

    /// Creates an `autocapitalize` attribute.
    @inlinable
    static func autocapitalize(_ value: String) -> HTAttribute {
        .attr("autocapitalize", value)
    }

    /// Creates an `autocomplete` attribute.
    @inlinable
    static func autocomplete(_ value: String) -> HTAttribute {
        .attr("autocomplete", value)
    }

    /// Creates an `autoplay` boolean attribute.
    @inlinable
    static func autoplay() -> HTAttribute {
        .single("autoplay")
    }

    /// Creates a `background` attribute.
    @inlinable
    static func background(_ value: String) -> HTAttribute {
        .attr("background", value)
    }

    /// Creates a `bgcolor` attribute.
    @inlinable
    static func bgcolor(_ value: String) -> HTAttribute {
        .attr("bgcolor", value)
    }

    /// Creates a `border` attribute.
    @inlinable
    static func border(_ value: String) -> HTAttribute {
        .attr("border", value)
    }

    /// Creates a `capture` attribute.
    @inlinable
    static func capture(_ value: String) -> HTAttribute {
        .attr("capture", value)
    }

    /// Creates a `charset` attribute.
    @inlinable
    static func charset(_ value: String) -> HTAttribute {
        .attr("charset", value)
    }

    /// Creates a `checked` boolean attribute.
    @inlinable
    static func checked() -> HTAttribute {
        .single("checked")
    }

    /// Creates a `cite` attribute.
    @inlinable
    static func cite(_ value: String) -> HTAttribute {
        .attr("cite", value)
    }

    /// Creates a `class` attribute.
    @inlinable
    static func `class`(_ value: String) -> HTAttribute {
        .attr("class", value)
    }

    /// Creates a `color` attribute.
    @inlinable
    static func color(_ value: String) -> HTAttribute {
        .attr("color", value)
    }

    /// Creates a `colorspace` attribute.
    @inlinable
    static func colorspace(_ value: String) -> HTAttribute {
        .attr("colorspace", value)
    }

    /// Creates a `cols` attribute.
    @inlinable
    static func cols(_ value: String) -> HTAttribute {
        .attr("cols", value)
    }

    /// Creates a `colspan` attribute.
    @inlinable
    static func colspan(_ value: String) -> HTAttribute {
        .attr("colspan", value)
    }

    /// Creates a `content` attribute.
    @inlinable
    static func content(_ value: String) -> HTAttribute {
        .attr("content", value)
    }

    /// Creates a `contenteditable` attribute.
    @inlinable
    static func contenteditable(_ value: String) -> HTAttribute {
        .attr("contenteditable", value)
    }

    /// Creates a `controls` boolean attribute.
    @inlinable
    static func controls() -> HTAttribute {
        .single("controls")
    }

    /// Creates a `coords` attribute.
    @inlinable
    static func coords(_ value: String) -> HTAttribute {
        .attr("coords", value)
    }

    /// Creates a `crossorigin` attribute.
    @inlinable
    static func crossorigin(_ value: String) -> HTAttribute {
        .attr("crossorigin", value)
    }

    /// Creates a `command` attribute.
    @inlinable
    static func command(_ value: String) -> HTAttribute {
        .attr("command", value)
    }

    /// Creates a `commandfor` attribute.
    @inlinable
    static func commandfor(_ value: String) -> HTAttribute {
        .attr("commandfor", value)
    }

    /// Creates a `csp` attribute.
    @inlinable
    static func csp(_ value: String) -> HTAttribute {
        .attr("csp", value)
    }

    /// Creates a `data` attribute.
    @inlinable
    static func data(_ value: String) -> HTAttribute {
        .attr("data", value)
    }

    /// Creates a `datetime` attribute.
    @inlinable
    static func datetime(_ value: String) -> HTAttribute {
        .attr("datetime", value)
    }

    /// Creates a `decoding` attribute.
    @inlinable
    static func decoding(_ value: String) -> HTAttribute {
        .attr("decoding", value)
    }

    /// Creates a `default` attribute with an explicit value.
    @inlinable
    static func `default`(_ value: String) -> HTAttribute {
        .attr("default", value)
    }

    /// Creates a `defer` attribute with an explicit value.
    @inlinable
    static func `defer`(_ value: String) -> HTAttribute {
        .attr("defer", value)
    }

    /// Creates a `dir` attribute.
    @inlinable
    static func dir(_ value: String) -> HTAttribute {
        .attr("dir", value)
    }

    /// Creates a `dirname` attribute.
    @inlinable
    static func dirname(_ value: String) -> HTAttribute {
        .attr("dirname", value)
    }

    /// Creates a `disabled` attribute with an explicit value.
    @inlinable
    static func disabled(_ value: String) -> HTAttribute {
        .attr("disabled", value)
    }

    /// Creates a `download` boolean attribute.
    @inlinable
    static func download() -> HTAttribute {
        .single("download")
    }

    /// Creates a `draggable` attribute.
    @inlinable
    static func draggable(_ value: String) -> HTAttribute {
        .attr("draggable", value)
    }

    /// Creates an `enctype` attribute.
    @inlinable
    static func enctype(_ value: String) -> HTAttribute {
        .attr("enctype", value)
    }

    /// Creates an `enterkeyhint` attribute.
    @inlinable
    static func enterkeyhint(_ value: String) -> HTAttribute {
        .attr("enterkeyhint", value)
    }

    /// Creates an `elementtiming` attribute.
    @inlinable
    static func elementtiming(_ value: String) -> HTAttribute {
        .attr("elementtiming", value)
    }

    /// Creates a `fetchpriority` attribute.
    @inlinable
    static func fetchpriority(_ value: String) -> HTAttribute {
        .attr("fetchpriority", value)
    }

    /// Creates a `for` attribute.
    @inlinable
    static func `for`(_ value: String) -> HTAttribute {
        .attr("for", value)
    }

    /// Creates a `form` attribute.
    @inlinable
    static func form(_ value: String) -> HTAttribute {
        .attr("form", value)
    }

    /// Creates a `formaction` attribute.
    @inlinable
    static func formaction(_ value: String) -> HTAttribute {
        .attr("formaction", value)
    }

    /// Creates a `formenctype` attribute.
    @inlinable
    static func formenctype(_ value: String) -> HTAttribute {
        .attr("formenctype", value)
    }

    /// Creates a `formmethod` attribute.
    @inlinable
    static func formmethod(_ value: String) -> HTAttribute {
        .attr("formmethod", value)
    }

    /// Creates a `formnovalidate` boolean attribute.
    @inlinable
    static func formnovalidate() -> HTAttribute {
        .single("formnovalidate")
    }

    /// Creates a `formtarget` attribute.
    @inlinable
    static func formtarget(_ value: String) -> HTAttribute {
        .attr("formtarget", value)
    }

    /// Creates a `headers` attribute.
    @inlinable
    static func headers(_ value: String) -> HTAttribute {
        .attr("headers", value)
    }

    /// Creates a `height` attribute.
    @inlinable
    static func height(_ value: String) -> HTAttribute {
        .attr("height", value)
    }

    /// Creates a `hidden` boolean attribute.
    @inlinable
    static func hidden() -> HTAttribute {
        .single("hidden")
    }

    /// Creates a `high` attribute.
    @inlinable
    static func high(_ value: String) -> HTAttribute {
        .attr("high", value)
    }

    /// Creates an `href` attribute.
    @inlinable
    static func href(_ value: String) -> HTAttribute {
        .attr("href", value)
    }

    /// Creates an `hreflang` attribute.
    @inlinable
    static func hreflang(_ value: String) -> HTAttribute {
        .attr("hreflang", value)
    }

    /// Creates an `http-equiv` attribute.
    @inlinable
    static func httpEquiv(_ value: String) -> HTAttribute {
        .attr("http-equiv", value)
    }

    /// Creates an `id` attribute.
    @inlinable
    static func id(_ value: String) -> HTAttribute {
        .attr("id", value)
    }

    /// Creates an `integrity` attribute.
    @inlinable
    static func integrity(_ value: String) -> HTAttribute {
        .attr("integrity", value)
    }

    /// Creates an `inputmode` attribute.
    @inlinable
    static func inputmode(_ value: String) -> HTAttribute {
        .attr("inputmode", value)
    }

    /// Creates an `ismap` boolean attribute.
    @inlinable
    static func ismap() -> HTAttribute {
        .single("ismap")
    }

    /// Creates an `itemprop` attribute.
    @inlinable
    static func itemprop(_ value: String) -> HTAttribute {
        .attr("itemprop", value)
    }

    /// Creates a `kind` attribute.
    @inlinable
    static func kind(_ value: String) -> HTAttribute {
        .attr("kind", value)
    }

    /// Creates a `label` attribute.
    @inlinable
    static func label(_ value: String) -> HTAttribute {
        .attr("label", value)
    }

    /// Creates a `lang` attribute.
    @inlinable
    static func lang(_ value: String) -> HTAttribute {
        .attr("lang", value)
    }

    /// Creates a `language` attribute.
    @inlinable
    static func language(_ value: String) -> HTAttribute {
        .attr("language", value)
    }

    /// Creates a `loading` attribute.
    @inlinable
    static func loading(_ value: String) -> HTAttribute {
        .attr("loading", value)
    }

    /// Creates a `list` attribute.
    @inlinable
    static func list(_ value: String) -> HTAttribute {
        .attr("list", value)
    }

    /// Creates a `loop` boolean attribute.
    @inlinable
    static func loop() -> HTAttribute {
        .single("loop")
    }

    /// Creates a `low` attribute.
    @inlinable
    static func low(_ value: String) -> HTAttribute {
        .attr("low", value)
    }

    /// Creates a `max` attribute.
    @inlinable
    static func max(_ value: String) -> HTAttribute {
        .attr("max", value)
    }

    /// Creates a `maxlength` attribute.
    @inlinable
    static func maxlength(_ value: String) -> HTAttribute {
        .attr("maxlength", value)
    }

    /// Creates a `minlength` attribute.
    @inlinable
    static func minlength(_ value: String) -> HTAttribute {
        .attr("minlength", value)
    }

    /// Creates a `media` attribute.
    @inlinable
    static func media(_ value: String) -> HTAttribute {
        .attr("media", value)
    }

    /// Creates a `method` attribute.
    @inlinable
    static func method(_ value: String) -> HTAttribute {
        .attr("method", value)
    }

    /// Creates a `multiple` boolean attribute.
    @inlinable
    static func multiple() -> HTAttribute {
        .single("multiple")
    }

    /// Creates a `muted` boolean attribute.
    @inlinable
    static func muted() -> HTAttribute {
        .single("muted")
    }

    /// Creates a `name` attribute.
    @inlinable
    static func name(_ value: String) -> HTAttribute {
        .attr("name", value)
    }

    /// Creates a `novalidate` boolean attribute.
    @inlinable
    static func novalidate() -> HTAttribute {
        .single("novalidate")
    }

    /// Creates an `open` boolean attribute.
    @inlinable
    static func open() -> HTAttribute {
        .single("open")
    }

    /// Creates an `optimum` attribute.
    @inlinable
    static func optimum(_ value: String) -> HTAttribute {
        .attr("optimum", value)
    }

    /// Creates a `pattern` attribute.
    @inlinable
    static func pattern(_ value: String) -> HTAttribute {
        .attr("pattern", value)
    }

    /// Creates a `ping` attribute.
    @inlinable
    static func ping(_ value: String) -> HTAttribute {
        .attr("ping", value)
    }

    /// Creates a `placeholder` attribute.
    @inlinable
    static func placeholder(_ value: String) -> HTAttribute {
        .attr("placeholder", value)
    }

    /// Creates a `playsinline` boolean attribute.
    @inlinable
    static func playsinline() -> HTAttribute {
        .single("playsinline")
    }

    /// Creates a `poster` attribute.
    @inlinable
    static func poster(_ value: String) -> HTAttribute {
        .attr("poster", value)
    }

    /// Creates a `preload` attribute.
    @inlinable
    static func preload(_ value: String) -> HTAttribute {
        .attr("preload", value)
    }

    /// Creates a `popover` boolean attribute.
    @inlinable
    static func popover() -> HTAttribute {
        .single("popover")
    }

    /// Creates a `popovertarget` attribute.
    @inlinable
    static func popovertarget(_ value: String) -> HTAttribute {
        .attr("popovertarget", value)
    }

    /// Creates a `popovertargetaction` attribute.
    @inlinable
    static func popovertargetaction(_ value: String) -> HTAttribute {
        .attr("popovertargetaction", value)
    }

    /// Creates a `readonly` boolean attribute.
    @inlinable
    static func readonly() -> HTAttribute {
        .single("readonly")
    }

    /// Creates a `referrerpolicy` attribute.
    @inlinable
    static func referrerpolicy(_ value: String) -> HTAttribute {
        .attr("referrerpolicy", value)
    }

    /// Creates a `rel` attribute.
    @inlinable
    static func rel(_ value: String) -> HTAttribute {
        .attr("rel", value)
    }

    /// Creates a `required` boolean attribute.
    @inlinable
    static func required() -> HTAttribute {
        .single("required")
    }

    /// Creates a `role` attribute.
    @inlinable
    static func role(_ value: String) -> HTAttribute {
        .attr("role", value)
    }

    /// Creates a `rows` attribute.
    @inlinable
    static func rows(_ value: String) -> HTAttribute {
        .attr("rows", value)
    }

    /// Creates a `rowspan` attribute.
    @inlinable
    static func rowspan(_ value: String) -> HTAttribute {
        .attr("rowspan", value)
    }

    /// Creates a `sandbox` attribute.
    @inlinable
    static func sandbox(_ value: String) -> HTAttribute {
        .attr("sandbox", value)
    }

    /// Creates a `selected` boolean attribute.
    @inlinable
    static func selected() -> HTAttribute {
        .single("selected")
    }

    /// Creates a `shape` attribute.
    @inlinable
    static func shape(_ value: String) -> HTAttribute {
        .attr("shape", value)
    }

    /// Creates a `size` attribute.
    @inlinable
    static func size(_ value: String) -> HTAttribute {
        .attr("size", value)
    }

    /// Creates a `sizes` attribute.
    @inlinable
    static func sizes(_ value: String) -> HTAttribute {
        .attr("sizes", value)
    }

    /// Creates a `slot` attribute.
    @inlinable
    static func slot(_ value: String) -> HTAttribute {
        .attr("slot", value)
    }

    /// Creates a `span` attribute.
    @inlinable
    static func span(_ value: String) -> HTAttribute {
        .attr("span", value)
    }

    /// Creates a `spellcheck` attribute.
    @inlinable
    static func spellcheck(_ value: String) -> HTAttribute {
        .attr("spellcheck", value)
    }

    /// Creates a `src` attribute.
    @inlinable
    static func src(_ value: String) -> HTAttribute {
        .attr("src", value)
    }

    /// Creates a `srcdoc` attribute.
    @inlinable
    static func srcdoc(_ value: String) -> HTAttribute {
        .attr("srcdoc", value)
    }

    /// Creates a `srclang` attribute.
    @inlinable
    static func srclang(_ value: String) -> HTAttribute {
        .attr("srclang", value)
    }

    /// Creates a `srcset` attribute.
    @inlinable
    static func srcset(_ value: String) -> HTAttribute {
        .attr("srcset", value)
    }

    /// Creates a `start` attribute.
    @inlinable
    static func start(_ value: String) -> HTAttribute {
        .attr("start", value)
    }

    /// Creates a `step` attribute.
    @inlinable
    static func step(_ value: String) -> HTAttribute {
        .attr("step", value)
    }

    /// Creates a `style` attribute.
    @inlinable
    static func style(_ value: String) -> HTAttribute {
        .attr("style", value)
    }

    /// Creates a `tabindex` attribute.
    @inlinable
    static func tabindex(_ value: String) -> HTAttribute {
        .attr("tabindex", value)
    }

    /// Creates a `target` attribute.
    @inlinable
    static func target(_ value: String) -> HTAttribute {
        .attr("target", value)
    }

    /// Creates a `title` attribute.
    @inlinable
    static func title(_ value: String) -> HTAttribute {
        .attr("title", value)
    }

    /// Creates a `translate` attribute.
    @inlinable
    static func translate(_ value: String) -> HTAttribute {
        .attr("translate", value)
    }

    /// Creates a `type` attribute.
    @inlinable
    static func type(_ value: String) -> HTAttribute {
        .attr("type", value)
    }

    /// Creates a `value` attribute.
    @inlinable
    static func value(_ value: String) -> HTAttribute {
        .attr("value", value)
    }

    /// Creates a `width` attribute.
    @inlinable
    static func width(_ value: String) -> HTAttribute {
        .attr("width", value)
    }

    /// Creates a `wrap` attribute.
    @inlinable
    static func wrap(_ value: String) -> HTAttribute {
        .attr("wrap", value)
    }
}
