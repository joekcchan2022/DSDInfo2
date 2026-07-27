//
//  HeaderView.swift
//  DSDInfo
//
//  Created by Joe Chan on 22/1/2026.
//

import SwiftUI

struct HeaderView: View {
    let groupKey: GroupKey // Replace with your actual type
    var body: some View {
        VStack {
            if #available(iOS 16.0, *) {
                HeaderViewHStack(groupKey: groupKey)
                    .dynamicTypeSize(.xSmall ... .xxxLarge)
                    .listRowSeparator(.hidden)
            } else {
                HeaderViewHStack(groupKey: groupKey)
            }
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    let mockGroupKey = GroupKey(id: "EMB", code: "EMB", name: "Electrical & Mechnical Branch", chinese: "機電工程科")
    HeaderView(groupKey: mockGroupKey)
}

