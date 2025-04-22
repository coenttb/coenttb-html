import Foundation
import HTML

public struct Button<Tag: HTML, Label: HTML, Icon: HTML>: HTML {
    let tag: Tag
    let icon: Icon?
    let label: Label
    let background: HTMLColor
    let style: Button.Style
    
    public init(
        tag: Tag,
        background: HTMLColor = .buttonBackground,
        style: Button.Style = .default,
        @HTMLBuilder icon: () -> Icon,
        @HTMLBuilder label: () -> Label
    ) {
        self.tag = tag
        self.icon = icon()
        self.label = label()
        self.background = background
        self.style = style
    }
    
    //    public init(
    //        tag: Tag,
    //        background: HTMLColor = .buttonBackground,
    //        style: Button.Style = .default,
    //        @HTMLBuilder label: () -> Label
    //    ) where Icon == HTMLEmpty {
    //        self.tag = tag.rawValue
    //        self.icon = HTMLEmpty()
    //        self.label = label()
    //        self.background = background
    //        self.style = style
    //    }
    
    public var body: some HTML {
        HTMLGroup {
            if let icon = icon {
                CoenttbHTML.Label {
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
        .textDecoration(TextDecoration.none)
        .inlineStyle("transition", "background-color 0.3s")
        .inlineStyle("user-select", "none")
        .inlineStyle("-webkit-user-select", "none")
        .inlineStyle("-moz-user-select", "none")
        .inlineStyle("-ms-user-select", "none")
        .cursor(.pointer)
        
        var borderColor: HTMLColor? {
            switch self.style {
            case .primary, .secondary, .tertiary:
                self.background.darker(by: 0.15)
            case .round:
                nil
            default:
                nil
            }
        }
        
        var borderStyle: BorderStyle? {
            switch self.style {
            case .primary, .secondary, .tertiary:
                BorderStyle.none
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
                "rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0.12) 0px 1px 1px 0px, \(background.dark.lighter(by: 0.15)) 0px 0px 0px 1px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(0, 0, 0, 0) 0px 0px 0px 0px, rgba(255, 255, 255, 0.08) 0px 2px 5px 0px;"
            case .round:
                nil
            default:
                nil
            }
        }
        
        return tag
            .borderRadius(.uniform(style.cornerRadius))
            .borderStyle(borderStyle)
            .inlineStyle("border-width", "0px;")
            .inlineStyle("transition", "background-color 0.3s, box-shadow 0.3s")
            .appearance(Appearance.none)
            .inlineStyle("box-shadow", "0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06)")
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
        public let cornerRadius: LengthPercentage
        public let verticalPadding: LengthPercentage
        public let horizontalPadding: LengthPercentage
        
        public init(
            cornerRadius: LengthPercentage = .rem(0.5),
            verticalPadding: LengthPercentage = .rem(0.75),
            horizontalPadding: LengthPercentage = .rem(1)
        ) {
            self.cornerRadius = cornerRadius
            self.verticalPadding = verticalPadding
            self.horizontalPadding = horizontalPadding
        }
        
        public static var `default`: Self { primary }
        
        public static var primary:Self {
            Style(
                cornerRadius: .rem(0.25),
                verticalPadding: .rem(0.80),
                horizontalPadding: .rem(1.6)
            )
        }
        
        public static var secondary:Self {
            Style(
                cornerRadius: .rem(0.25),
                verticalPadding: .rem(0.6),
                horizontalPadding: .rem(0.9)
            )
        }
        
        public static var tertiary:Self {
            Style(
                cornerRadius: .rem(0.25),
                verticalPadding: .rem(0.2),
                horizontalPadding:   .rem(0.3)
            )
        }
        
        public static var round:Self {
            Style(
                cornerRadius: .percentage(100),
                verticalPadding: .rem(0.5),
                horizontalPadding: .rem(0.5)
            )
        }
    }
}
