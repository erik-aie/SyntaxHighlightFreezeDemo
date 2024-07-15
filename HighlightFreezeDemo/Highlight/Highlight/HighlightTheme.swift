//
//  HighlightTheme.swift
//  MorphAI
//
//  Created by Erik Abramczyk on 7/14/24.
//
//https://github.com/appstefan/HighlightSwift/blob/main/Sources/HighlightSwift/Highlight/HighlightTheme.swift

public enum HighlightTheme: String, CaseIterable, Identifiable, Equatable {
    case a11y = "a11y"
    case atomOne = "Atom One"
    case classic = "Classic"
    case edge = "Edge"
    case github = "GitHub"
    case google = "Google"
    case gradient = "Gradient"
    case grayscale = "Grayscale"
    case harmonic16 = "Harmonic16"
    case heetch = "Heetch"
    case horizon = "Horizon"
    case humanoid = "Humanoid"
    case ia = "iA"
    case isblEditor = "ISBL Editor"
    case kimbie = "Kimbie"
    case nnfx = "NNFX"
    case pandaSyntax = "Panda Syntax"
    case papercolor = "Papercolor"
    case paraiso = "Paraiso"
    case qtcreator = "QT Creator"
    case silk = "Silk"
    case solarFlare = "Solar Flare"
    case solarized = "Solarized"
    case stackoverflow = "StackOverflow"
    case standard = "Standard"
    case summerfruit = "Summerfruit"
    case synthMidnightTerminal = "Synth Midnight Terminal"
    case tokyoNight = "Tokyo Night"
    case unikitty = "Unikitty"
    case xcode = "Xcode"
    
    public var id: String {
        rawValue
    }
}
