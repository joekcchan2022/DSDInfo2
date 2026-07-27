//
//  PDFKitView.swift
//  DSDInfo
//
//  Created by Joe Chan on 22/1/2026.
//

import SwiftUI

struct PDFKitView: View {
    let urlPath: String
    @EnvironmentObject var appConfig: AppConfig // Use as an environment object

    var body: some View {
        VStack {
            if appConfig.documentViewer == .pdfkit {
                PDFKitRepresentedView(URL(string: urlPath)!)
                    .edgesIgnoringSafeArea(.all)
            } else {
                WebView(URL(string: urlPath)!)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

#Preview {
    let mockUrlPath = "https://m.dsd.gov.hk:8446/org_chart/EMP/"
    let mockAppConfig = AppConfig()
    mockAppConfig.enableChinese = true
    return PDFKitView(urlPath: mockUrlPath)
        .environmentObject(mockAppConfig)
}
