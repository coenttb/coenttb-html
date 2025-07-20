// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension String {
    static let coenttbMarkdown: Self = "CoenttbMarkdown"
    static let coenttbHtml: Self = "CoenttbHTML"
    static let coenttbEmail: Self = "CoenttbEmail"
    static let coenttbHtmlToPdf: Self = "CoenttbHtmlToPdf"
}

extension Target.Dependency {
    static var coenttbMarkdown: Self { .target(name: .coenttbMarkdown) }
    static var coenttbHtml: Self { .target(name: .coenttbHtml) }
    static var coenttbEmail: Self { .target(name: .coenttbEmail) }
    static var coenttbHtmlToPdf: Self { .target(name: .coenttbHtmlToPdf) }
}

extension Target.Dependency {
    static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
    static var html: Self { .product(name: "HTML", package: "swift-html") }
    static var language: Self { .product(name: "Languages", package: "swift-language") }
    static var pointfreeHTMLTestSupport: Self { .product(name: "PointFreeHTMLTestSupport", package: "pointfree-html") }
    static var pointFreeHTMLToPDF: Self { .product(name: "PointFreeHTMLToPDF", package: "pointfree-html-to-pdf") }
    static var orderedCollections: Self { .product(name: "OrderedCollections", package: "swift-collections") }
    static var swiftMarkdown: Self { .product(name: "Markdown", package: "swift-markdown") }
}

extension [Package.Dependency] {
    static var `default`: Self {
        [
            .package(url: "https://github.com/apple/swift-collections.git", from: "1.1.2"),
            .package(url: "https://github.com/coenttb/pointfree-html.git", branch: "main"),
            .package(url: "https://github.com/coenttb/pointfree-html-to-pdf.git", branch: "main"),
            .package(url: "https://github.com/coenttb/swift-html.git", branch: "main"),
            .package(url: "https://github.com/coenttb/swift-html-css-pointfree.git", branch: "main"),
            .package(url: "https://github.com/coenttb/swift-language.git", branch: "main"),
            .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.3.5"),
            .package(url: "https://github.com/swiftlang/swift-markdown.git", from: "0.4.0"),
        ]
    }
}

struct CustomTarget {
    let name: String
    var library: Bool = true
    var dependencies: [Target.Dependency] = []
}

extension Package {
    static func html(
        targets: [CustomTarget]
    ) -> Package {
        return Package(
            name: "coenttb-html",
            platforms: [
                .iOS(.v17),
                .macOS(.v14),
                .tvOS(.v17),
                .watchOS(.v10),
              ],
            products: [
                [
                    .library(name: .coenttbEmail, targets: [.coenttbEmail]),
                    .library(name: .coenttbHtml, targets: [.coenttbHtml]),
                    .library(name: .coenttbMarkdown, targets: [.coenttbMarkdown]),
                    .library(name: .coenttbHtmlToPdf, targets: [.coenttbHtmlToPdf]),
                ]
            ].flatMap { $0
            },
            dependencies: .default,
            targets: [
                targets.map { target in
                    Target.target(
                        name: "\(target.name)",
                        dependencies: [] + target.dependencies
                    )
                },
                targets.map { target in
                    Target.testTarget(
                        name: "\(target.name) Tests",
                        dependencies: [.init(stringLiteral: target.name)] + [.pointfreeHTMLTestSupport]
                    )
                }
            ].flatMap { $0 },
            swiftLanguageModes: [.v5]
        )
    }
}

let package = Package.html(
    targets: [
        .init(
            name: .coenttbMarkdown,
            library: true,
            dependencies: [
                .dependencies,
                .orderedCollections,
                .coenttbHtml,
                .swiftMarkdown,
            ]
        ),
        .init(
            name: .coenttbHtml,
            library: true,
            dependencies: [
                .dependencies,
                .orderedCollections,
                .html,
                .language
            ]
        ),
        .init(
            name: .coenttbEmail,
            library: true,
            dependencies: [
                .dependencies,
                .orderedCollections,
                .swiftMarkdown,
                .language,
                .coenttbHtml,
                .coenttbMarkdown,
            ]
        ),
        .init(
            name: .coenttbHtmlToPdf,
            library: true,
            dependencies: [
                .pointFreeHTMLToPDF
            ]
        ),
    ]
)
