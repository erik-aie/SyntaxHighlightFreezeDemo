//
//  ContentView.swift
//  HighlightFreezeDemo
//
//  Created by Erik Abramczyk on 7/15/24.
//

import SwiftUI
import MarkdownUI

struct ContentView: View {
    
    var demoHtml = 
    """
    <style>
    pre code.hljs{display:block;overflow-x:auto;padding:1em}code.hljs{padding:3px 5px}.hljs{color:#c9d1d9}.hljs-doctag,.hljs-keyword,.hljs-meta .hljs-keyword,.hljs-template-tag,.hljs-template-variable,.hljs-type,.hljs-variable.language_{color:#ff7b72}.hljs-title,.hljs-title.class_,.hljs-title.class_.inherited__,.hljs-title.function_{color:#d2a8ff}.hljs-attr,.hljs-attribute,.hljs-literal,.hljs-meta,.hljs-number,.hljs-operator,.hljs-selector-attr,.hljs-selector-class,.hljs-selector-id,.hljs-variable{color:#79c0ff}.hljs-meta .hljs-string,.hljs-regexp,.hljs-string{color:#a5d6ff}.hljs-built_in,.hljs-symbol{color:#ffa657}.hljs-code,.hljs-comment,.hljs-formula{color:#8b949e}.hljs-name,.hljs-quote,.hljs-selector-pseudo,.hljs-selector-tag{color:#7ee787}.hljs-subst{color:#c9d1d9}.hljs-section{color:#1f6feb;font-weight:700}.hljs-bullet{color:#f2cc60}.hljs-emphasis{color:#c9d1d9;font-style:italic}.hljs-strong{color:#c9d1d9;font-weight:700}.hljs-addition{color:#aff5b4}.hljs-deletion{color:#ffdcd7}
    </style>
    <pre><code class="hljs"><span class="hljs-keyword">private</span> func <span class="hljs-title function_ invoke__">attributedTextFromData</span>(_ <span class="hljs-attr">data</span>: Data) throws -&gt; AttributedString {
            guard let htmlString = <span class="hljs-title function_ invoke__">String</span>(<span class="hljs-attr">data</span>: data, <span class="hljs-attr">encoding</span>: .utf8) <span class="hljs-keyword">else</span> {
                <span class="hljs-keyword">throw</span> <span class="hljs-title function_ invoke__">NSError</span>(<span class="hljs-attr">domain</span>: <span class="hljs-string">&quot;HTMLParsingError&quot;</span>, <span class="hljs-attr">code</span>: <span class="hljs-number">0</span>, <span class="hljs-attr">userInfo</span>: [<span class="hljs-attr">NSLocalizedDescriptionKey</span>: <span class="hljs-string">&quot;Unable to convert data to string&quot;</span>])
            }
            
            let doc: Document = <span class="hljs-keyword">try</span> SwiftSoup.<span class="hljs-title function_ invoke__">parse</span>(htmlString)
            let bodyText = <span class="hljs-keyword">try</span> doc.<span class="hljs-title function_ invoke__">text</span>()
            let attributedString = <span class="hljs-title function_ invoke__">NSMutableAttributedString</span>(<span class="hljs-attr">string</span>: bodyText)
            attributedString.<span class="hljs-title function_ invoke__">removeAttribute</span>(
                .font,
                <span class="hljs-attr">range</span>: <span class="hljs-title function_ invoke__">NSMakeRange</span>(<span class="hljs-number">0</span>, attributedString.length)
            )

            
            func <span class="hljs-title function_ invoke__">traverseNode</span>(_ <span class="hljs-attr">node</span>: Node) throws {
                <span class="hljs-keyword">if</span> let textNode = node <span class="hljs-keyword">as</span>? TextNode {
                    attributedString.<span class="hljs-title function_ invoke__">append</span>(<span class="hljs-title function_ invoke__">NSAttributedString</span>(<span class="hljs-attr">string</span>: textNode.<span class="hljs-title function_ invoke__">text</span>()))
                } <span class="hljs-keyword">else</span> <span class="hljs-keyword">if</span> let element = node <span class="hljs-keyword">as</span>? Element {
                    let startIndex = attributedString.length
                    <span class="hljs-keyword">for</span> child in element.<span class="hljs-title function_ invoke__">children</span>() {
                        <span class="hljs-keyword">try</span> <span class="hljs-title function_ invoke__">traverseNode</span>(child)
                    }
                    let range = <span class="hljs-title function_ invoke__">NSRange</span>(<span class="hljs-attr">location</span>: startIndex, <span class="hljs-attr">length</span>: attributedString.length - startIndex)
                    
                    <span class="hljs-comment">// Apply attributes based on element type and style</span>
                    <span class="hljs-keyword">if</span> let style = <span class="hljs-keyword">try</span>? element.<span class="hljs-title function_ invoke__">attr</span>(<span class="hljs-string">&quot;style&quot;</span>) {
                        let styleComponents = style.<span class="hljs-title function_ invoke__">components</span>(<span class="hljs-attr">separatedBy</span>: <span class="hljs-string">&quot;;&quot;</span>)
                        <span class="hljs-keyword">for</span> component in styleComponents {
                            let parts = component.<span class="hljs-title function_ invoke__">components</span>(<span class="hljs-attr">separatedBy</span>: <span class="hljs-string">&quot;:&quot;</span>)
                            <span class="hljs-keyword">if</span> parts.count == <span class="hljs-number">2</span> {
                                let property = parts[<span class="hljs-number">0</span>].<span class="hljs-title function_ invoke__">trimmingCharacters</span>(<span class="hljs-attr">in</span>: .whitespaces)
                                let value = parts[<span class="hljs-number">1</span>].<span class="hljs-title function_ invoke__">trimmingCharacters</span>(<span class="hljs-attr">in</span>: .whitespaces)
                                
                                <span class="hljs-keyword">if</span> property == <span class="hljs-string">&quot;color&quot;</span> {
                                    let color = <span class="hljs-title function_ invoke__">Color</span>(<span class="hljs-attr">hex</span>: value)
                                    <span class="hljs-comment">#if os(macOS)</span>
                                    attributedString.<span class="hljs-title function_ invoke__">addAttribute</span>(.foregroundColor, <span class="hljs-attr">value</span>: <span class="hljs-title function_ invoke__">NSColor</span>(color), <span class="hljs-attr">range</span>: range)
                                    <span class="hljs-comment">#else</span>
                                    attributedString.<span class="hljs-title function_ invoke__">addAttribute</span>(.foregroundColor, <span class="hljs-attr">value</span>: <span class="hljs-title function_ invoke__">UIColor</span>(color), <span class="hljs-attr">range</span>: range)
                                    <span class="hljs-comment">#endif</span>
                                }
                            }
                        }
                    }
                    
                    <span class="hljs-keyword">switch</span> element.<span class="hljs-title function_ invoke__">tagName</span>().<span class="hljs-title function_ invoke__">lowercased</span>() {
                    <span class="hljs-keyword">case</span> <span class="hljs-string">&quot;b&quot;</span>, <span class="hljs-string">&quot;strong&quot;</span>:
                        attributedString.<span class="hljs-title function_ invoke__">addAttribute</span>(.font, <span class="hljs-attr">value</span>: Font.bold, <span class="hljs-attr">range</span>: range)
                    <span class="hljs-keyword">case</span> <span class="hljs-string">&quot;i&quot;</span>, <span class="hljs-string">&quot;em&quot;</span>:
                        attributedString.<span class="hljs-title function_ invoke__">addAttribute</span>(.font, <span class="hljs-attr">value</span>: Font.italic, <span class="hljs-attr">range</span>: range)
                    <span class="hljs-keyword">case</span> <span class="hljs-string">&quot;u&quot;</span>:
                        attributedString.<span class="hljs-title function_ invoke__">addAttribute</span>(.underlineStyle, <span class="hljs-attr">value</span>: NSUnderlineStyle.single.rawValue, <span class="hljs-attr">range</span>: range)
                    <span class="hljs-keyword">case</span> <span class="hljs-string">&quot;a&quot;</span>:
                        <span class="hljs-keyword">if</span> let href = <span class="hljs-keyword">try</span>? element.<span class="hljs-title function_ invoke__">attr</span>(<span class="hljs-string">&quot;href&quot;</span>) {
                            attributedString.<span class="hljs-title function_ invoke__">addAttribute</span>(.link, <span class="hljs-attr">value</span>: href, <span class="hljs-attr">range</span>: range)
                        }
                    <span class="hljs-keyword">default</span>:
                        <span class="hljs-keyword">break</span>
                    }
                }
            }
            
            
           <span class="hljs-keyword">try</span> <span class="hljs-title function_ invoke__">traverseNode</span>(doc)

            <span class="hljs-comment">#if os(macOS)</span>
                    <span class="hljs-keyword">return</span> <span class="hljs-keyword">try</span> <span class="hljs-title function_ invoke__">AttributedString</span>(attributedString, <span class="hljs-attr">including</span>: \\.appKit)
            <span class="hljs-comment">#else</span>
                    <span class="hljs-keyword">return</span> <span class="hljs-keyword">try</span> <span class="hljs-title function_ invoke__">AttributedString</span>(attributedString, <span class="hljs-attr">including</span>: \\.uiKit)
            <span class="hljs-comment">#endif</span>
    }</code></pre>
    """
    var demoMarkdown =
    """
    Hello world:
    
    ```swift
    func hello() -> {
        print("Hello world")
    }
    ```
    """
    
    var demoSwift =
    """
    func hello() -> {
        print("Hello world")
    }
    """
    
    @State var asyncLoadedAttributedText: AttributedString?
    
    var highlighter = HighlightSyntaxHighligher(isDarkMode: true)
    
    var body: some View {
        VStack {
            //works cross platform
//            if let data = try? htmlDataFromText(demoHtml, selectors: HighlightColors.dark(.xcode).css) {
//                if let attributedString = try? attributedTextFromData(data) {
//                    Text(attributedString)
//                }
//            }
            //fails on iOS
//            Markdown(demoMarkdown)
//                .markdownCodeSyntaxHighlighter(HighlightSyntaxHighligher(isDarkMode: true))
            //fails on iOS
//            highlighter.highlightCode(demoSwift, language: "swift")
            //works cross platform
            Text(asyncLoadedAttributedText ?? AttributedString())
        }
        .padding()
        .task {
            asyncLoadedAttributedText = try? await highlighter.syntaxHighlighter.attributedText(demoSwift, language: .swift)
        }
    }
    
    private func htmlDataFromText(_ text: String, selectors: String) throws -> Data {
        let html = "<style>\n"
            .appending(selectors)
            .appending("\n</style>")
            .appending("\n<pre><code class=\"hljs\">")
            .appending(text.trimmingCharacters(in: .whitespacesAndNewlines))
            .appending("</code></pre>")
        return html.data(using: .utf8) ?? Data()
    }
    
    private func attributedTextFromData(_ data: Data) throws -> AttributedString {
        let mutableString = try NSMutableAttributedString(
            data: data,
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil
        )
        mutableString.removeAttribute(
            .font,
            range: NSMakeRange(0, mutableString.length)
        )
        print(mutableString)
        let range = NSRange(location: 0, length: mutableString.length - 1)
        let attributedString = mutableString.attributedSubstring(from: range)
#if os(macOS)
        return try AttributedString(attributedString, including: \.appKit)
#else
        return try AttributedString(attributedString, including: \.uiKit)
#endif
    }
}

#Preview {
    ContentView()
}
