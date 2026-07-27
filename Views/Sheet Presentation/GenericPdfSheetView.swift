//
//  GenericPdfSheetView.swift
//  DSDInfo
//
//  Created by Joe Chan on 8/1/2026.
//

import SwiftUI

struct GenericPdfSheetView: View {
    var serviceName: String
    var urlPath: String

    @EnvironmentObject var appConfig: AppConfig
    @Environment(\.presentationMode) var genericPdfViewPresentationMode

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                pdfView()
            }
        } else {
            NavigationView {
                pdfView()
            }
            .navigationViewStyle(.stack)
        }
    }
    
    private func pdfView() -> some View {
        return VStack {
            if appConfig.documentViewer == .pdfkit {
                PDFKitRepresentedView(URL(string: urlPath)!)
                    .edgesIgnoringSafeArea(.all)
            } else {
                WebView(URL(string: urlPath)!)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .navigationTitle(serviceName)
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                ToolbarReturnButton(presentationMode: genericPdfViewPresentationMode)
            }
        }
    }
}

#Preview {
    GenericPdfSheetView(serviceName: "EMP", urlPath: "https://m.dsd.gov.hk:8446/org_charts/EMP.pdf")
}
