//
//  ToolbarReturnButton.swift
//  DSDInfo
//
//  Created by Joe Chan on 7/1/2026.
//

import SwiftUI

struct ToolbarReturnButton: View {
    @Binding var presentationMode: PresentationMode

    var body: some View {
        Button(action: {
            $presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: systemImageWithFallback(for: "arrow.uturn.backward.circle.fill"))
                .font(.system(size: 24))
                .foregroundColor(Color("DSD Blue 100%"))
        }
    }
}

