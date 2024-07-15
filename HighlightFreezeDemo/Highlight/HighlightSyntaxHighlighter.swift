//
//  HighlightSyntaxHighligher.swift
//  MorphAI
//
//  Created by Erik Abramczyk on 7/14/24.
//

import MarkdownUI
import SwiftUI

struct HighlightSyntaxHighligher: CodeSyntaxHighlighter {
  public let syntaxHighlighter: Highlight
    private let isDarkMode: Bool

    init(isDarkMode: Bool) {
    self.syntaxHighlighter = Highlight()
        self.isDarkMode = isDarkMode
  }

  func highlightCode(_ content: String, language: String?) -> Text {
    guard language != nil else {
        return Text(content)
    }
      
    let semaphore = DispatchSemaphore(value: 0)
    var result: AttributedString?
      
      
      var detectedLanguage: HighlightLanguage? = nil
      if language == "swift" {
          detectedLanguage = .swift
      } else if language == "csharp" {
          detectedLanguage = .cSharp
      }

    Task {
      do {
          if detectedLanguage != nil {
              result = try await syntaxHighlighter.attributedText(content, language: detectedLanguage!, colors: isDarkMode ? .dark(.github) : .light(.github))
          } else {
              result = try await syntaxHighlighter.attributedText(content, colors: isDarkMode ? .dark(.github) : .light(.github))
          }
          print("finished")
      } catch {
          // Handle error
          print(error)
      }
      semaphore.signal()
    }
    semaphore.wait()
      
      return Text(result ?? AttributedString(""))
  }
}
