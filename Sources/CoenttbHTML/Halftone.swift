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
    let dotSize: CSS.Length
    let lineColor: HTMLColor
    let lineContrast: Int
    let photoBrightness: Int
    let photoContrast: Int
    let photoBlur: CSS.Length
    let blendMode: CSS.MixBlendMode
    let rotationAngle: Int
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
                    .width(100.percent)
                    .height(100.percent)
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
            .inlineStyle("content", "''", pseudo: .before)
            .position(.absolute, top: (-50).percent, right: (-50).percent, bottom: (-50).percent, left: (-50).percent, pseudo: .before)
            .inlineStyle("background", "radial-gradient(circle at center, \(lineColor.light.description), \(lineColor.dark?.description ?? CSS.Color.white.description))", pseudo: .before)
            .inlineStyle("background-size", "\(dotSize.description) \(dotSize.description)", pseudo: .before)
            .transform("rotate(\(rotationAngle)deg)", pseudo: .before)
            
        }
    }
}

extension HTML {
    public func halftone(
        grayscale: String = "0",
        dotSize: CSS.Length = .em(0.3),
        lineColor: HTMLColor = .offBlack.withDarkColor(.offWhite),
        lineContrast: Int = 2000,
        photoBrightness: Int = 100,
        photoContrast: Int = 100,
        photoBlur: CSS.Length = .px(1),
        blendMode: CSS.MixBlendMode = .hardLight,
        rotationAngle: Int = 20
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
            rotationAngle: rotationAngle,
            image: self
        )
    }
}
