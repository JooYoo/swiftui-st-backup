//
//  WKWebView+Extensions.swift
//  hacker-news
//
//  Created by Yu on 20.10.22.
//

import Foundation
import WebKit

extension WKWebView {
    static func pageNotFound() -> WKWebView {
        let wkWebView = WKWebView()
        wkWebView.loadHTMLString("<html><body><h1>page not found</h1></body></html>", baseURL: nil)
        
        return wkWebView
    }
}
