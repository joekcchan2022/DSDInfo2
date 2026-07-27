//
//  SearchBar.swift
//  DSDInfo
//
//  Created by Joe Chan on 28/1/2026.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: systemImageWithFallback(for: "magnifyingglass"))
                .foregroundColor(Color(.systemFill))            
            TextField("Search", text: $searchText)
                .foregroundColor(Color(.secondarySystemFill))
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: systemImageWithFallback(for: "xmark.circle.fill"))
                        .foregroundColor(Color(.systemFill))
                }
                .padding(.horizontal, 8)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(20)
    }
}
