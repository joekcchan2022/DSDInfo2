//
//  GenericPdfView.swift
//  DSDInfo
//
//  Created by Joe Chan on 8/1/2026.
//

import SwiftUI

struct GenericPdfView: View {
    var serviceName: String
    var urlPath: String
    @EnvironmentObject var appConfig: AppConfig

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                PDFKitView(urlPath: urlPath)
                    .navigationTitle(serviceName)
                    .navigationBarTitleDisplayMode(.automatic)
            }
        } else {
            NavigationView {
                PDFKitView(urlPath: urlPath)
                    .navigationTitle(serviceName)
                    .navigationBarTitleDisplayMode(.automatic)
            }
            .navigationViewStyle(.stack)
            .padding(calculateTopPadding())
        }
    }
}

#Preview {
    GenericPdfView(serviceName: "EMP", urlPath: "https://m.dsd.gov.hk:8446/org_charts/EMP.pdf")
}
