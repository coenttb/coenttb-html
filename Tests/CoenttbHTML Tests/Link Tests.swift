//
//  Link Tests.swift
//  coenttb-html
//
//  Created by Claude on 22/04/2025.
//

import Foundation

import CoenttbHTML
import Dependencies
import PointFreeHTMLTestSupport
import Testing

@Suite(
    "Link Tests",
    .snapshots(record: .missing)
)
struct LinkTests {

    @Test("Link rendering with string label")
    func testLinkRenderingWithStringLabel() {
        assertInlineSnapshot(
            of: HTMLDocument { Link("Visit website", href: "https://example.com") },
            as: .html
        ) {
            """
            <!doctype html>
            <html>
              <head>
                <style>
            .text-decoration-Zf0gY:hover{text-decoration:underline}
            .text-decoration-Q5Er64:link{text-decoration:none}
            .text-decoration-Mif7n4:visited{text-decoration:none}
            .color-o1VU64:link{color:#007AFF}
            .color-XpGrd3:visited{color:#007AFF}
            .color-JKZuT{color:#007AFF}
            @media (prefers-color-scheme: dark){
              .color-DTYT92:link{color:#0A84FF}
              .color-3k8XR1:visited{color:#0A84FF}
              .color-owfGf1{color:#0A84FF}
            }

                </style>
              </head>
              <body><a class="text-decoration-Zf0gY text-decoration-Q5Er64 text-decoration-Mif7n4 color-o1VU64 color-DTYT92 color-XpGrd3 color-3k8XR1 color-JKZuT color-owfGf1" href="https://example.com">Visit website</a>
              </body>
            </html>
            """
        }
    }

    @Test("Link rendering with HTML content")
    func testLinkRenderingWithHTMLContent() {
        assertInlineSnapshot(
            of: HTMLDocument {
                Link(href: "https://example.com") {
                    span { "Complex " }
                    strong { "Content" }
                }
            },
            as: .html
        ) {
            """
            <!doctype html>
            <html>
              <head>
                <style>
            .text-decoration-Zf0gY:hover{text-decoration:underline}
            .text-decoration-Q5Er64:link{text-decoration:none}
            .text-decoration-Mif7n4:visited{text-decoration:none}
            .color-o1VU64:link{color:#007AFF}
            .color-XpGrd3:visited{color:#007AFF}
            .color-JKZuT{color:#007AFF}
            @media (prefers-color-scheme: dark){
              .color-DTYT92:link{color:#0A84FF}
              .color-3k8XR1:visited{color:#0A84FF}
              .color-owfGf1{color:#0A84FF}
            }

                </style>
              </head>
              <body><a class="text-decoration-Zf0gY text-decoration-Q5Er64 text-decoration-Mif7n4 color-o1VU64 color-DTYT92 color-XpGrd3 color-3k8XR1 color-JKZuT color-owfGf1" href="https://example.com"><span>Complex </span><strong>Content</strong></a>
              </body>
            </html>
            """
        }
    }

    @Test("Link with underline enabled")
    func testLinkWithUnderlineEnabled() {
        withDependencies {
            $0.linkStyle.underline = true
        } operation: {
            assertInlineSnapshot(
                of: HTMLDocument { Link("Underlined link", href: "https://example.com") },
                as: .html
            ) {
                """
                <!doctype html>
                <html>
                  <head>
                    <style>
                .text-decoration-8r95N:hover{text-decoration:none}
                .text-decoration-tfb0F1:link{text-decoration:underline}
                .text-decoration-gUV393:visited{text-decoration:underline}
                .color-o1VU64:link{color:#007AFF}
                .color-XpGrd3:visited{color:#007AFF}
                .color-JKZuT{color:#007AFF}
                @media (prefers-color-scheme: dark){
                  .color-DTYT92:link{color:#0A84FF}
                  .color-3k8XR1:visited{color:#0A84FF}
                  .color-owfGf1{color:#0A84FF}
                }

                    </style>
                  </head>
                  <body><a class="text-decoration-8r95N text-decoration-tfb0F1 text-decoration-gUV393 color-o1VU64 color-DTYT92 color-XpGrd3 color-3k8XR1 color-JKZuT color-owfGf1" href="https://example.com">Underlined link</a>
                  </body>
                </html>
                """
            }
        }
    }

    @Test("Link with no href")
    func testLinkWithNoHref() {
        assertInlineSnapshot(
            of: HTMLDocument { Link("No link", href: nil) },
            as: .html
        ) {
            """
            <!doctype html>
            <html>
              <head>
                <style>
            .text-decoration-Zf0gY:hover{text-decoration:underline}
            .text-decoration-Q5Er64:link{text-decoration:none}
            .text-decoration-Mif7n4:visited{text-decoration:none}
            .color-o1VU64:link{color:#007AFF}
            .color-XpGrd3:visited{color:#007AFF}
            .color-JKZuT{color:#007AFF}
            @media (prefers-color-scheme: dark){
              .color-DTYT92:link{color:#0A84FF}
              .color-3k8XR1:visited{color:#0A84FF}
              .color-owfGf1{color:#0A84FF}
            }

                </style>
              </head>
              <body><a class="text-decoration-Zf0gY text-decoration-Q5Er64 text-decoration-Mif7n4 color-o1VU64 color-DTYT92 color-XpGrd3 color-3k8XR1 color-JKZuT color-owfGf1">No link</a>
              </body>
            </html>
            """
        }
    }
}
