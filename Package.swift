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
    static var coenttbHtml: Self { .target(name: .coenttbHtml) }
}

extension Target.Dependency {
    static var markdownBuilder: Self { .product(name: "MarkdownBuilder", package: "swift-builders") }
    static var builders: Self { .product(name: "Builders", package: "swift-builders") }
    static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
    static var html: Self { .product(name: "HTML", package: "swift-html") }
    static var htmlTheme: Self { .product(name: "HTMLTheme", package: "swift-html-theme") }
    static var htmlMarkdown: Self { .product(name: "HTMLMarkdown", package: "swift-html-markdown") }
    static var htmlEmail: Self { .product(name: "HTMLEmail", package: "swift-html-email") }
    static var htmlTranslating: Self { .product(name: "PointFreeHTMLTranslating", package: "pointfree-html-translating") }
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
        .library(name: .coenttbHtml, targets: [.coenttbHtml])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", from: "1.1.2"),
        .package(url: "https://github.com/coenttb/pointfree-html.git", from: "2.0.0"),
        .package(url: "https://github.com/coenttb/pointfree-html-translating.git", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-builders.git", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-html.git", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-html-theme", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-translating.git", from: "0.0.1"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.9.2"),
    ],
    targets: [
        .target(
            name: .coenttbHtml,
            dependencies: [
                .dependencies,
                .orderedCollections,
                .html,
                .htmlTheme,
                .htmlTranslating,
                .builders
            ]
        ),
        .testTarget(
            name: .coenttbHtml.tests,
            dependencies: [
                .coenttbHtml,
                .pointfreeHTMLTestSupport
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
