//
//  ServiceDetailPdfView.swift
//  DSDInfo
//
//  Created by Joe Chan on 17/12/2025.
//

import SwiftUI

struct ServiceDetailPdfView: View {
    var serviceName: String
    var urlPath: String
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ZStack {
                    PDFKitRepresentedView(URL(string: urlPath)!)
                        .edgesIgnoringSafeArea(.all)
                }
                .navigationTitle(serviceName)
                .navigationBarTitleDisplayMode(.inline)
            }
        } else {
            NavigationView {
                ZStack {
                    PDFKitRepresentedView(URL(string: urlPath)!)
                        .edgesIgnoringSafeArea(.all)
                }
                .navigationTitle(serviceName)
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(.stack)
        }
    }
}

struct ServiceDetailPdfView_Previews: PreviewProvider {
    static let url: String = "https://m.dsd.gov.hk:8446/org_charts/EMP.pdf"
    static var previews: some View {
        ServiceDetailPdfView(serviceName: "Electrical & Mechnical Projects Division", urlPath: url)
        
    }
}
