import Dependencies
import Foundation
import HTML

public struct Link<Label: HTML>: HTML {
    @Dependency(\.linkStyle) var linkStyle
    let label: Label
    let href: String?
    
    public init(href: String?, @HTMLBuilder label: () -> Label) {
        self.href = href
        self.label = label()
    }
    
    public init(_ title: String, href: String?) where Label == HTMLText {
        self.init(href: href) {
            HTMLText(title)
        }
    }
    
    public var body: some HTML {
        a { label }
            .attribute("href", href)
            .color(.text.link)
            .color(.text.link, pseudo: .visited)
            .color(.text.link, pseudo: .link)
            .inlineStyle(
                "text-decoration", linkStyle.underline == true ? "underline" : "none", pseudo: .visited
            )
            .inlineStyle(
                "text-decoration", linkStyle.underline == true ? "underline" : "none", pseudo: .link
            )
            .inlineStyle(
                "text-decoration", linkStyle.underline == false ? "none" : "underline", pseudo: .hover
            )
    }
}

extension HTML {
    public func linkColor(_ linkColor: HTMLColor?) -> some HTML {
        @Dependency(\.color.text.link) var color
        return self.dependency(\.color.text.link, linkColor ?? color)
    }
    public func linkUnderline(_ linkUnderline: Bool?) -> some HTML {
        self.dependency(\.linkStyle.underline, linkUnderline)
    }
    public func linkStyle(_ linkStyle: LinkStyle) -> some HTML {
        self.dependency(\.linkStyle, linkStyle)
    }
}


public struct LinkStyle: Sendable {
//    public var color: HTMLColor?
    public var underline: Bool?
    
    public init(
//        color: HTMLColor? = nil,
        underline: Bool? = nil
    ) {
//        self.color = color
        self.underline = underline
    }
}

private enum LinkStyleKey: DependencyKey {
    static let liveValue = LinkStyle()
    static let testValue = LinkStyle()
}

extension DependencyValues {
    public var linkStyle: LinkStyle {
        get { self[LinkStyleKey.self] }
        set { self[LinkStyleKey.self] = newValue }
    }
}
