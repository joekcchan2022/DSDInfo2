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

    var body: some View {
        HStack {
            Text(groupKey.code)
                .font(.headline)
                .padding(.vertical, 5)
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 10).fill(getColors(for: appConfig.contrast, theme: .normal).backgroundColor))
                .foregroundColor(getColors(for: appConfig.contrast, theme: .normal).foregroundColor)
            
            Text(groupKey.chinese.isEmpty ? groupKey.name : appConfig.enableChinese ? "\(groupKey.name) \(groupKey.chinese)" : groupKey.name)
                .font(.subheadline)
                .foregroundColor(Color(.secondaryLabel))
        }
    }
}

#Preview {
    let mockGroupKey = GroupKey(id: "EMB", code: "EMB", name: "Electrical & Mechnical Branch", chinese: "機電工程科")
    let mockAppConfig = AppConfig()
    mockAppConfig.enableChinese = true
    return HeaderViewHStack(groupKey: mockGroupKey)
        .environmentObject(mockAppConfig)
}
