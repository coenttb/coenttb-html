//
//  File.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 08/08/2024.
//

import Foundation
import HTML
import HTML_Markdown
import Testing

@Test
func markdown() {

}

func createMarkdown(@MarkdownBuilder _ content: () -> String) -> String {
    content()
}
