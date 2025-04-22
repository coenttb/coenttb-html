import Foundation
import HTML

public struct Header<Content: HTML>: HTML {
    let size: Int
    @HTMLBuilder let content: Content
    public init(_ size: Int = 3, @HTMLBuilder content: () -> Content) {
        self.size = size
        self.content = content()
    }
    
    public var body: some HTML {
        tag("h\(size)") { content }
        .margin(0)
        .margin(.top(marginTop), pseudo: .not(.firstChild))
        .margin(.bottom(marginBottom), pseudo: .not(.lastChild))
        .fontSize(fontSize)
        .fontWeight(700)
        .lineHeight(lineHeight)
    }
    
    var fontSize: CSSPropertyTypes.FontSize {
        switch size {
        case 1: .rem(4)
        case 2: .rem(3)
        case 3: .rem(2)
        case 4: .rem(1.5)
        case 5: .rem(1)
        default: .rem(0.875)
        }
    }
    var lineHeight: LineHeight {
        switch size {
        case 1: 1.2
        case 2: 1.2
        case 3: 1.2
        case 4: 1.2
        case 5: 1.15
        default: 1.15
        }
    }
    var marginBottom: LengthPercentage {
        switch size {
        case 1: .rem(1)
        case 2: .rem(0.75)
        case 3: .rem(0.5)
        case 4: .rem(0.5)
        case 5: .rem(0.5)
        default: .rem(0.3)
        }
    }
    var marginTop: LengthPercentage {
        switch size {
        case 1: .rem(2)
        case 2: .rem(1.75)
        case 3: .rem(1.5)
        case 4: .rem(1.5)
        case 5: .rem(0.5)
        default: .rem(0.5)
        }
    }
}
