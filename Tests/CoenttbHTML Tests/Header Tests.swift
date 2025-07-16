//
//  File.swift
//  coenttb-html
//
//  Created by Coen ten Thije Boonkkamp on 18/09/2024.
//

import Foundation

import CoenttbHTML
import HTMLTestSupport
import Testing

@Suite("Header Tests")
struct HeaderTests {

    @Test("Header rendering")
    func testHeaderRendering() {
        assertInlineSnapshot(
            of: HTMLDocument { Header(5) { "Hello" } },
            as: .html
        ) {
            """
            <!doctype html>
            <html lang="en">
              <head>
                <style>
            .line-height-EHclK1{line-height:1.15}
            .font-weight-SywJI1{font-weight:700}
            .font-size-dnNPN1{font-size:1rem}
            .margin-bottom-yQEjs3:not(:last-child){margin-bottom:0.5rem}
            .margin-top-ukUO62:not(:first-child){margin-top:0.5rem}
            .margin-QlFKs1{margin:0px}

                </style>
              </head>
              <body>
            <h5 class="line-height-EHclK1 font-weight-SywJI1 font-size-dnNPN1 margin-bottom-yQEjs3 margin-top-ukUO62 margin-QlFKs1">Hello
            </h5>
              </body>
            </html>
            """
        }
    }
}
