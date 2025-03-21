import CoenttbHTML
import Markdown

public struct HTMLMarkdown: HTML {
    public struct Section {
        public let title: String
        public let id: String
        public let level: Int
        public let timestamp: Timestamp?
        
        public var anchor: String {
            "#\(id)"
        }
        
        public init(title: String, id: String, level: Int, timestamp: Timestamp?) {
            self.title = title
            self.id = id
            self.level = level
            self.timestamp = timestamp
        }
    }
    
    public let markdown: String
    public let previewOnly: Bool
    public let tableOfContents: [Section]
    public let content: AnyHTML
    
    public init(_ markdown: String, previewOnly: Bool = false) {
        self.markdown = markdown
        self.previewOnly = previewOnly
        var converter = HTMLConverter(previewOnly: previewOnly)
        self.content = converter.visit(Document(parsing: markdown, options: .parseBlockDirectives))
        self.tableOfContents = converter.tableOfContents
    }
    
    public var body: some HTML {
        tag("swift-html-markdown") {
            VStack(spacing: 0.5.rem) {
                content
            }
            .inlineStyle(
                "mask-image",
                previewOnly ? "linear-gradient(to bottom,black 50%,transparent 100%)" : nil
            )
        }
        .display(.block)
    }
}

private struct HTMLConverter: MarkupVisitor {
    typealias Result = AnyHTML
    
    let previewOnly: Bool
    
    init(previewOnly: Bool) {
        self.previewOnly = previewOnly
    }
    
    private var currentTimestamp: Timestamp?
    private var currentSection: (title: String, id: String, level: Int)?
    private var ids: Set<Slug> = []
    var tableOfContents: [HTMLMarkdown.Section] = []
    
    @HTMLBuilder
    mutating func defaultVisit(_ markup: any Markup) -> AnyHTML {
        for child in markup.children {
            let html = visit(child)
            if previewOnly ? tableOfContents.count <= 1 : true {
                html
            }
        }
    }
    
    @HTMLBuilder
    mutating func visitBlockDirective(_ blockDirective: Markdown.BlockDirective) -> AnyHTML {
        switch blockDirective.name {
        case "Button":
            VStack(alignment: .center) {
                
                Button(
                    tag: a,
                    background: .buttonBackground,
                    style: .secondary
                ) {
                    for child in blockDirective.children {
                        visit(child)
                    }
                }
                .href(blockDirective.argumentText.segments.map(\.trimmedText).joined(separator: " "))
                .margin(vertical: 0.5.rem, horizontal: 0)
            }
            
        case "Comment":
            HTMLEmpty()
            
        case "T":
            let segments = blockDirective.argumentText.segments
                .map(\.trimmedText)
                .joined()
                .split(separator: ", ")
            
            if let segment = segments.first {
                let timestamp = Timestamp(
                    format: String(segment),
                    speaker: segments.dropFirst().first.map { String($0) }
                )
                let _ = currentTimestamp = timestamp
                timestamp
                if let currentSection {
                    let _ = tableOfContents.append(
                        HTMLMarkdown.Section(
                            title: currentSection.title,
                            id: currentSection.id,
                            level: currentSection.level,
                            timestamp: timestamp
                        )
                    )
                    let _ = self.currentSection = nil
                }
            }
            
        case "Video":
            video {
                tag("source")
                    .attribute("src", value(forArgument: "source", block: blockDirective))
            }
            .attribute("poster", value(forArgument: "poster", block: blockDirective))
            .attribute("controls")
            .attribute("playsinline")
            .objectFit(.cover)
            .margin(bottom: 1.rem)
            
        default:
            for child in blockDirective.children {
                visit(child)
            }
        }
    }
    
    @HTMLBuilder
    mutating func visitBlockQuote(_ blockQuote: Markdown.BlockQuote) -> AnyHTML {
        let aside = Aside(blockQuote)
        if let level = DiagnosticLevel(aside: aside) {
            Diagnostic(level: level) {
                for child in aside.content {
                    visit(child)
                }
            }
            .padding(horizontal: 1.rem)
        } else {
            let style = BlockQuoteStyle(blockName: aside.kind.displayName)
            blockquote {
                VStack(spacing: 0.5.rem) {
                    strong {
                        HTMLText(aside.kind.displayName)
                    }
                    .color(style.borderColor)
                    
                    for child in aside.content {
                        visit(child)
                    }
                }
            }
            .color(.offBlack.withDarkColor(.offWhite))
            .backgroundColor(style.backgroundColor)
            .border(.all(width: 2.px, style: .solid, color: style.borderColor))
            .border(.radius(6.px))
            .margin(vertical: 0.5.rem, horizontal: 0)
            .padding(vertical: 1.rem, horizontal: 1.5.rem)
        }
    }
    
    @HTMLBuilder
    mutating func visitCodeBlock(_ codeBlock: Markdown.CodeBlock) -> AnyHTML {
        let language: (class: String, dataLine: String?)? = codeBlock.language.map {
            let languageInfo = $0.split(separator: ":", maxSplits: 2)
            let language = languageInfo[0]
            let dataLine = languageInfo.dropFirst().first
            let highlightColor = languageInfo.dropFirst(2).first
            return (
                class: "language-\(language)\(highlightColor.map { " highlight-\($0)" } ?? "")",
                dataLine: dataLine.map { String($0) }
            )
        }
        pre {
            code {
                HTMLText(codeBlock.code)
            }
            .attribute("class", language?.class)
            .linkUnderline(true)
        }
        .attribute("data-line", language?.dataLine)
        .backgroundColor(.offWhite.withDarkColor(.offBlack))
        .color(.black.withDarkColor(.gray900))
        .margin(0)
        .margin(bottom: 0.5.rem)
        .overflowX(.auto)
        .padding(vertical: 1.rem, horizontal: 1.5.rem)
        .border(.radius(6.px))
    }
    
    @HTMLBuilder
    mutating func visitEmphasis(_ emphasis: Markdown.Emphasis) -> AnyHTML {
        em {
            for child in emphasis.children {
                visit(child)
            }
        }
    }
    
    @HTMLBuilder
    mutating func visitHeading(_ heading: Markdown.Heading) -> AnyHTML {
        let id = ids.slug(for: heading.plainText)
        
        a {}
            .id(id)
            .display(.block)
            .position(.relative)
            .top((-5).em)
            .top((-0.5).em, media: .desktop)
            .visibility(.hidden)
        
        div {
            Header(heading.level + 2) {
                for child in heading.children {
                    visit(child)
                }
                
                Link(href: "#\(id)") {
                    SVG("Link") {
            """
            <svg xmlns="http://www.w3.org/2000/svg" height="20px" viewBox="0 -960 960 960" width="20px" fill="currentColor"><path d="M432-288H288q-79.68 0-135.84-56.23Q96-400.45 96-480.23 96-560 152.16-616q56.16-56 135.84-56h144v72H288q-50 0-85 35t-35 85q0 50 35 85t85 35h144v72Zm-96-156v-72h288v72H336Zm192 156v-72h144q50 0 85-35t35-85q0-50-35-85t-85-35H528v-72h144q79.68 0 135.84 56.23 56.16 56.22 56.16 136Q864-400 807.84-344 751.68-288 672-288H528Z"/></svg>
            """
                    }
                }
                .linkColor(.gray800.withDarkColor(.gray300))
                .display(.none)
                .display(.initial, pre: "article div:hover > * >")
                .left(0)
                .position(.absolute)
                .textAlign(.center)
                .top(2.px, media: .mobile)
                .width(2.5.rem)
            }
            .color(.offBlack.withDarkColor(.offWhite))
        }
        .margin(left: (-2.25).rem)
        .margin(left: (-2.5).rem, media: .desktop)
        .padding(left: 2.25.rem)
        .padding(left: 2.5.rem, media: .desktop)
        .position(.relative)
        
        let _ = currentSection = (title: heading.plainText, id: id, level: heading.level)
    }
    
    @HTMLBuilder
    mutating func visitHTMLBlock(_ html: Markdown.HTMLBlock) -> AnyHTML {
        HTMLRaw(html.rawHTML)
    }
    
    @HTMLBuilder
    mutating func visitImage(_ image: Markdown.Image) -> AnyHTML {
        if let source = image.source {
            VStack(alignment: .center) {
                Link(href: source) {
                    Image(source: source, description: image.title ?? "")
                        .margin(vertical: 0, horizontal: 1.rem)
                        .border(.radius(6.px))
                }
            }
        }
    }
    
    @HTMLBuilder
    mutating func visitInlineCode(_ inlineCode: Markdown.InlineCode) -> AnyHTML {
        code {
            HTMLText(inlineCode.code)
        }
    }
    
    @HTMLBuilder
    mutating func visitInlineHTML(_ inlineHTML: Markdown.InlineHTML) -> AnyHTML {
        HTMLRaw(inlineHTML.rawHTML)
    }
    
    @HTMLBuilder
    mutating func visitLineBreak(_ lineBreak: Markdown.LineBreak) -> AnyHTML {
        br()
    }
    
    @HTMLBuilder
    mutating func visitLink(_ link: Markdown.Link) -> AnyHTML {
        Link(href: link.destination ?? "#") {
            for child in link.children {
                visit(child)
            }
        }
        .attribute("title", link.title)
    }
    
    @HTMLBuilder
    mutating func visitListItem(_ listItem: Markdown.ListItem) -> AnyHTML {
        li {
            VStack(spacing: 0.5.rem) {
                for child in listItem.children {
                    visit(child)
                }
            }
        }
    }
    
    @HTMLBuilder
    mutating func visitOrderedList(_ orderedList: Markdown.OrderedList) -> AnyHTML {
        ol {
            for child in orderedList.children {
                visit(child)
            }
        }
        .flexContainer(direction: .column, rowGap: .length(0.5.rem))
    }
    
    @HTMLBuilder
    mutating func visitParagraph(_ paragraph: Markdown.Paragraph) -> AnyHTML {
        p {
            for child in paragraph.children {
                visit(child)
            }
        }
        .lineHeight(1.5)
        .padding(0)
        .margin(0)
    }
    
    @HTMLBuilder
    mutating func visitSoftBreak(_ softBreak: Markdown.SoftBreak) -> AnyHTML {
        " "
    }
    
    @HTMLBuilder
    mutating func visitStrikethrough(_ strikethrough: Markdown.Strikethrough) -> AnyHTML {
        s {
            for child in strikethrough.children {
                visit(child)
            }
        }
    }
    
    @HTMLBuilder
    mutating func visitStrong(_ strong: Markdown.Strong) -> AnyHTML {
        tag("strong") {
            for child in strong.children {
                visit(child)
            }
        }
    }
    
    @HTMLBuilder
    mutating func visitTable(_ table: Markdown.Table) -> AnyHTML {
        tag("table") {
            if !table.head.isEmpty {
                thead {
                    tr {
                        render(tag: th, cells: table.head.cells, columnAlignments: table.columnAlignments)
                    }
                }
            }
            if !table.body.isEmpty {
                tbody {
                    for row in table.body.rows {
                        tr {
                            render(tag: td, cells: row.cells, columnAlignments: table.columnAlignments)
                        }
                    }
                }
            }
        }
    }
    
    @HTMLBuilder
    private mutating func render(
        tag: HTMLTag,
        cells: some Sequence<Markdown.Table.Cell>,
        columnAlignments: [Table.ColumnAlignment?]
    ) -> AnyHTML {
        var column = 0
        for cell in cells {
            if cell.colspan > 0 && cell.rowspan > 0 {
                tag {
                    for child in cell.children {
                        visit(child)
                    }
                }
                .attribute("align", columnAlignments[column]?.attributeValue)
                .attribute("colspan", cell.colspan == 1 ? nil : "\(cell.colspan)")
                .attribute("rowspan", cell.rowspan == 1 ? nil : "\(cell.rowspan)")
                
                let _ = column += Int(cell.colspan)
            }
        }
    }
    
    @HTMLBuilder
    mutating func visitText(_ text: Markdown.Text) -> AnyHTML {
        HTMLText(text.string)
    }
    
    @HTMLBuilder
    mutating func visitThematicBreak(_ thematicBreak: Markdown.ThematicBreak) -> AnyHTML {
        div {
            Divider()
        }
        .margin(top: 1.rem, bottom: 2.rem)
    }
    
    @HTMLBuilder
    mutating func visitUnorderedList(_ unorderedList: Markdown.UnorderedList) -> AnyHTML {
        ul {
            for child in unorderedList.children {
                visit(child)
            }
        }
        .flexContainer(direction: .column, rowGap: .length(0.5.rem))
        .margin(vertical: 0)
    }
}

extension Table.ColumnAlignment {
    fileprivate var attributeValue: String {
        switch self {
        case .center: "center"
        case .left: "left"
        case .right: "right"
        }
    }
}

extension HTMLBuilder {
    @_disfavoredOverload
    fileprivate static func buildExpression(_ expression: any HTML) -> AnyHTML {
        AnyHTML(expression)
    }
    
    @_disfavoredOverload
    fileprivate static func buildFinalResult(_ component: some HTML) -> AnyHTML {
        AnyHTML(component)
    }
}


private struct BlockQuoteStyle {
    var backgroundColor: HTMLColor
    var borderColor: HTMLColor
    
    init(blockName: String) {
        switch blockName {
        case "Warning", "Correction":
            self.backgroundColor = HTMLColor(light: .hex("FDF2F4"), dark: .hex("2E0402"))
            self.borderColor = HTMLColor(light: .hex("D02C1E"), dark: .hex("EB4642"))
        case "Important":
            self.backgroundColor = HTMLColor(light: .hex("FEFBF3"), dark: .hex("291F04"))
            self.borderColor = HTMLColor(light: .hex("966922"), dark: .hex("F4B842"))
        case "Announcement", "Tip":
            self.backgroundColor = HTMLColor(light: .hex("FBFFFF"), dark: .hex("0F2C2B"))
            self.borderColor = HTMLColor(light: .hex("4B767C"), dark: .hex("9FFCE5"))
        case "Preamble":
            self.backgroundColor = HTMLColor(light: .hex("FBF8FF"), dark: .hex("1e1925"))
            self.borderColor = HTMLColor(light: .hex("8D51F6"), dark: .hex("8D51F6"))
        default:
            self.backgroundColor = HTMLColor(light: .hex("f5f5f5"), dark: .hex("323232"))
            self.borderColor = HTMLColor(light: .hex("696969"), dark: .hex("9a9a9a"))
        }
    }
}

private func value(forArgument argument: String, block: BlockDirective) -> String? {
    block.argumentText.segments
        .compactMap {
            let text = $0.trimmedText.drop(while: { $0 == " " })
            return text.hasPrefix("\(argument): \"")
            ? text.dropFirst("\(argument): \"".count).prefix(while: { $0 != "\"" })
            : nil
        }
        .first
        .map(String.init)
}

extension DiagnosticLevel {
    fileprivate init?(aside: Aside) {
        switch aside.kind.rawValue {
        case "Error": self = .error
        case "Expected Failure": self = .knownIssue
        case "Failed": self = .issue
        case "Runtime Warning": self = .runtimeWarning
        case "Warning": self = .warning
        default: return nil
        }
    }
}

public struct Timestamp: HTML {
    public var hour: Int
    public var minute: Int
    public var second: Int
    public var speaker: String?
    
    public init?(format: String, speaker: String?) {
        let components = format.split(separator: ":")
        guard let second = components.last.flatMap({ Int($0) }) else { return nil }
        self.hour = components.dropLast(2).last.flatMap { Int($0) } ?? 0
        self.minute = components.dropLast().last.flatMap { Int($0) } ?? 0
        self.second = second
        self.speaker = speaker
    }
    
    public var duration: Int {
        hour * 60 * 60 + minute * 60 + second
    }
    
    public var id: String {
        "t\(duration)"
    }
    
    public var anchor: String {
        "#\(id)"
    }
    
    public func formatted() -> String {
        var formatted = hour > 0 ? "\(hour):" : ""
        formatted.append("\(hour > 0 && minute < 10 ? "0" : "")\(minute):")
        formatted.append("\(second < 10 ? "0" : "")\(second)")
        return formatted
    }
    
    public var body: some HTML {
        div {
            if let speaker {
                strong {
                    HTMLText(speaker)
                }
                .color(.gray500)
                .font(.size(0.875.rem))
                .lineHeight(1, media: .desktop)
                .position(.relative, media: .desktop)
                .inlineStyle("text-transform", "uppercase")
                .top(0.5.rem, media: .desktop)
            }
            
            let duration = self.duration
            div {
                div {
                    Link(href: anchor) {
                        HTMLText(formatted())
                    }
                    .attribute("data-timestamp", "\(duration)")
                }
                .fontStyle(.body(.small))
                .linkStyle(.init(underline: nil))
                .dependency(\.color.text.link, .gray800.withDarkColor(.gray300))
                .id(id)
                .inlineStyle("font-variant-numeric", "tabular-nums")
                .lineHeight(3, media: .desktop)
                .margin(left: (-4).rem, media: .desktop)
                .position(.absolute, media: .desktop)
                .textAlign(.right, media: .desktop)
                .width(3.25.rem, media: .desktop)
            }
        }
        .flexContainer(direction: .columnReverse, rowGap: .length(0.5.rem), media: .mobile)
    }
}

private struct Slug: Hashable {
    var name: String
    var generation: Int
}

extension Set<Slug> {
    fileprivate func slug(for string: String) -> String {
        var slug = Slug(name: string.slug(), generation: 0)
        while contains(slug) {
            slug.generation += 1
        }
        return "\(slug.name)\(slug.generation > 0 ? "-\(slug.generation)" : "")"
    }
}

extension String {
    fileprivate func slug() -> String {
        split(whereSeparator: { !$0.isLetter && !$0.isNumber }).joined(separator: "-").lowercased()
    }
}
