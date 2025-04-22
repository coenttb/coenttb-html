//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 01/09/2024.
//

import Foundation
import HTML
import Dependencies

public struct Halftone<Image: HTML>: HTML {
    let grayscale: String
    let dotSize: LengthPercentage
    let lineColor: HTMLColor
    let lineContrast: Int
    let photoBrightness: Int
    let photoContrast: Int
    let photoBlur: CSSPropertyTypes.Length
    let blendMode: CSSPropertyTypes.MixBlendMode
    let rotation: Angle
    let image: Image

    @Dependency(\.objectStyle.position) var objectPosition

    public var body: some HTML {
        div {
            div {
                image
                    .objectPosition(objectPosition)
                    .position(.absolute)
                    .top(0)
                    .left(0)
                    .width(.percentage(100))
                    .height(.percentage(100))
                    .objectFit(.cover)
                    .mixBlendMode(blendMode)
                    .inlineStyle("filter", """
                        grayscale(\(grayscale))
                        brightness(\(photoBrightness)%)
                        contrast(\(photoContrast)%)
                        blur(\(photoBlur.description))
                    """)
            }
            .position(.absolute, top: 0, right: 0, bottom: 0, left: 0)
            .inlineStyle("filter", "contrast(\(lineContrast)%)")
            .overflow(.hidden)
            .content(.text(""), pseudo: .before)
            .content(.text(""))
            .position(
                .absolute,
                top: .percent(-50),
                right: .percent(-50),
                bottom: .percent(-50),
                left: .percent(-50),
                pseudo: .before
            )
            .inlineStyle("background", "radial-gradient(circle at center, \(lineColor.light.description), \(lineColor.dark))", pseudo: .before)
            .backgroundSize(.size(dotSize, dotSize))
            .transform(.rotate(rotation), pseudo: .before)
            
        }
    }
}





extension HTML {
    @discardableResult
    public func position(
        _ value: CSSPropertyTypes.Position?,
        top: LengthPercentage?,
        right: LengthPercentage?,
        bottom: LengthPercentage?,
        left: LengthPercentage?,
        media mediaQuery: MediaQuery? = nil,
        pre: String? = nil,
        pseudo: Pseudo? = nil
    ) -> HTMLInlineStyle<Self> {
        inlineStyle("position", value?.description, media: mediaQuery, pre: pre, pseudo: pseudo)
            .inlineStyle("top", top?.description, media: mediaQuery, pre: pre, pseudo: pseudo)
            .inlineStyle("left", left?.description, media: mediaQuery, pre: pre, pseudo: pseudo)
            .inlineStyle("right", right?.description, media: mediaQuery, pre: pre, pseudo: pseudo)
            .inlineStyle("bottom", bottom?.description, media: mediaQuery, pre: pre, pseudo: pseudo)
    }
}

extension HTML {
    public func halftone(
        grayscale: String = "0",
        dotSize: LengthPercentage = .em(0.3),
        lineColor: HTMLColor,
        lineContrast: Int = 2000,
        photoBrightness: Int = 100,
        photoContrast: Int = 100,
        photoBlur: CSSPropertyTypes.Length = .px(1),
        blendMode: CSSPropertyTypes.MixBlendMode = .hardLight,
        rotation: Angle = 20
    ) -> some HTML {
        Halftone(
            grayscale: grayscale,
            dotSize: dotSize,
            lineColor: lineColor,
            lineContrast: lineContrast,
            photoBrightness: photoBrightness,
            photoContrast: photoContrast,
            photoBlur: photoBlur,
            blendMode: blendMode,
            rotation: rotation,
            image: self
        )
    }
}
