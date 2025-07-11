//
//  File.swift
//  coenttb-html
//
//  Created by Coen ten Thije Boonkkamp on 06/12/2024.
//

import HtmlToPdf
import HTML
import Foundation

extension HTML {
    public func print(
        to: URL,
        encoding: String.Encoding = .utf8,
        configuration: PDFConfiguration = .a4,
        createDirectories: Bool = true
    ) async throws {
        try await String(self, encoding: encoding)
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
        encoding: String.Encoding = .utf8,
        configuration: PDFConfiguration = .a4,
        createDirectories: Bool = true
    ) async throws {
        try await String(self, encoding: encoding)
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
        encoding: String.Encoding = .utf8,
        configuration: PDFConfiguration = .a4,
        createDirectories: Bool = true
    ) async throws {
        try await String(self, encoding: encoding)
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
        encoding: String.Encoding = .utf8,
        configuration: PDFConfiguration = .a4,
        createDirectories: Bool = true
    ) async throws {
        try await String(self, encoding: encoding)
            .print(
                title: title,
                to: to,
                configuration: configuration,
                createDirectories: createDirectories
            )
    }
}

