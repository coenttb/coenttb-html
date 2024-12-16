import HTML
public struct Card<Content: HTML, Header: HTML, Footer: HTML>: HTML {
    let content: Content
    let header: Header
    let footer: Footer
    
    public init(
        @HTMLBuilder content: () -> Content,
        @HTMLBuilder header: () -> Header = { HTMLEmpty() },
        @HTMLBuilder footer: () -> Footer = { HTMLEmpty() }
    ) {
        self.content = content()
        self.header = header()
        self.footer = footer()
    }
        
    public var body: some HTML {
        VStack {
            header
                .border(.bottom(width: 1.px, style: .solid, color: .init(light: .hex("e8e8e8"), dark: .hex("3d3d3d"))))
            
            VStack {
                VStack(spacing: 0.rem) { content }
                    .grow()
                
                footer
            }
            .grow()
            .padding(top: 0.5.rem, horizontal: 1.5.rem, bottom: 1.5.rem)
        }
//        .border(width: 1.px, style: .solid, color: .init(rawValue: "#353535"), media: .dark)
        .inlineStyle("border", "1px #353535 solid", media: .dark)
        .inlineStyle("box-shadow", "0 4px 12px rgba(0, 0, 0, 0.1)")
        .border(.radius(7.5.px))
        .overflow(.hidden)
    }
}

