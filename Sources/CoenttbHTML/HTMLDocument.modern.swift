//
//  File.swift
//
//
//  Created by Coen ten Thije Boonkkamp on 28/07/2024.
//

import Foundation
import HTML

extension HTMLDocument where Head == _ModernHead {
    public static func modern(
        body: Body
    ) -> HTMLDocument {
        HTMLDocument.modern {
            body
        }
    }
    public static func modern(
        @HTMLBuilder body: () -> Body
    ) -> HTMLDocument {
        HTMLDocument(
            body: body,
            head: _ModernHead.init
        )
    }
}

public struct _ModernHead: HTML {
    public var body: some HTML {
        HTMLGroup {
            BaseStyles()
            Style {"""

            body, html {
                background: #fff;
            }

            @media (prefers-color-scheme: dark) {
                body, html {
                    background: #121212;
                }
            }

            """}
        }
    }
}
