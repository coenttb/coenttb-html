//
//  File.swift
//  coenttb-html
//
//  Created by Coen ten Thije Boonkkamp on 12/03/2025.
//

import Dependencies
import Foundation
import HTML

extension HTMLColor {
    public struct Defaults: Sendable {
        public var gray: HTMLColor
        public var blue: HTMLColor
        public var green: HTMLColor
        public var purple: HTMLColor
        public var red: HTMLColor
        public var yellow: HTMLColor
        public var orange: HTMLColor
        public var teal: HTMLColor
        public var cyan: HTMLColor
        public var pink: HTMLColor
        public var brown: HTMLColor
        public var black: HTMLColor
        public var offBlack: HTMLColor
        public var white: HTMLColor
        public var offWhite: HTMLColor
        public var text: HTMLColor.Defaults.Text
        public var background: HTMLColor.Defaults.Background
        public var branding: HTMLColor.Defaults.Branding
    }
}

extension HTMLColor.Defaults {
    public struct Text: Sendable {
        public var primary: HTMLColor
        public var secondary: HTMLColor
        public var tertiary: HTMLColor

        public var link: HTMLColor
        public var button: HTMLColor
        
        public var error: HTMLColor
        public var success: HTMLColor
        public var warning: HTMLColor

        public var disabled: HTMLColor

        public init(
            primary: HTMLColor = .init(light: .hex("000000"), dark: .hex("FFFFFF")),
            secondary: HTMLColor = .init(light: .hex("3C3C43").opacity(0.6), dark: .hex("EBEBF5").opacity(0.6)),
            tertiary: HTMLColor = .init(light: .hex("3C3C43").opacity(0.3), dark: .hex("EBEBF5").opacity(0.3)),
            link: HTMLColor = .init(light: .hex("007AFF"), dark: .hex("0A84FF")),
            button: HTMLColor = .text.primary,
            error: HTMLColor = .init(light: .hex("FF3B30"), dark: .hex("FF453A")),
            success: HTMLColor = .init(light: .hex("34C759"), dark: .hex("30D158")),
            warning: HTMLColor = .init(light: .hex("FF9500"), dark: .hex("FF9F0A")),
            inverted: HTMLColor = .init(light: .hex("FFFFFF"), dark: .hex("000000")),
            disabled: HTMLColor = .init(light: .hex("3C3C43").opacity(0.2), dark: .hex("EBEBF5").opacity(0.2))
        ) {
            self.primary = primary
            self.secondary = secondary
            self.tertiary = tertiary
            self.link = link
            self.button = button
            self.error = error
            self.success = success
            self.warning = warning
            self.disabled = disabled
        }
    }
}

extension HTMLColor.Defaults {
    public struct Background: Sendable {
        public var primary: HTMLColor
        public var secondary: HTMLColor
        public var tertiary: HTMLColor

        public var elevated: HTMLColor
        public var grouped: HTMLColor

        public var selected: HTMLColor
        public var highlighted: HTMLColor
        
        public var button: HTMLColor

        public init(
            primary: HTMLColor = .init(light: .hex("FFFFFF"), dark: .hex("121212")),
            secondary: HTMLColor = .init(light: .hex("F2F2F7"), dark: .hex("1C1C1E")),
            tertiary: HTMLColor = .init(light: .hex("EBEBEB"), dark: .hex("2C2C2E")),
            elevated: HTMLColor = .init(light: .hex("FFFFFF"), dark: .hex("1C1C1E")),
            grouped: HTMLColor = .init(light: .hex("F2F2F7"), dark: .hex("1C1C1E")),
            selected: HTMLColor = .init(light: .hex("DCDCDC"), dark: .hex("3A3A3C")),
            highlighted: HTMLColor = .init(light: .hex("E5E5EA").opacity(0.6), dark: .hex("3A3A3C").opacity(0.6)),
            button: HTMLColor = .init(light: .rgb(red: 245, green: 246, blue: 248), dark: .rgb(red: 25, green: 25, blue: 27))
        ) {
            self.primary = primary
            self.secondary = secondary
            self.tertiary = tertiary
            self.elevated = elevated
            self.grouped = grouped
            self.selected = selected
            self.highlighted = highlighted
            self.button = button
        }
    }
}

extension HTMLColor.Defaults {
    public struct Branding: Sendable {
        public var primary: HTMLColor
        public var secondary: HTMLColor
        public var accent: HTMLColor
        public var primarySubtle: HTMLColor
        public var secondarySubtle: HTMLColor

        public init(
            primary: HTMLColor = .init(light: .hex("007AFF"), dark: .hex("0A84FF")),
            secondary: HTMLColor = .init(light: .hex("5856D6"), dark: .hex("5E5CE6")),
            accent: HTMLColor = .init(light: .hex("FF9500"), dark: .hex("FF9F0A")),
            primarySubtle: HTMLColor = .init(light: .hex("007AFF").opacity(0.2), dark: .hex("0A84FF").opacity(0.2)),
            secondarySubtle: HTMLColor = .init(light: .hex("5856D6").opacity(0.2), dark: .hex("5E5CE6").opacity(0.2))
        ) {
            self.primary = primary
            self.secondary = secondary
            self.accent = accent
            self.primarySubtle = primarySubtle
            self.secondarySubtle = secondarySubtle
        }
    }
}

extension HTMLColor {
    public static var `default`: HTMLColor.Defaults {
        @Dependency(\.color) var color
        return color
    }
}

extension HTMLColor {
    public static var text: HTMLColor.Defaults.Text {
        @Dependency(\.color.text) var text
        return text
    }
}

extension HTMLColor {
    public static var background: HTMLColor.Defaults.Background {
        @Dependency(\.color.background) var background
        return background
    }
}

extension HTMLColor {
    public static var branding: HTMLColor.Defaults.Branding {
        @Dependency(\.color.branding) var branding
        return branding
    }
}

extension HTMLColor.Defaults: DependencyKey {
    public static let liveValue: Self = .init(
        gray: .gray500,
        blue: .blue500,
        green: .green500,
        purple: .purple500,
        red: .red500,
        yellow: .yellow500,
        orange: .orange500,
        teal: .teal500,
        cyan: .cyan500,
        pink: .pink500,
        brown: .brown500,
        black: .init(light: .hex("121212"), dark: .hex("121212")),
        offBlack: .init(light: .hex("171717"), dark: .hex("171717")),
        white: .init(light: .hex("fff"), dark: .hex("fff")),
        offWhite: .init(light: .hex("fafafa"), dark: .hex("fafafa")),
        text: .init(),
        background: .init(),
        branding: .init()
    )

    public static let testValue: Self = liveValue
}

extension DependencyValues {
    public var color: HTMLColor.Defaults {
        get { self[HTMLColor.Defaults.self] }
        set { self[HTMLColor.Defaults.self] = newValue }
    }
}

extension HTMLColor {
    public static var gray: Self {
        @Dependency(\.color.gray) var gray
        return gray
    }
    public static var black: Self {
        @Dependency(\.color.black) var black
        return black
    }
    public static var offBlack: Self {
        @Dependency(\.color.offBlack) var offBlack
        return offBlack
    }
    public static var white: Self {
        @Dependency(\.color.white) var white
        return white
    }
    public static var offWhite: Self {
        @Dependency(\.color.offWhite) var offWhite
        return offWhite
    }

    public static var cyan: Self {
        @Dependency(\.color.cyan) var cyan
        return cyan
    }
    public static var teal: Self {
        @Dependency(\.color.teal) var teal
        return teal
    }
    public static var pink: Self {
        @Dependency(\.color.pink) var pink
        return pink
    }
    public static var brown: Self {
        @Dependency(\.color.brown) var brown
        return brown
    }

    public static var orange: Self {
        @Dependency(\.color.orange) var orange
        return orange
    }
    public static var green: Self {
        @Dependency(\.color.green) var green
        return green
    }
    public static var purple: Self {
        @Dependency(\.color.purple) var purple
        return purple
    }
    public static var blue: Self {
        @Dependency(\.color.blue) var blue
        return blue
    }
    public static var red: Self {
        @Dependency(\.color.red) var red
        return red
    }
    public static var yellow: Self {
        @Dependency(\.color.yellow) var yellow
        return yellow
    }
}

extension HTMLColor {
    public static let cardBackground: Self = .init(light: .rgb(red: 245, green: 246, blue: 248), dark: .rgb(red: 25, green: 25, blue: 27))
}

extension HTMLColor {
    public static let buttonBackground: Self = .cardBackground
}
