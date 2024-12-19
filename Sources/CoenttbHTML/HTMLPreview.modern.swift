//
//  File.swift
//
//
//  Created by Coen ten Thije Boonkkamp on 28/07/2024.
//

import CSS
import HTML
import Foundation

extension HTMLPreview where Head == HTMLGroup<_HTMLTuple<BaseStyles, HTMLElement<HTMLText>>> {
    public static func modern(
        body: Body
    ) -> HTMLPreview {
        HTMLPreview.modern {
            body
        }
    }
    public static func modern(
        @HTMLBuilder body: () -> Body
    ) -> HTMLPreview {
        HTMLPreview(
            body: body,
            head: {
                HTMLGroup {
                    BaseStyles()
                    style {"""
                    
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
        )
    }
}
