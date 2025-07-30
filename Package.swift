// swift-tools-version:6.0
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
    static var markdownBuilder: Self { .product(name: "MarkdownBuilder", package: "swift-builders") }
    static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
    static var html: Self { .product(name: "HTML", package: "swift-html") }
    static var translating: Self { .product(name: "Translating", package: "swift-translating") }
    static var pointfreeHTMLTestSupport: Self { .product(name: "PointFreeHTMLTestSupport", package: "pointfree-html") }
    static var pointFreeHTMLToPDF: Self { .product(name: "PointFreeHTMLToPDF", package: "pointfree-html-to-pdf") }
    static var orderedCollections: Self { .product(name: "OrderedCollections", package: "swift-collections") }
    static var swiftMarkdown: Self { .product(name: "Markdown", package: "swift-markdown") }
}

extension String {
    var tests: Self { "\(self) Tests" }
}

let package = Package(
    name: "coenttb-html",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10)
    ],
    products: [
        .library(name: .coenttbHtml, targets: [.coenttbHtml]),
        .library(name: .coenttbMarkdown, targets: [.coenttbMarkdown]),
        .library(name: .coenttbEmail, targets: [.coenttbEmail]),
        .library(name: .coenttbHtmlToPdf, targets: [.coenttbHtmlToPdf])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", from: "1.1.2"),
        .package(url: "https://github.com/coenttb/pointfree-html.git", from: "2.0.0"),
        .package(url: "https://github.com/coenttb/pointfree-html-to-pdf.git", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-builders.git", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-html.git", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-html-css-pointfree.git", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-translating.git", from: "0.0.1"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.9.2"),
        .package(url: "https://github.com/swiftlang/swift-markdown.git", from: "0.4.0")
    ],
    targets: [
        .target(
            name: .coenttbHtml,
            dependencies: [
                .dependencies,
                .orderedCollections,
                .html,
                .translating
            ]
        ),
        .testTarget(
            name: .coenttbHtml.tests,
            dependencies: [
                .coenttbHtml,
                .pointfreeHTMLTestSupport
            ]
        ),
        .target(
            name: .coenttbMarkdown,
            dependencies: [
                .dependencies,
                .orderedCollections,
                .coenttbHtml,
                .swiftMarkdown,
                .markdownBuilder
            ]
        ),
        .testTarget(
            name: .coenttbMarkdown.tests,
            dependencies: [
                .coenttbMarkdown,
                .pointfreeHTMLTestSupport
            ]
        ),
        .target(
            name: .coenttbEmail,
            dependencies: [
                .dependencies,
                .orderedCollections,
                .swiftMarkdown,
                .translating,
                .coenttbHtml,
                .coenttbMarkdown
            ]
        ),
        .testTarget(
            name: .coenttbEmail.tests,
            dependencies: [
                .coenttbEmail,
                .pointfreeHTMLTestSupport
            ]
        ),
        .target(
            name: .coenttbHtmlToPdf,
            dependencies: [
                .pointFreeHTMLToPDF
            ]
        ),
        .testTarget(
            name: .coenttbHtmlToPdf.tests,
            dependencies: [
                .coenttbHtmlToPdf,
                .pointfreeHTMLTestSupport
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)
