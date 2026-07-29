//
//  HeaderViewHStack.swift
//  DSDInfo
//
//  Created by Joe Chan on 22/1/2026.
//

import SwiftUI

struct HeaderViewHStack: View {
    let groupKey: GroupKey
    @EnvironmentObject var appConfig: AppConfig

    private var themeColor: Color {
        getColors(for: appConfig.contrast, theme: .normal).backgroundColor
    }

    private var textColor: Color {
        getColors(for: appConfig.contrast, theme: .normal).foregroundColor
    }

    var body: some View {
        HStack(spacing: 0) {
            // --- Part A ---
            Text(groupKey.chinese.isEmpty ? groupKey.name : appConfig.enableChinese ? "\(groupKey.name) \(groupKey.chinese)" : groupKey.name)
                .font(.subheadline)
                .padding(.vertical, 5)
                .padding(.horizontal)
                .foregroundColor(textColor)
                .frame(maxHeight: .infinity) // Fill container height if Part B expands
                .background(themeColor)

            // --- Part B ---
            Text(groupKey.code)
                .font(.headline)
                .padding(.vertical, 5)
                .padding(.horizontal)
                .foregroundColor(Color(.secondaryLabel))
                .frame(maxHeight: .infinity) // Fill container height when Part A wraps
                .background(themeColor.opacity(0.5))
        }
        .fixedSize(horizontal: false, vertical: true) // Prevents infinite vertical stretching
        .clipShape(RoundedRectangle(cornerRadius: 10)) // Clips the outer corners cleanly across iOS versions
        .padding(.trailing)
    }
}

#Preview {
    let mockGroupKey = GroupKey(id: "EMB", code: "EMB", name: "Electrical & Mechnical Branch", chinese: "機電工程科")
    let mockAppConfig = AppConfig()
    mockAppConfig.enableChinese = true
    return HeaderViewHStack(groupKey: mockGroupKey)
        .environmentObject(mockAppConfig)
}
