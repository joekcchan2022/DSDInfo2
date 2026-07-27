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
        HStack(spacing: 0) {
            if #available(iOS 16.0, *) {
                Text(groupKey.chinese.isEmpty ? groupKey.name : appConfig.enableChinese ? "\(groupKey.name) \(groupKey.chinese)" : groupKey.name)
                    .font(.subheadline)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 10,
                            bottomLeadingRadius: 10,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 0
                        )
                        .fill(getColors(for: appConfig.contrast, theme: .normal).backgroundColor))
                    .foregroundColor(getColors(for: appConfig.contrast, theme: .normal).foregroundColor)
            
                Text(groupKey.code)
                    .font(.subheadline)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 10,
                            topTrailingRadius: 10
                        )
                        .fill(getColors(for: appConfig.contrast, theme: .normal).backgroundColor.opacity(0.5)))
                    .foregroundColor(Color(.secondaryLabel))
            } else {
                Text(groupKey.chinese.isEmpty ? groupKey.name : appConfig.enableChinese ? "\(groupKey.name) \(groupKey.chinese)" : groupKey.name)
                    .font(.subheadline)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 10).fill(getColors(for: appConfig.contrast, theme: .normal).backgroundColor))
                    .foregroundColor(getColors(for: appConfig.contrast, theme: .normal).foregroundColor)
                Text(groupKey.code)
                    .font(.subheadline)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 10).fill(getColors(for: appConfig.contrast, theme: .normal).backgroundColor).opacity(0.5))
                    .foregroundColor(Color(.secondaryLabel))
            }
        }
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
