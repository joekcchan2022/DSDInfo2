//
//  PDFKitRepresentedView.swift
//  DSDInfo
//
//  Created by Joe Chan on 17/12/2025.
//

import SwiftUI
import PDFKit

struct PDFKitRepresentedView: UIViewRepresentable {
    @EnvironmentObject var appConfig: AppConfig
    let url: URL

    init(_ url: URL) {
        self.url = url
    }
    
    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView()
        loadPDF { document in
            DispatchQueue.main.async {
                pdfView.document = document
            }
        }
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
    
    private func loadPDF(completion: @escaping (PDFDocument?) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session: URLSession
        
        if appConfig.enableMutualAuthentication {
            session = URLSession(configuration: sessionConfig, delegate: URLSessionClientCertificateHandling(appConfig: appConfig), delegateQueue: nil)
        } else {
            session = URLSession.shared
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching PDF: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }

            // Create a PDFDocument from the received data
            let pdfDocument = PDFDocument(data: data)
            completion(pdfDocument)
        }

        task.resume()
    }
        
}

struct PDFKitRepresentedView_Previews: PreviewProvider {
    static var url: URL? {
        URL(string: "https://m.dsd.gov.hk:8446/org_chart/EMP/")
    }
    
    static var previews: some View {
        // Ensure url is safely unwrapped
        if let validURL = url {
            PDFKitRepresentedView(validURL)
        } else {
            Text("Invalid URL") // Fallback in case the URL is nil
        }
    }
}
