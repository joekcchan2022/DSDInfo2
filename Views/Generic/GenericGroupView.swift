//
//  GenericGroupView.swift
//  DSDInfo
//
//  Created by Joe Chan on 11/12/2025.
//

import SwiftUI

struct GenericGroupView<Content: Displayable>: View {
    var groupKey: GroupKey
    var displayItems: [Content]
    var debugMode: Bool
    @State private var showingGenericRowViewSheet: Bool = false
    @State private var selectedUrl: String?
    @EnvironmentObject var appConfig: AppConfig

    var body: some View {
        Section(header: HeaderView(groupKey: groupKey)) {
            ForEach(displayItems.sorted(by: { $0.displayOrderNo < $1.displayOrderNo })) { service in
                if appConfig.enableSheetPresentation {
                    if #available(iOS 15.0, *) {
                        Button(action: {
                            showingGenericRowViewSheet = true
                        }) {
                            GenericRowView(code: service.displayCode,
                                           codeDescription: service.displayName,
                                           codeChinese: appConfig.enableChinese ? service.displayNameChinese : "",
                                           fileUrl: service.displayUrl,
                                           debugMode: debugMode)
                        }
                        .listRowSeparator(.hidden)
                        .sheet(isPresented: $showingGenericRowViewSheet) {
                            GenericPdfSheetView(serviceName: service.displayName, urlPath: service.displayUrl)
                        }
                    } else {
                        Button(action: {
                            showingGenericRowViewSheet = true
                        }) {
                            GenericRowView(code: service.displayCode,
                                           codeDescription: service.displayName,
                                           codeChinese: appConfig.enableChinese ? service.displayNameChinese : "",
                                           fileUrl: service.displayUrl,
                                           debugMode: debugMode)
                        }
                        .sheet(isPresented: $showingGenericRowViewSheet) {
                            GenericPdfSheetView(serviceName: service.displayName, urlPath: service.displayUrl)
                        }
                    }
                } else {
                    if #available(iOS 15.0, *) {
                        NavigationLink(destination: GenericPdfView(serviceName: service.displayName, urlPath: service.displayUrl)) {
                            GenericRowView(code: service.displayCode,
                                           codeDescription: service.displayName,
                                           codeChinese: appConfig.enableChinese ? service.displayNameChinese : "",
                                           fileUrl: service.displayUrl,
                                           debugMode: debugMode)
                        }
                        .listRowSeparator(.hidden)
                    } else {
                        NavigationLink(destination: GenericPdfView(serviceName: service.displayName, urlPath: service.displayUrl)) {
                            GenericRowView(code: service.displayCode,
                                           codeDescription: service.displayName,
                                           codeChinese: appConfig.enableChinese ? service.displayNameChinese : "",
                                           fileUrl: service.displayUrl,
                                           debugMode: debugMode)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let mockBranchKey = GroupKey(id: "EMB", code: "EMB", name: "Electrical & Mechnical Branch", chinese: "機電工程科")
    let mockChart = OrganizationChart(id: 1,
                                      name: "Organization Chart of EMP",
                                      shortName: "EMP",
                                      orgCode: "EMP",
                                      orgName: "Electrical & Mechanical Projects Division",
                                      orgChinese: "機電工程部",
                                      branchCode: "EMB",
                                      branchName: "Electrical & Mechanical Branch",
                                      branchChinese: "機電工程科",
                                      orderNo: 1,
                                      status: "Updated",
                                      webUrl: "https://devptl01.dsd.hksarg/org_chart/EMP/",
                                      fileUrl: "https://devptl01.dsd.hksarg/org_charts/EMP.pdf")

    GenericGroupView(groupKey: mockBranchKey, displayItems: [mockChart], debugMode: true)
}
