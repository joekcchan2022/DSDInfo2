//
//  VehicleReservationView.swift
//  DSDInfo
//
//  Created by Joe Chan on 24/12/2025.
//


import Combine
import SwiftUI

struct VehicleReservationView: View {
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
        // Group vehicle reservation reports by group code
        let groupedReports = Dictionary(grouping: viewModel.vehicleReservationReports) { report -> GroupKey in
            let groupCode = report.groupCode
            let groupName = report.groupName
            return GroupKey(id: groupCode, code: groupCode, name: groupName, chinese: "")
        }
        
        let sortedReportKeys = groupedReports.keys.sorted {
            let firstOrderNo1 = groupedReports[$0]?.first?.orderNo ?? Int.max
            let firstOrderNo2 = groupedReports[$1]?.first?.orderNo ?? Int.max
            return firstOrderNo1 < firstOrderNo2
        }

        if #available(iOS 26.0, *) {
            if appConfig.debugMode {
                let _ = print("iOS 26+")
            }
            NavigationStack {
                List {
                    StickyTitleView(title: "Vehicle Reservation", isScrolled: isScrolled, enableDSDLogo: true)
                        .listRowSeparator(.hidden)
                        .padding(.vertical, -10)
                    if appConfig.searchBar, isScrolled == false {
                        SearchBar(searchText: $searchText)
                            .listRowSeparator(.hidden)
                            .padding(.vertical, -20)
                    }
                    ForEach(sortedReportKeys, id: \.self) { groupKey in
                        let reportsForGroup = groupedReports[groupKey] ?? []
                        let filteredReports = reportsForGroup.filter { report in
                            searchText.isEmpty ||
                            report.vrsCode.localizedCaseInsensitiveContains(searchText) ||
                            report.vrsName.localizedCaseInsensitiveContains(searchText)
                        }
                        
                        if !filteredReports.isEmpty {
                            // Sort reports by order_no
                            let sortedReports = filteredReports.sorted(by: { $0.orderNo > $1.orderNo })
                            GenericGroupView(groupKey: groupKey, displayItems: sortedReports, debugMode: appConfig.debugMode)
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
                viewModel.fetchVehicleReservationReports()
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
                    StickyTitleView(title: "Vehicle Reservation", isScrolled: isScrolled, enableDSDLogo: true)
                        .listRowSeparator(.hidden)
                        .padding(.vertical, -10)
                    if appConfig.searchBar, isScrolled == false {
                        SearchBar(searchText: $searchText)
                            .listRowSeparator(.hidden)
                            .padding(.vertical, -20)
                    }
                    ForEach(sortedReportKeys, id: \.self) { groupKey in
                        let reportsForGroup = groupedReports[groupKey] ?? []
                        let filteredReports = reportsForGroup.filter { report in
                            searchText.isEmpty ||
                            report.vrsCode.localizedCaseInsensitiveContains(searchText) ||
                            report.vrsName.localizedCaseInsensitiveContains(searchText)
                        }
                        
                        if !filteredReports.isEmpty {
                            // Sort reports by order_no
                            let sortedReports = filteredReports.sorted(by: { $0.orderNo > $1.orderNo })
                            GenericGroupView(groupKey: groupKey, displayItems: sortedReports, debugMode: appConfig.debugMode)
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
                viewModel.fetchVehicleReservationReports()
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
                    StickyTitleView(title: "Vehicle Reservation", isScrolled: isScrolled, enableDSDLogo: true)
                        .listRowSeparator(.hidden)
                        .padding(.vertical, -10)
                    if appConfig.searchBar, isScrolled == false {
                        SearchBar(searchText: $searchText)
                            .listRowSeparator(.hidden)
                            .padding(.vertical, -20)
                    }
                    ForEach(sortedReportKeys, id: \.self) { groupKey in
                        let reportsForGroup = groupedReports[groupKey] ?? []
                        let filteredReports = reportsForGroup.filter { report in
                            searchText.isEmpty ||
                            report.vrsCode.localizedCaseInsensitiveContains(searchText) ||
                            report.vrsName.localizedCaseInsensitiveContains(searchText)
                        }
                        
                        if !filteredReports.isEmpty {
                            // Sort reports by order_no
                            let sortedReports = filteredReports.sorted(by: { $0.orderNo > $1.orderNo })
                            GenericGroupView(groupKey: groupKey, displayItems: sortedReports, debugMode: appConfig.debugMode)
                        }
                    }
                    .padding(.vertical, -10)
                }
                .listStyle(.plain)
            }
            .onAppear {
                viewModel.fetchVehicleReservationReports()
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
                    StickyTitleView(title: "Vehicle Reservation", isScrolled: isScrolled, enableDSDLogo: true)
                        .listRowSeparator(.hidden)
                        .padding(.vertical, -10)
                    if appConfig.searchBar, isScrolled == false {
                        SearchBar(searchText: $searchText)
                            .listRowSeparator(.hidden)
                            .padding(.vertical, -20)
                    }
                    ForEach(sortedReportKeys, id: \.self) { groupKey in
                        let reportsForGroup = groupedReports[groupKey] ?? []
                        let filteredReports = reportsForGroup.filter { report in
                            searchText.isEmpty ||
                            report.vrsCode.localizedCaseInsensitiveContains(searchText) ||
                            report.vrsName.localizedCaseInsensitiveContains(searchText)
                        }
                        
                        if !filteredReports.isEmpty {
                            // Sort reports by order_no
                            let sortedReports = filteredReports.sorted(by: { $0.orderNo > $1.orderNo })
                            GenericGroupView(groupKey: groupKey, displayItems: sortedReports, debugMode: appConfig.debugMode)
                        }
                    }
                    .padding(.vertical, -10)
                }
                .listStyle(.plain)
            }
            .navigationViewStyle(.stack)
            .onAppear {
                viewModel.fetchVehicleReservationReports()
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
                    StickyTitleView(title: "Vehicle Reservation", isScrolled: isScrolled, enableDSDLogo: true)
                        .padding(.top, -5)
                        .padding(.horizontal, 20)
                    if appConfig.searchBar, isScrolled == false {
                        SearchBar(searchText: $searchText)
                            .padding(.top, -5)
                            .padding(.horizontal, 20)
                    }
                    List {
                        ForEach(sortedReportKeys, id: \.self) { groupKey in
                            let reportsForGroup = groupedReports[groupKey] ?? []
                            let filteredReports = reportsForGroup.filter { report in
                                searchText.isEmpty ||
                                report.vrsCode.localizedCaseInsensitiveContains(searchText) ||
                                report.vrsName.localizedCaseInsensitiveContains(searchText)
                            }
                            
                            if !filteredReports.isEmpty {
                                // Sort reports by order_no
                                let sortedReports = filteredReports.sorted(by: { $0.orderNo > $1.orderNo })
                                GenericGroupView(groupKey: groupKey, displayItems: sortedReports, debugMode: appConfig.debugMode)
                            }
                        }
                        .padding(.vertical, -10)
                    }
                    .listStyle(.plain)
                }
                .navigationViewStyle(.stack)
                .onAppear {
                    viewModel.fetchVehicleReservationReports()
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
}

