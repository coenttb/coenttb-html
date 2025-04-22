//
//  File.swift
//  coenttb-html
//
//  Created by Coen ten Thije Boonkkamp on 17/04/2025.
//

import Foundation
import HTML

extension HTML {
    @discardableResult
    @HTMLBuilder
    public func padding(
        top: LengthPercentage,
        horizontal: LengthPercentage,
        bottom: LengthPercentage,
        media mediaQuery: MediaQuery? = nil,
        pre: String? = nil,
        pseudo: Pseudo? = nil
    ) -> some HTML {
        fatalError()
    }
}
