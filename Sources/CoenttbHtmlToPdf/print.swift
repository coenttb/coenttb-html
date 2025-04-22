//
//  File.swift
//  coenttb-html
//
//  Created by Coen ten Thije Boonkkamp on 06/12/2024.
//

import HtmlToPdf
import CoenttbHTML
import Foundation

extension HTML {
    public func print(
        to: URL,
        wrapInHtmlDocument: ((Self) -> any HTMLDocumentProtocol)? = { html in HTMLDocument { html } },
        configuration: PDFConfiguration = .a4,
        createDirectories: Bool = true
    ) async throws {
        
        let `self`: any HTML = wrapInHtmlDocument.map { $0(self) } ?? self
        
        try await String(decoding: `self`.render(), as: UTF8.self)
            .print(
                to: to,
                configuration: configuration,
                createDirectories: createDirectories
            )
    }
}

extension HTML {
    public func print(
        title: String,
        to: URL,
        wrapInHtmlDocument: ((Self) -> any HTMLDocumentProtocol)? = { html in HTMLDocument { html } },
        configuration: PDFConfiguration = .a4,
        createDirectories: Bool = true
    ) async throws {
        let `self`: any HTML = wrapInHtmlDocument.map { $0(self) } ?? self
        
        try await String(decoding: `self`.render(), as: UTF8.self)
            .print(
                title: title,
                to: to,
                configuration: configuration,
                createDirectories: createDirectories
            )
    }
}

extension HTMLDocumentProtocol {
    public func print(
        to: URL,
        configuration: PDFConfiguration = .a4,
        createDirectories: Bool = true
    ) async throws {
        try await String(decoding: self.render(), as: UTF8.self)
            .print(
                to: to,
                configuration: configuration,
                createDirectories: createDirectories
            )
    }
}

extension HTMLDocumentProtocol {
    public func print(
        title: String,
        to: URL,
        configuration: PDFConfiguration = .a4,
        createDirectories: Bool = true
    ) async throws {
        
        let string = String(decoding: `self`.render(), as: UTF8.self)
        
        try await string
            .print(
                title: title,
                to: to,
                configuration: configuration,
                createDirectories: createDirectories
            )
    }
}

