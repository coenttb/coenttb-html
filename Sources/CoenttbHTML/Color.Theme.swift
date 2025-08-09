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
    public struct Theme: Sendable {
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
        public var text: HTMLColor.Theme.Text
        public var background: HTMLColor.Theme.Background
        public var branding: HTMLColor.Theme.Branding
    }
}

extension HTMLColor.Theme {
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
            primary: HTMLColor,
            secondary: HTMLColor,
            tertiary: HTMLColor,
            link: HTMLColor,
            button: HTMLColor,
            error: HTMLColor,
            success: HTMLColor,
            warning: HTMLColor,
            inverted: HTMLColor,
            disabled: HTMLColor
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



extension HTMLColor.Theme {
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
            primary: HTMLColor,
            secondary: HTMLColor,
            tertiary: HTMLColor,
            elevated: HTMLColor,
            grouped: HTMLColor,
            selected: HTMLColor,
            highlighted: HTMLColor,
            button: HTMLColor
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



extension HTMLColor.Theme {
    public struct Branding: Sendable {
        public var primary: HTMLColor
        public var secondary: HTMLColor
        public var accent: HTMLColor
        public var primarySubtle: HTMLColor
        public var secondarySubtle: HTMLColor

        public init(
            primary: HTMLColor,
            secondary: HTMLColor,
            accent: HTMLColor,
            primarySubtle: HTMLColor,
            secondarySubtle: HTMLColor
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
    public static var `default`: HTMLColor.Theme {
        @Dependency(\.color) var color
        return color
    }
}

extension HTMLColor {
    public static var text: HTMLColor.Theme.Text {
        @Dependency(\.color.text) var text
        return text
    }
}

extension HTMLColor {
    public static var background: HTMLColor.Theme.Background {
        @Dependency(\.color.background) var background
        return background
    }
}

extension HTMLColor {
    public static var branding: HTMLColor.Theme.Branding {
        @Dependency(\.color.branding) var branding
        return branding
    }
}



extension HTMLColor.Theme: DependencyKey {
    public static var liveValue: Self { .default }
    public static var testValue: Self { liveValue }
    public static var previewValue: Self { liveValue }
}

extension DependencyValues {
    public var color: HTMLColor.Theme {
        get { self[HTMLColor.Theme.self] }
        set { self[HTMLColor.Theme.self] = newValue }
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
