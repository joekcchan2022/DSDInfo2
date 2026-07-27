//
//  SettingsView.swift
//  DSDInfo
//
//  Created by Joe Chan on 7/1/2026.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appConfig: AppConfig
    @State private var resetConfiguration: Bool = false
    @State private var isScrolled: Bool = false
    @State private var result = ""
    private let enterScrolledThreshold: CGFloat = 24
    private let exitScrolledThreshold:  CGFloat = 8
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                List {
                    StickyTitleView(title: "Settings", isScrolled: isScrolled, enableDSDLogo: true)
                        .listRowSeparator(.hidden)
                        .padding(.vertical, -10)
                    settingsView
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
        } else if #available(iOS 15.0, *) {
            NavigationView {
                List {
                    StickyTitleView(title: "Settings", isScrolled: isScrolled, enableDSDLogo: true)
                        .listRowSeparator(.hidden)
                        .padding(.vertical, -10)
                    settingsView
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            .navigationViewStyle(.stack)
        } else {
            NavigationView {
                List {
                    StickyTitleView(title: "Settings", isScrolled: isScrolled, enableDSDLogo: true)
                        .padding(.vertical, -10)
                    settingsView
                }
                .listStyle(.plain)
            }
            .navigationViewStyle(.stack)
        }
    }
    
    private var settingsView: some View {
        ScrollView {
            if #available(iOS 16.0, *) {
                displayGenericIconStringToggle(icon: "magnifyingglass.circle.fill", title: "Search Bar", toggleSwitch: $appConfig.searchBar)
                    .dynamicTypeSize(.xSmall ... .xxxLarge)
                    .tint(Color("DSD Blue 100%"))
            } else if #available(iOS 15.0, *) {
                displayGenericIconStringToggle(icon: "magnifyingglass.circle.fill", title: "Search Bar", toggleSwitch: $appConfig.searchBar)
            } else {
                displayGenericIconStringToggle(icon: "magnifyingglass.circle.fill", title: "Search Bar", toggleSwitch: $appConfig.searchBar)
                    .disabled(true)
                Text("Feature not available on this version of iOS.")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            Divider()
            if #available(iOS 16.0, *) {
                displayGenericIconStringToggle(icon: systemImageWithFallback(for: "character.circle.fill", fallbackIcon: "a.circle.fill"), title: "Chinese Name", toggleSwitch: $appConfig.enableChinese)
                    .dynamicTypeSize(.xSmall ... .xxxLarge)
                    .tint(Color("DSD Blue 100%"))
            } else {
                displayGenericIconStringToggle(icon: systemImageWithFallback(for: "character.circle.fill", fallbackIcon: "a.circle.fill"), title: "Chinese Name", toggleSwitch: $appConfig.enableChinese)
                    .disabled(true)
                Text("Feature not available on this version of iOS.")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            Divider()
            if #available(iOS 16.0, *) {
                displayGenericIconStringSliderHStack(icon: "circle.lefthalf.filled", title: "Contrast", sliderSwitch: $appConfig.contrast)
                    .dynamicTypeSize(.xSmall ... .xxxLarge)
            } else {
                displayGenericIconStringSliderHStack(icon: "circle.lefthalf.filled", title: "Contrast", sliderSwitch: $appConfig.contrast)
            }
            Divider()
            if #available(iOS 16.0, *) {
                displayGenericIconStringToggle(icon: "viewfinder.circle.fill", title: "Sheet Presentation", toggleSwitch: $appConfig.enableSheetPresentation)
                    .dynamicTypeSize(.xSmall ... .xxxLarge)
                    .tint(Color("DSD Blue 100%"))
                if appConfig.enableSheetPresentation {
                    Text("Disable if crash persists.")
                        .font(.footnote)
                        .dynamicTypeSize(.xSmall ... .xxxLarge)
                        .foregroundColor(Color(.secondaryLabel))
                }
            } else {
                displayGenericIconStringToggle(icon: "viewfinder.circle.fill", title: "Sheet Presentation", toggleSwitch: $appConfig.enableSheetPresentation)
                Text("Enable Sheet Presentation for better user experience on this version of iOS.")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
                if appConfig.enableSheetPresentation {
                    Text("Disable if crash persists.")
                        .font(.footnote)
                        .foregroundColor(Color(.secondaryLabel))
                }
            }
            Divider()
            if #available(iOS 16.0, *) {
                displayGenericIconStringToggle(icon: systemImageWithFallback(for: "pencil.tip.crop.circle.fill", fallbackIcon: "pencil.circle.fill"), title: "Development Mode", toggleSwitch: $appConfig.developmentMode)
                    .dynamicTypeSize(.xSmall ... .xxxLarge)
                    .tint(Color("DSD Blue 100%"))
            } else {
                displayGenericIconStringToggle(icon: systemImageWithFallback(for: "pencil.tip.crop.circle.fill", fallbackIcon: "pencil.circle.fill"), title: "Development Mode", toggleSwitch: $appConfig.developmentMode)
            }
            Divider()
            if appConfig.developmentMode {
                DocumentViewerSwitch()
                Divider()
                ServerEnvironmentSwitch()
                if #available(iOS 16.0, *) {
                    displayGenericTwoStringsHStack(icon: "", firstString: "Base URL", secondString: appConfig.baseApiUrl)
                        .dynamicTypeSize(.xSmall ... .xxxLarge)
                    Divider()
                    displayGenericIconStringToggle(icon: "lock.circle.fill", title: "Mutual Authentication", toggleSwitch: $appConfig.enableMutualAuthentication)
                        .dynamicTypeSize(.xSmall ... .xxxLarge)
                        .tint(Color("DSD Blue 100%"))
                        .disabled(appConfig.documentViewer == .webview)
                    if appConfig.documentViewer == .webview {
                        Text("Feature not available on WebView.")
                            .font(.footnote)
                            .foregroundColor(Color(.secondaryLabel))
                    }
                    if appConfig.enableMutualAuthentication {
                        displayGenericTwoStringsHStack(icon: "", firstString: "Certificate", secondString: appConfig.mutualAuthenticationCertificateFile)
                        displayGenericTwoStringsHStack(icon: "", firstString: "Extension", secondString: appConfig.mutualAuthenticationCertificateExtension)
                        if appConfig.debugMode {
                            let _ = print("\(timestamp()) [Debug] \(#function) Certificate \(appConfig.mutualAuthenticationCertificateFile) is loaded with password \(appConfig.mutualAuthenticationCertificatePassword).")
                        }
                    }
                    Divider()
                    displayGenericIconStringToggle(icon: systemImageWithFallback(for: "ladybug.slash.circle.fill", fallbackIcon: "ant.circle.fill"), title: "Debug Mode", toggleSwitch: $appConfig.debugMode)
                        .dynamicTypeSize(.xSmall ... .xxxLarge)
                        .tint(Color("DSD Blue 100%"))
                    Divider()
                    displayGenericIconStringToggle(icon: "hammer.circle.fill", title: "Developer View", toggleSwitch: $appConfig.developerView)
                        .dynamicTypeSize(.xSmall ... .xxxLarge)
                        .tint(Color("DSD Blue 100%"))
                    if appConfig.developerView {
                        displayGenericTwoStringsHStack(icon: "", firstString: "Result", secondString: result)
                            .task {
                                await loadRequest()
                            }
                    }
                    Divider()
                    displayGenericIconStringToggle(icon: "restart.circle.fill", title: "Reset Configurations", toggleSwitch: $resetConfiguration)
                        .dynamicTypeSize(.xSmall ... .xxxLarge)
                        .tint(Color("DSD Blue 100%"))
                        .onChange(of: resetConfiguration) { newValue in
                            if newValue {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                    appConfig.reloadAllConfig()
                                    resetConfiguration = false
                                }
                            }
                        }
                } else {
                    displayGenericTwoStringsHStack(icon: "doc.circle.fill", firstString: "Base URL", secondString: appConfig.baseApiUrl)
                    Divider()
                    displayGenericIconStringToggle(icon: "lock.circle.fill", title: "Mutual Authentication", toggleSwitch: $appConfig.enableMutualAuthentication)
                        .disabled(appConfig.documentViewer == .webview)
                    if appConfig.documentViewer == .webview {
                        Text("Feature not available on WebView.")
                            .font(.footnote)
                            .foregroundColor(Color(.secondaryLabel))
                    }
                    if appConfig.enableMutualAuthentication {
                        displayGenericTwoStringsHStack(icon: "", firstString: "Certificate", secondString: appConfig.mutualAuthenticationCertificateFile)
                        displayGenericTwoStringsHStack(icon: "", firstString: "Extension", secondString: appConfig.mutualAuthenticationCertificateExtension)
                        if appConfig.debugMode {
                            let _ = print("\(timestamp()) [Debug] \(#function) Certificate \(appConfig.mutualAuthenticationCertificateFile) is loaded with password \(appConfig.mutualAuthenticationCertificatePassword).")
                        }
                    }
                    Divider()
                    displayGenericIconStringToggle(icon: systemImageWithFallback(for: "ladybug.slash.circle.fill", fallbackIcon: "ant.circle.fill"), title: "Debug Mode", toggleSwitch: $appConfig.debugMode)
                    Divider()
                    displayGenericTwoStringsHStack(icon: "", firstString: "Base URL", secondString: appConfig.baseApiUrl)
                    Divider()
                    displayGenericIconStringToggle(icon: "hammer.circle.fill", title: "Developer View", toggleSwitch: $appConfig.developerView)
                    if appConfig.developerView {
                        displayGenericTwoStringsHStack(icon: "", firstString: "Result", secondString: result)
                    }
                    Divider()
                    displayGenericIconStringToggle(icon: "restart.circle.fill", title: "Reset Configurations", toggleSwitch: $resetConfiguration)
                        .onChange(of: resetConfiguration) { newValue in
                            if newValue {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                    appConfig.reloadAllConfig()
                                    resetConfiguration = false
                                }
                            }
                        }
                }
            }
        }
        .onChange(of: appConfig.serverEnvironment) { _ in
            Task { await loadRequest()}
        }
        .onChange(of: appConfig.enableMutualAuthentication) { _ in
            Task { await loadRequest()}
        }
        .onDisappear {
            self.result = ""
        }
    }

    private func displayGenericIconStringSliderHStack(icon: String, title: String, sliderSwitch: Binding<Double>) -> some View {
        return HStack {
            HStack {
                Image(systemName: systemImageWithFallback(for: icon))
                    .font(.title)
                Text(title)
                    .font(.body)
            }
            Spacer()
            Slider(value: sliderSwitch, in: 0...100, step: 25)
                .padding(.leading, 10)
        }
        .padding(.horizontal, 5)
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
        .padding(.horizontal, 5)
    }

    private func displayGenericTwoStringsHStack(icon: String, firstString: String, secondString: String) -> some View {
        return HStack {
            HStack {
                if !icon.isEmpty {
                    Image(systemName: systemImageWithFallback(for: icon))
                        .font(.title)
                }
                Text(firstString)
                    .font(.body)
                    .lineLimit(1)
            }
            Spacer()
            Text(secondString)
                .font(.body)
                .lineLimit(1)
                .foregroundColor(Color(.secondaryLabel))
        }
        .padding(.horizontal, 5)
    }
                
    private func ServerEnvironmentSwitch() -> some View {
        return VStack {
            if #available(iOS 16.0, *) {
                displayGenericTwoStringsHStack(icon: "icloud.circle.fill", firstString: "Server Environment", secondString: appConfig.serverEnvironment.displayName)
                    .dynamicTypeSize(.xSmall ... .xxxLarge)
                serverEnvironmentPicker()
                    .dynamicTypeSize(.xSmall ... .xxxLarge)
            } else {
                displayGenericTwoStringsHStack(icon: "icloud.circle.fill", firstString: "Server Environment", secondString: appConfig.serverEnvironment.displayName)
                serverEnvironmentPicker()
            }
        }
    }
        
    private func serverEnvironmentPicker() -> some View {
        return Picker("", selection: $appConfig.serverEnvironment) {
            ForEach(ServerEnvironment.allCases, id: \.self) { environment in
                Text(environment.displayName)
                    .font(.body)
                    .lineLimit(1)
                    .tag(environment)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: appConfig.serverEnvironment) { newEnvironment in
            UserDefaults.standard.set(newEnvironment.rawValue, forKey: "server_environment")
        }
        .padding(.horizontal, 5)
    }
    
    private func DocumentViewerSwitch() -> some View {
        return VStack {
            if #available(iOS 16.0, *) {
                displayGenericTwoStringsHStack(icon: "doc.circle.fill", firstString: "Document Viewer", secondString: appConfig.documentViewer.displayName)
                    .dynamicTypeSize(.xSmall ... .xxxLarge)
                documentViewerPicker()
                    .dynamicTypeSize(.xSmall ... .xxxLarge)
                    .onChange(of: appConfig.documentViewer) { _ in
                       if appConfig.documentViewer == .webview {
                           appConfig.enableMutualAuthentication = false
                        }
                    }
            } else {
                displayGenericTwoStringsHStack(icon: "doc.circle.fill", firstString: "Document Viewer", secondString: appConfig.documentViewer.displayName)
                documentViewerPicker()
                    .onChange(of: appConfig.documentViewer) { _ in
                       if appConfig.documentViewer == .webview {
                           appConfig.enableMutualAuthentication = false
                        }
                    }
            }
        }
    }
            
    private func documentViewerPicker() -> some View {
        return Picker("", selection: $appConfig.documentViewer) {
            ForEach(DocumentViewer.allCases, id: \.self) { viewer in
                Text(viewer.displayName)
                    .font(.body)
                    .lineLimit(1)
                    .tag(viewer)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal, 5)
    }
    
    private func loadRequest() async {
        let urlPath = "\(appConfig.baseApiUrl)/?device_uuid=\(UIDevice.current.identifierForVendor!.uuidString)"
        do {
            self.result = try await sendHTTPRequest(url: URL(string: urlPath)!)
        } catch {
            self.result = "Error: \(error.localizedDescription)"
        }
    }
    
    private func sendHTTPRequest(url: URL) async throws -> String {
        let session = URLSession(configuration: .default, delegate: URLSessionClientCertificateHandling(appConfig: appConfig), delegateQueue: nil)
        do {
            if #available(iOS 15.0, *) {
                let (data, response) = try await session.data(from: url)
                guard let httpResponse = response as? HTTPURLResponse else { return "" }
                return "HTTP Status Code \(httpResponse.statusCode), Data Length: \(data.count)"
            } else {
                return "iOS 15.0 or later is needed."
            }
        } catch {
            return "Error: \(error.localizedDescription)"
        }
    }

}
