//
//  OrganizationChartView.swift
//  DSDInfo
//
//  Created by Joe Chan on 9/12/2025.
//

import Combine
import SwiftUI

struct OrganizationChartView: View {
    @StateObject private var viewModel: ContentViewModel
    @EnvironmentObject var appConfig: AppConfig
    @State private var isScrolled: Bool = false
    @State private var searchText: String = ""
    private let enterScrolledThreshold: CGFloat = 44
    private let exitScrolledThreshold:  CGFloat = 8
    
    init(config: AppConfig) {
        _viewModel = StateObject(wrappedValue: ContentViewModel(config: config))
    }
    
    var body: some View {
        // Group organization charts by branch code
        let groupedCharts = Dictionary(grouping: viewModel.organizationCharts) { chart -> GroupKey in
            let branchCode = (chart.branchCode.isEmpty) ? chart.orgCode : chart.branchCode
            let branchName = (chart.branchCode.isEmpty) ? chart.orgName : chart.branchName
            let branchChinese = (chart.branchCode.isEmpty) ? chart.orgChinese : chart.branchChinese
            return GroupKey(id: branchCode, code: branchCode, name: branchName, chinese: branchChinese)
        }
        
        // Sort branch keys based on the orderNo of the first element in each group
        let sortedBranchKeys = groupedCharts.keys.sorted {
            let firstOrderNo1 = groupedCharts[$0]?.first?.orderNo ?? Int.max
            let firstOrderNo2 = groupedCharts[$1]?.first?.orderNo ?? Int.max
            return firstOrderNo1 < firstOrderNo2
        }
        
        if #available(iOS 26.0, *) {
            if appConfig.debugMode {
                let _ = print("iOS 26+")
            }
            NavigationStack {
                List {
                    StickyTitleView(title: "Organization Chart", isScrolled: isScrolled, enableDSDLogo: true)
                        .listRowSeparator(.hidden)
                        .padding(.vertical, -10)
                    if appConfig.searchBar, isScrolled == false {
                        SearchBar(searchText: $searchText)
                            .listRowSeparator(.hidden)
                            .padding(.vertical, -20)
                    }
                    ForEach(sortedBranchKeys, id: \.self) { branchKey in
                        let chartsForBranch = groupedCharts[branchKey] ?? []
                        let filteredCharts = chartsForBranch.filter { chart in
                            searchText.isEmpty ||
                            chart.orgName.localizedCaseInsensitiveContains(searchText) ||
                            chart.orgChinese.localizedCaseInsensitiveContains(searchText) ||
                            chart.orgCode.localizedCaseInsensitiveContains(searchText)
                        }
                        
                        if !filteredCharts.isEmpty {
                            let sortedCharts = filteredCharts.sorted { $0.orderNo > $1.orderNo }
                            GenericGroupView(
                                groupKey: branchKey,
                                displayItems: sortedCharts,
                                debugMode: appConfig.debugMode
                            )
                        }
                    }
                    .padding(.vertical, -10)
                }
                .listStyle(.plain)
                .onScrollGeometryChange(for: CGFloat.self) { geo in
                    geo.contentOffset.y
                } action: { oldOffset, newOffset in
                    let shouldBeScrolled: Bool
                    if isScrolled {
                        shouldBeScrolled = newOffset > exitScrolledThreshold
                    } else {
                        shouldBeScrolled = newOffset > enterScrolledThreshold
                    }
                    if shouldBeScrolled != isScrolled {
                        withAnimation(.easeOut(duration: 0.25)) {
                            isScrolled = shouldBeScrolled
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchOrganizationCharts()
            }
            .onDisappear {
                viewModel.resetVehicleReservationReports()
            }
            .onChange(of: appConfig.searchBar) { _ in
                searchText = ""
            }
        } else if #available(iOS 18.0, *) {
            if appConfig.debugMode {
                let _ = print("iOS 18+")
            }
            NavigationStack {
                List {
                    StickyTitleView(title: "Organization Chart", isScrolled: isScrolled, enableDSDLogo: true)
                        .listRowSeparator(.hidden)
                        .padding(.vertical, -10)
                    if appConfig.searchBar, isScrolled == false {
                        SearchBar(searchText: $searchText)
                            .listRowSeparator(.hidden)
                            .padding(.vertical, -20)
                    }
                    ForEach(sortedBranchKeys, id: \.self) { branchKey in
                        let chartsForBranch = groupedCharts[branchKey] ?? []
                        let filteredCharts = chartsForBranch.filter { chart in
                            searchText.isEmpty ||
                            chart.orgName.localizedCaseInsensitiveContains(searchText) ||
                            chart.orgChinese.localizedCaseInsensitiveContains(searchText) ||
                            chart.orgCode.localizedCaseInsensitiveContains(searchText)
                        }
                        
                        if !filteredCharts.isEmpty {
                            let sortedCharts = filteredCharts.sorted { $0.orderNo > $1.orderNo }
                            GenericGroupView(
                                groupKey: branchKey,
                                displayItems: sortedCharts,
                                debugMode: appConfig.debugMode
                            )
                        }
                    }
                    .padding(.vertical, -10)
                }
                .listStyle(.plain)
                .onScrollGeometryChange(for: CGFloat.self) { geo in
                    geo.contentOffset.y
                } action: { oldOffset, newOffset in
                    let shouldBeScrolled: Bool
                    if isScrolled {
                        shouldBeScrolled = newOffset > exitScrolledThreshold
                    } else {
                        shouldBeScrolled = newOffset > enterScrolledThreshold
                    }
                    if shouldBeScrolled != isScrolled {
                        withAnimation(.easeOut(duration: 0.25)) {
                            isScrolled = shouldBeScrolled
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchOrganizationCharts()
            }
            .onDisappear {
                viewModel.resetVehicleReservationReports()
            }
            .onChange(of: appConfig.searchBar) { _ in
                searchText = ""
            }
        } else if #available(iOS 16.0, *) {
            if appConfig.debugMode {
                let _ = print("iOS 16+")
            }
            NavigationStack {
                List {
                    StickyTitleView(title: "Organization Chart", isScrolled: isScrolled, enableDSDLogo: true)
                        .listRowSeparator(.hidden)
                        .padding(.vertical, -10)
                    if appConfig.searchBar, isScrolled == false {
                        SearchBar(searchText: $searchText)
                            .listRowSeparator(.hidden)
                            .padding(.vertical, -20)
                    }
                    ForEach(sortedBranchKeys, id: \.self) { branchKey in
                        let chartsForBranch = groupedCharts[branchKey] ?? []
                        let filteredCharts = chartsForBranch.filter { chart in
                            searchText.isEmpty ||
                            chart.orgName.localizedCaseInsensitiveContains(searchText) ||
                            chart.orgChinese.localizedCaseInsensitiveContains(searchText) ||
                            chart.orgCode.localizedCaseInsensitiveContains(searchText)
                        }
                        
                        if !filteredCharts.isEmpty {
                            let sortedCharts = filteredCharts.sorted { $0.orderNo > $1.orderNo }
                            GenericGroupView(
                                groupKey: branchKey,
                                displayItems: sortedCharts,
                                debugMode: appConfig.debugMode
                            )
                        }
                    }
                    .padding(.vertical, -10)
                }
                .listStyle(.plain)
            }
            .onAppear {
                viewModel.fetchOrganizationCharts()
            }
            .onDisappear {
                viewModel.resetVehicleReservationReports()
            }
            .onChange(of: appConfig.searchBar) { _ in
                searchText = ""
            }
        } else if #available(iOS 15.0, *) {
            if appConfig.debugMode {
                let _ = print("iOS 15+")
            }
            NavigationView {
                List {
                    StickyTitleView(title: "Organization Chart", isScrolled: isScrolled, enableDSDLogo: true)
                        .listRowSeparator(.hidden)
                        .padding(.vertical, -10)
                    if appConfig.searchBar, isScrolled == false {
                        SearchBar(searchText: $searchText)
                            .listRowSeparator(.hidden)
                            .padding(.vertical, -20)
                    }
                    ForEach(sortedBranchKeys, id: \.self) { branchKey in
                        let chartsForBranch = groupedCharts[branchKey] ?? []
                        let filteredCharts = chartsForBranch.filter { chart in
                            searchText.isEmpty ||
                            chart.orgName.localizedCaseInsensitiveContains(searchText) ||
                            chart.orgChinese.localizedCaseInsensitiveContains(searchText) ||
                            chart.orgCode.localizedCaseInsensitiveContains(searchText)
                        }
                        
                        if !filteredCharts.isEmpty {
                            let sortedCharts = filteredCharts.sorted { $0.orderNo > $1.orderNo }
                            GenericGroupView(
                                groupKey: branchKey,
                                displayItems: sortedCharts,
                                debugMode: appConfig.debugMode
                            )
                        }
                    }
                    .padding(.vertical, -10)
                }
                .listStyle(.plain)
            }
            .navigationViewStyle(.stack)
            .onAppear {
                viewModel.fetchOrganizationCharts()
            }
            .onDisappear {
                viewModel.resetVehicleReservationReports()
            }
            .onChange(of: appConfig.searchBar) { _ in
                searchText = ""
            }
        } else {
            if appConfig.debugMode {
                let _ = print("iOS 14+")
            }
            NavigationView {
                VStack {
                    StickyTitleView(title: "Organization Chart", isScrolled: isScrolled, enableDSDLogo: true)
                        .padding(.top, -5)
                        .padding(.horizontal, 20)
                    if appConfig.searchBar, isScrolled == false {
                        SearchBar(searchText: $searchText)
                            .padding(.top, -5)
                            .padding(.horizontal, 20)
                    }
                    List {
                        ForEach(sortedBranchKeys, id: \.self) { branchKey in
                            let chartsForBranch = groupedCharts[branchKey] ?? []
                            let filteredCharts = chartsForBranch.filter { chart in
                                searchText.isEmpty ||
                                chart.orgName.localizedCaseInsensitiveContains(searchText) ||
                                chart.orgChinese.localizedCaseInsensitiveContains(searchText) ||
                                chart.orgCode.localizedCaseInsensitiveContains(searchText)
                            }
                            
                            if !filteredCharts.isEmpty {
                                let sortedCharts = filteredCharts.sorted { $0.orderNo > $1.orderNo }
                                GenericGroupView(
                                    groupKey: branchKey,
                                    displayItems: sortedCharts,
                                    debugMode: appConfig.debugMode
                                )
                            }
                        }
                        .padding(.vertical, -10)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationViewStyle(.stack)
            .onAppear {
                viewModel.fetchOrganizationCharts()
            }
            .onDisappear {
                viewModel.resetVehicleReservationReports()
            }
            .onChange(of: appConfig.searchBar) { _ in
                searchText = ""
            }
        }
    }
}
