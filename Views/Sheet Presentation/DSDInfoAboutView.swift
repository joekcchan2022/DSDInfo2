//
//  DSDInfoAboutView.swift
//  DSDInfo
//
//  Created by Joe Chan on 24/12/2025.
//

import SwiftUI

struct DSDInfoAboutView: View {
    @EnvironmentObject var appConfig: AppConfig
    @Environment(\.colorScheme) var colorScheme
    @State private var settingsView: Bool = false
    @State private var showingSettingsViewSheet: Bool = false
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack() {
                ScrollView {
                    StickyTitleView(title: "About", isScrolled: false, enableDSDLogo: false)
                        .padding(.horizontal, 20)
                    aboutView.dynamicTypeSize(.xSmall ... .xxxLarge)
                }
            }
        } else {
            NavigationView {
                ScrollView {
                    StickyTitleView(title: "About", isScrolled: false, enableDSDLogo: false)
                        .padding(.horizontal, 20)
                    aboutView
                }
            }
            .navigationViewStyle(.stack)
        }
    }
    
    
    private var aboutView: some View {
        VStack {
            Image(colorScheme == .light ? "DSDInfo Light" : colorScheme == .dark ? "DSDInfo Dark" : "DSDInfo Tinted")
                .resizable()
                .frame(width: 128, height: 128)
                .cornerRadius(16)
            Spacer()
            Spacer()
            Text("DSDInfo")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color("DSD Blue 100%"))
            Spacer()
            Spacer()
            Spacer()
            Text("Version: \(Bundle.main.shortVersion)")
                .font(.callout)
            Spacer()
            Text("Build: \(Bundle.main.buildVersion)")
                .font(.callout)
            Spacer()
            Text("Minimum iOS Version: \(Bundle.main.minimumOSVersion)")
                .font(.callout)
            Spacer()
            if #available(iOS 15.0, *) {
                Text("Date: \(Bundle.main.buildDate.self.formatted(date: .complete, time: .omitted))")
                    .font(.callout)
                Spacer()
            } else {
                // Fallback on earlier versions
            }
            Text("Server Environment: \(appConfig.serverEnvironment.displayName)")
                .font(.callout)
            Spacer()
            Spacer()
            Divider()
            Spacer()
            Spacer()
            if #available(iOS 16.0, *) {
                displayGenericIconStringToggle(icon: "gear.circle.fill", title: "Settings", toggleSwitch: $settingsView)
                    .onChange(of: settingsView) { newValue in
                        if newValue {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                showingSettingsViewSheet.toggle()
                            }
                        }
                    }
                    .onChange(of: showingSettingsViewSheet) { newValue in
                        if !showingSettingsViewSheet {
                            settingsView = false
                        }
                    }
                    .dynamicTypeSize(.xSmall ... .xxxLarge)
                    .tint(Color("DSD Blue 100%"))
                    .onAppear {
                        saveRootPlist()
                    }
                    .sheet(isPresented: $showingSettingsViewSheet) {
                        SettingsView()
                    }
            } else {
                displayGenericIconStringToggle(icon: "gear.circle.fill", title: "Settings", toggleSwitch: $settingsView)
                    .onChange(of: settingsView) { newValue in
                        if newValue {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                showingSettingsViewSheet.toggle()
                            }
                        }
                    }
                    .onChange(of: showingSettingsViewSheet) { newValue in
                        if !showingSettingsViewSheet {
                            settingsView = false
                        }
                    }
                    .onAppear {
                        saveRootPlist()
                    }
                    .sheet(isPresented: $showingSettingsViewSheet) {
                        SettingsView()
                    }
            }
        }
    }
    
    private func saveRootPlist() {
        UserDefaults.standard.set(UIDevice.current.identifierForVendor?.uuidString ?? "Unknown", forKey: "device_identifier")
        UserDefaults.standard.set(Bundle.main.shortVersion, forKey: "app_version")
        UserDefaults.standard.set(appConfig.serverEnvironment.displayName, forKey: "server_environment")
        UserDefaults.standard.set(Bundle.main.buildVersion, forKey: "app_build_number")
        UserDefaults.standard.set(Bundle.main.minimumOSVersion, forKey: "minimum_ios_version")
        let appleDeveloperRSSFeedParser = RSSParser()
        if let appleDeveloperRSSFeedURL = URL(string: appConfig.appleDeveloperRss) {
            appleDeveloperRSSFeedParser.parseFeed(url: appleDeveloperRSSFeedURL) { feed in
                var latestiOSReleases = ""
                var latestiPadOSReleases = ""

                for item in feed {
                    if let title = item["title"] {
                        let titleString = unwrapString(title)
                        if title.starts(with: "iOS") {
                            latestiOSReleases += latestiOSReleases.isEmpty ? titleString : "\n\(titleString)"
                        } else if title.starts(with: "iPadOS") {
                            latestiPadOSReleases += latestiPadOSReleases.isEmpty ? titleString : "\n\(titleString)"
                        }
                    }
                }
                UserDefaults.standard.set(latestiOSReleases, forKey: "latest_ios_version")
                UserDefaults.standard.set(latestiPadOSReleases, forKey: "latest_ipados_version")
            }
        }
    }
    
    private func displayGenericIconStringToggle(icon: String, title: String, toggleSwitch: Binding<Bool>) -> some View {
        return Toggle(isOn: toggleSwitch) {
            HStack {
                Image(systemName: systemImageWithFallback(for: icon))
                    .font(.title)
                Text(title)
                    .font(.body)
            }
        }
        .padding(.horizontal)
    }
}


#Preview {
    DSDInfoAboutView()
}
