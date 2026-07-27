//
//  ServiceDetailWebView.swift
//  DSDInfo
//
//  Created by Joe Chan on 17/12/2025.
//

import SwiftUI

struct ServiceDetailWebView: View {
    var serviceName: String
    var urlPath: String

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ZStack {
                    WebView(URL(string: urlPath)!)
                        .edgesIgnoringSafeArea(.all)
                }
                .navigationTitle(serviceName)
                .navigationBarTitleDisplayMode(.inline)
            }
        } else {
            NavigationView {
                ZStack {
                    WebView(URL(string: urlPath)!)
                        .edgesIgnoringSafeArea(.all)
                }
                .navigationTitle(serviceName)
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(.stack)
        }
    }
}

struct ServiceDetailWebView_Previews: PreviewProvider {
    static let url: String = "https://m.dsd.gov.hk:8446/org_charts/EMP.pdf"
    static var previews: some View {
        ServiceDetailWebView(serviceName: "Electrical & Mechnical Projects Division", urlPath: url)
        
    }
}
