//
//  GenericRowView.swift
//  DSDInfo
//
//  Created by Joe Chan on 11/12/2025.
//

import SwiftUI

struct GenericRowView: View {
    var code: String
    var codeDescription: String
    var codeChinese: String
    var fileUrl: String
    var debugMode: Bool
    @EnvironmentObject var appConfig: AppConfig

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        VStack(alignment: .leading) {
            genericRow()
        }
        .padding(.horizontal, 0)
        .padding(.vertical, 5)
    }
    
    private func genericRow() -> some View {
        return VStack {
            if (horizontalSizeClass == .compact && verticalSizeClass == .compact) || // iPhone
                (horizontalSizeClass == .regular && verticalSizeClass == .compact) || // iPhone Max
                (horizontalSizeClass == .regular && verticalSizeClass == .regular) { // iPad
                // For landscape orientation
                HStack(alignment: .center) {
                    HStack {
                        displayCode()
                        displayDescription()
                    }
                    .padding(.vertical, 5)
                    if debugMode {
                        displayFileUrl()
                    }
                }
            } else {
                VStack(alignment: .leading) {
                    HStack {
                        displayCode()
                        displayDescription()
                    }
                    .padding(.vertical, 5)
                    if debugMode {
                        displayFileUrl()
                    }
                }
            }
        }
    }
    
    private func displayCode() -> some View {
        return VStack {
            Text(code)
                .padding(.top, 5)
                .padding(.bottom, 5)
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(getColors(for: appConfig.contrast, theme: .blue).backgroundColor)
                )
                .foregroundColor(getColors(for: appConfig.contrast, theme: .blue).foregroundColor)
                .font(.headline)
        }
    }
    
    private func displayDescription() -> some View {
        return VStack {
            // Adjust the layout based on orientation
            if (horizontalSizeClass == .compact && verticalSizeClass == .compact) || // iPhone
                (horizontalSizeClass == .regular && verticalSizeClass == .compact) || // iPhone Max
                (horizontalSizeClass == .regular && verticalSizeClass == .regular) { // iPad
                // For landscape orientation
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(codeDescription)
                            .font(.subheadline)
                            .lineLimit(1) // Limiting to one line for landscape
                            .truncationMode(.tail)
                            .foregroundColor(.primary)
                    }
                    .padding(.leading, 5)
                    
                    if !codeChinese.isEmpty {
                        Text(codeChinese)
                            .font(.subheadline)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .foregroundColor(.primary)
                    }
                }
            } else {
                // For portrait orientation
                VStack(alignment: .leading) {
                    Text(codeDescription)
                        .font(.subheadline)
                        .lineLimit(3)
                        .truncationMode(.tail)
                        .foregroundColor(.primary)
                    
                    if !codeChinese.isEmpty {
                        Text(codeChinese)
                            .font(.subheadline)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.leading, 5)
                .padding(.top, 5)
                .padding(.bottom, 5)
                .padding(.trailing, 15)
            }
        }
    }
    
    private func displayFileUrl() -> some View {
        return VStack {
            Text(fileUrl)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.vertical, 5)
        }
    }
}

#Preview {
    VStack(alignment: .leading) {
        GenericRowView(code: "EMP",
                       codeDescription: "Electrical & Mechanical Projects Division",
                       codeChinese: "機電工程部",
                       fileUrl: "https://devptl01.dsd.hksarg/org_charts/EMP.pdf",
                       debugMode: true)
        GenericRowView(code: "TW",
                       codeDescription: "Following Days in This Week",
                       codeChinese: "",
                       fileUrl: "https://devptl01.dsd.hksarg/vrss/TW.pdf",
                       debugMode: true)
    }
}
