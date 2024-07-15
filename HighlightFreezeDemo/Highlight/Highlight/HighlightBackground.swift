//
//  HighlightBackground.swift
//  MorphAI
//
//  Created by Erik Abramczyk on 7/14/24.
//
//https://github.com/appstefan/HighlightSwift/blob/main/Sources/HighlightSwift/Highlight/HighlightBackground.swift


struct HighlightBackground {
    static func light(_ theme: HighlightTheme) -> String {
        switch theme {
        case .a11y: return "#fefefe"
        case .atomOne: return "#fafafa"
        case .classic: return "#f5f5f5"
        case .edge: return "#fafafa"
        case .github: return "#fff"
        case .google: return "#fff"
        case .gradient: return "fff"
        case .grayscale: return "#f7f7f7"
        case .harmonic16: return "#f7f9fb"
        case .heetch: return "#feffff"
        case .horizon: return "#fdf0ed"
        case .humanoid: return "#f8f8f2"
        case .ia: return "#f6f6f6"
        case .isblEditor: return "#fff"
        case .kimbie: return "#fbebd4"
        case .nnfx: return "#fff"
        case .pandaSyntax: return "#e6e6e6"
        case .papercolor: return "#eee"
        case .paraiso: return "#e7e9db"
        case .qtcreator: return "#fff"
        case .silk: return "#e9f1ef"
        case .solarFlare: return "#f5f7fa"
        case .solarized: return "#fdf6e3"
        case .stackoverflow: return "#f6f6f6"
        case .standard: return "#f8f8f8"
        case .summerfruit: return "#fff"
        case .synthMidnightTerminal: return "#dddfe0"
        case .tokyoNight: return "#d5d6db"
        case .unikitty: return "#fff"
        case .xcode: return "#fff"
        }
    }

    static func dark(_ theme: HighlightTheme) -> String {
        switch theme {
        case .a11y: return "#2b2b2b"
        case .atomOne: return "#282c34"
        case .classic: return "#151515"
        case .edge: return "#262729"
        case .github: return "#0d1117"
        case .google: return "#1d1f21"
        case .gradient: return "000"
        case .grayscale: return "#101010"
        case .harmonic16: return "#0b1c2c"
        case .heetch: return "#190134"
        case .horizon: return "#1c1e26"
        case .humanoid: return "#232629"
        case .ia: return "#1a1a1a"
        case .isblEditor: return "#404040"
        case .kimbie: return "#221a0f"
        case .nnfx: return "#333"
        case .pandaSyntax: return "#2a2c2d"
        case .papercolor: return "#1c1c1c"
        case .paraiso: return "#2f1e2e"
        case .qtcreator: return "#000"
        case .silk: return "#0e3c46"
        case .solarFlare: return "#18262f"
        case .solarized: return "#002b36"
        case .stackoverflow: return "#1c1b1b"
        case .standard: return "#181818"
        case .summerfruit: return "#151515"
        case .synthMidnightTerminal: return "#050608"
        case .tokyoNight: return "#1a1b26"
        case .unikitty: return "#2e2a31"
        case .xcode: return "#1f2024"
        }
    }
}
