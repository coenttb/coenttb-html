//
//  File.swift
//  tenthijeboonkkamp-nl-server
//
//  Created by Coen ten Thije Boonkkamp on 16/08/2024.
//

import Foundation
import HTML
import Languages
//
//extension String: @retroactive HTML {
//    public var body: some HTML {
//         HTMLText(self.description)
//    }
//}

extension TranslatedString: @retroactive HTML {
    public var body: some HTML {
        HTMLText("\(self)")
    }
}

extension HTMLText {
    public init(_ translatedString: TranslatedString) {
        self = .init("\(translatedString)")
    }
}
