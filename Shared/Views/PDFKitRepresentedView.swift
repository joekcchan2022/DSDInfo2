//
//  PDFKitRepresentedView.swift
//  DSDInfo2
//
//  Created by Joe Chan on 15/9/2022.
//

import SwiftUI
import PDFKit

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL

    init(_ url: URL) {
        self.url = url
    }

    
    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        
        let modelName = UIDevice().modelName.replacingOccurrences(of: "Simulator ", with: "")
        print(modelName)

        switch modelName {
        case "iPhone15,2", "iPhone15,3":
            print("Auto scale enabled in PDF for \(modelName)");
            pdfView.autoScales = true;
        default:
            /* Workaround for Security Warning:
               This method should not be called on the main thread as it may lead to UI unresponsiveness
               except at iPhone 14 Pro and iPhone 14 Pro Max */
            print("Auto scale disabled in PDF for \(modelName)");
        }
        
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
}

struct PDFKitRepresentedView_Previews: PreviewProvider {
    static let url: URL! = Bundle.main.url(forResource: "VRS_this_week", withExtension: "pdf")!
    static var previews: some View {
        PDFKitRepresentedView(url)
    }
}
