//
//  DocumentViewer.swift
//  DSDInfo
//
//  Created by Joe Chan on 7/1/2026.
//

import Foundation

enum DocumentViewer: String, CaseIterable {
    case pdfkit = "PDFKit"
    case webview = "WebView"
    
    var displayName: String {
        switch self {
        case .pdfkit: return "PDFKit"
        case .webview: return "WebView"
        }
    }
}
