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
                .border(
                    .bottom,
                    width: .px(1),
                    style: .solid,
                    color: .init(light: .hex("e8e8e8"), dark: .hex("3d3d3d"))
                )

            VStack {
                VStack(spacing: 0.rem) { content }
                    .flexGrow()

                footer
            }
            .flexGrow()
            .padding(top: .rem(0.5), horizontal: .rem(1.5), bottom: .rem(1.5))
        }
        .display(.flex)
        .flexDirection(.column)
        .height(.percent(100))
        .borderBottom(
            .init(
                width: .px(1),
                style: .solid,
                color: .hex("#353535")
            ),
            media: .prefersColorScheme(.dark)
        )
        .inlineStyle("border", "1px #353535 solid", media: .dark)
        .inlineStyle("box-shadow", "0 4px 12px rgba(0, 0, 0, 0.1)")
        .borderRadius(.length(7.5.px))
        .overflow(.hidden)
    }
}
