//
//  AboutSheetView.swift
//  DSDInfo
//
//  Created by Joe Chan on 24/12/2025.
//

import SwiftUI

struct AboutSheetView: View {
    @EnvironmentObject var appConfig: AppConfig
    @Environment(\.presentationMode) var settingsViewPresentationMode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack() {
                List {
                    StickyTitleView(title: "About", isScrolled: false, enableDSDLogo: false)
                        .listRowSeparator(.hidden)
                        .padding(.vertical, -10)
                    aboutView
                        .dynamicTypeSize(.xSmall ... .xxxLarge)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        ToolbarReturnButton(presentationMode: settingsViewPresentationMode)
                    }
                }
            }
        } else {
            NavigationView {
                List {
                    StickyTitleView(title: "About", isScrolled: false, enableDSDLogo: false)
                        .padding(.vertical, -10)
                    aboutView
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        ToolbarReturnButton(presentationMode: settingsViewPresentationMode)
                    }
                }
                .navigationViewStyle(.stack)
            }
        }
    }
    
    private var aboutView: some View {
        VStack(alignment: .center) {
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

