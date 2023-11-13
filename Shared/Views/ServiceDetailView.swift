//
//  ServiceDetailView.swift
//  DSDInfo2
//
//  Created by Joe Chan on 16/9/2022.
//

import SwiftUI

struct ServiceDetailView: View {
    var serviceName: String
    var urlPath: String

    var body: some View {
//        NavigationView() {
            VStack {
                PDFKitRepresentedView(URL(string: urlPath)!)
            }
            .navigationTitle(serviceName)
//        }
    }
}

struct ServiceDetailView_Previews: PreviewProvider {
    static let url: String = "https://m.dsd.gov.hk:8447/mdsdinfo/ochart/OChart_DSD.pdf"
    static var previews: some View {
        ServiceDetailView(serviceName: "Hello World", urlPath: url)
    }
}
