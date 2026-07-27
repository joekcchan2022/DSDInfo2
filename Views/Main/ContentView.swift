//
//  ContentView.swift
//  DSDInfo
//
//  Created by Joe Chan on 24/12/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appConfig: AppConfig
    @SceneStorage("selectedTab") private var selectedTab = Tab.organizationChart
    
    var body: some View {
        if #available(iOS 26.0, *) {
            TabView(selection: $selectedTab) {
                OrganizationChartView(config: appConfig)
                    .tabItem {
                        Image(systemName: systemImageWithFallback(for: "globe"))
                            .foregroundColor(Color(UIColor.systemFill))
                        Text("Organization Chart")
                    }
                    .tag(Tab.organizationChart)
                VehicleReservationView(config: appConfig)
                    .tabItem {
                        Image(systemName: systemImageWithFallback(for: "bolt.car.circle.fill"))
                            .foregroundColor(Color(UIColor.systemFill))
                        Text("Vehicle Reservation")
                    }
                    .tag(Tab.vehicleReservation)
                SettingsView()
                    .tabItem {
                        Image(systemName: systemImageWithFallback(for: "gear.circle.fill"))
                            .foregroundColor(Color(UIColor.systemFill))
                        Text("Settings")
                    }
                    .tag(Tab.settings)
            }
            .tabViewStyle(.sidebarAdaptable) // Apply Liquid Glass style
            .tabBarMinimizeBehavior(.onScrollDown) // Make the tab bar minimize when scrolling down
            .accentColor(Color("DSD Blue 100%"))
            
        } else {
            TabView(selection: $selectedTab) {
                OrganizationChartView(config: appConfig)
                    .tabItem {
                        Image(systemName: systemImageWithFallback(for: "globe"))
                            .foregroundColor(Color(UIColor.systemFill))
                        Text("Organization Chart")
                    }
                    .tag(Tab.organizationChart)
                VehicleReservationView(config: appConfig)
                    .tabItem {
                        Image(systemName: systemImageWithFallback(for: "bolt.car.circle.fill"))
                            .foregroundColor(Color(UIColor.systemFill))
                        Text("Vehicle Reservation")
                    }
                    .tag(Tab.vehicleReservation)
                SettingsView()
                    .tabItem {
                        Image(systemName: systemImageWithFallback(for: "gear.circle.fill"))
                            .foregroundColor(Color(UIColor.systemFill))
                        Text("Settings")
                    }
                    .tag(Tab.settings)
            }
            .accentColor(Color("DSD Blue 100%"))
        }
    }
}
