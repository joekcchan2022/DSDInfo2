//
//  StickyTitleView.swift
//  DSDInfo
//
//  Created by Joe Chan on 28/1/2026.
//

import SwiftUI

struct StickyTitleView: View {
    @Environment(\.colorScheme) var colorScheme
    let title: String
    let isScrolled: Bool
    let enableDSDLogo: Bool 
    @State private var showingAboutSheetView: Bool = false

    var body: some View {
        if isScrolled {
            Text(title)
                .font(.body)
                .bold()
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
        } else {
            HStack {
                if enableDSDLogo {
                    Button(action: {
                        showingAboutSheetView.toggle()
                    }) {
                        Image(colorScheme == .light ? "DSDInfo Light" : colorScheme == .dark ? "DSDInfo Dark" : "DSDInfo Tinted")
                            .resizable()
                            .frame(width: 48, height: 48)
                    }
                }
                Text(title)
                    .font(.largeTitle)
                    .bold()
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .sheet(isPresented: $showingAboutSheetView) {
                AboutSheetView()
            }
        }
    }
}
