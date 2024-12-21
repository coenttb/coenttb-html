import Foundation
import HTML

fileprivate typealias HTMLLabel = Label
public struct Button<Label: HTML, Icon: HTML>: HTML {
    let tagName: String
    let icon: Icon?
    let label: Label
    let background: HTMLColor
    let style: Button.Style

    public init(
        tag: HTMLTag = a,
        background: HTMLColor = .buttonBackground,
        style: Button.Style = .default,
        @HTMLBuilder icon: () -> Icon,
        @HTMLBuilder label: () -> Label
    ) {
        self.tagName = tag.rawValue
        self.icon = icon()
        self.label = label()
        self.background = background
        self.style = style
    }
    
    public init(
        tag: HTMLTag = a,
        background: HTMLColor = .buttonBackground,
        style: Button.Style = .default,
        @HTMLBuilder label: () -> Label
    ) where Icon == HTMLEmpty {
        self.tagName = tag.rawValue
        self.icon = HTMLEmpty()
        self.label = label()
        self.background = background
        self.style = style
    }

    public var body: some HTML {
        let tag: some HTML = tag(tagName) {
            if let icon = icon {
                HTMLLabel {
                    icon
                } title: {
                    label
                }

            } else {
                label
            }
            
        }
        .padding(
            vertical: style.verticalPadding,
            horizontal: style.horizontalPadding
        )
        
        .display(.flex)
        .alignItems(.center)
        .textDecoration(.none)
        .transition("background-color 0.3s")
        .inlineStyle("transition", "all 0.15s ease")
        .inlineStyle("user-select", "none")
        .inlineStyle("-webkit-user-select", "none")
        .inlineStyle("-moz-user-select", "none")
        .inlineStyle("-ms-user-select", "none")
        .cursor(.pointer)
        
        var borderColor: String? {
            switch self.style {
            case .primary, .secondary, .tertiary:
                "\(self.background.darker(by: 0.15))"
            case .round:
                nil
            default:
                nil
            }
        }
        
        var borderStyle: String? {
            switch self.style {
            case .primary, .secondary, .tertiary:
                "none;"
            case .round:
                nil
            default:
                nil
            }
        }
        
        var backgroundColor: HTMLColor? {
            switch self.style {
            case .primary, .secondary, .tertiary:
                self.background
            case .round:
                nil
            default:
                nil
            }
        }
        
        var backgroundColorHover: HTMLColor? {
            switch self.style {
            case .primary, .secondary, .tertiary:
                self.background.darker(by: 0.2)
            case .round:
                HTMLColor.buttonBackground
            default:
                nil
            }
        }
        
        var boxShadow: String? {
            switch self.style {
            case .primary, .secondary, .tertiary:
                "rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0.12) 0px 1px 1px 0px, \(background.light.darker(by: 0.075)) 0px 0px 0px 1px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(60, 66, 87, 0.08) 0px 2px 5px 0px;"
            case .round:
                nil
            default:
                nil
            }
        }
        
        var boxShadowDark: String? {
            switch self.style {
            case .primary, .secondary, .tertiary:
                background.dark.map { dark in
                    "rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0.12) 0px 1px 1px 0px, \(dark.lighter(by: 0.15)) 0px 0px 0px 1px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(255, 255, 255, 0.08) 0px 2px 5px 0px;"
                }
                
                
            case .round:
                nil
            default:
                nil
            }
        }
        
        return tag
            .border(.radius(.all(style.cornerRadius)))
            .inlineStyle("border-color", borderColor)
            .inlineStyle("border-style", borderStyle)
            .inlineStyle("border-width", "0px;")
            .transition("background-color 0.3s, box-shadow 0.3s")
            .inlineStyle("appearance", "none")
//            .inlineStyle("box-shadow", "0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06)")
            .inlineStyle(
                "box-shadow",
                boxShadow
            )
            .inlineStyle(
                "box-shadow",
                boxShadowDark,
                media: .dark
            )
            .backgroundColor(backgroundColor)
            .backgroundColor(backgroundColorHover, pseudo: .hover)
    }
    

    public struct Style: Equatable {
        public let cornerRadius: CSS.Length
        public let verticalPadding: CSS.Length
        public let horizontalPadding: CSS.Length

        public init(
            cornerRadius: CSS.Length = 0.5.rem,
            verticalPadding: CSS.Length = 0.75.rem,
            horizontalPadding: CSS.Length = 1.rem
        ) {
            self.cornerRadius = cornerRadius
            self.verticalPadding = verticalPadding
            self.horizontalPadding = horizontalPadding
        }
        
        public static var `default`: Self { primary }

        public static var primary:Self {
            Style(
                cornerRadius: 0.25.rem,
                verticalPadding: 0.80.rem,
                horizontalPadding: 1.6.rem
            )
        }
        
        public static var secondary:Self {
            Style(
                cornerRadius: 0.25.rem,
                verticalPadding: 0.6.rem,
                horizontalPadding: 0.9.rem
            )
        }
        
        public static var tertiary:Self {
            Style(
                cornerRadius: 0.25.rem,
                verticalPadding: 0.2.rem,
                horizontalPadding:   0.3.rem
            )
        }
        
        public static var round:Self {
            Style(
                cornerRadius: 100.percent,
                verticalPadding: 0.5.rem,
                horizontalPadding: 0.5.rem
            )
        }
    }
}
