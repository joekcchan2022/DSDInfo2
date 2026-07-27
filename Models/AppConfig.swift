//
//  AppConfig.swift
//  DSDInfo
//
//  Created by Joe Chan on 10/12/2025.
//

import Foundation
import SwiftUI

class AppConfig: ObservableObject {
    @AppStorage("appleDeveloperRss") var appleDeveloperRss: String = ""
    @AppStorage("baseApiUrl") var baseApiUrl: String = ""
    @AppStorage("contrast") var contrast: Double = 50.0
    @AppStorage("debugMode") var debugMode: Bool = false
    @AppStorage("developerView") var developerView: Bool = false
    @AppStorage("developmentMode") var developmentMode: Bool = false
    @AppStorage("documentViewer") var documentViewer: DocumentViewer = .pdfkit
    @AppStorage("domainName") var domainName: String = ""
    @AppStorage("enableChinese") var enableChinese: Bool = false
    @AppStorage("enableMutualAuthentication") var enableMutualAuthentication: Bool = false
    @AppStorage("enableSheetPresentation") var enableSheetPresentation: Bool = true
    @AppStorage("environment") private var environmentRaw: String = ServerEnvironment.uat.rawValue
    @AppStorage("mutualAuthenticationCertificateFile") var mutualAuthenticationCertificateFile: String = ""
    @AppStorage("mutualAuthenticationCertificateExtension") var mutualAuthenticationCertificateExtension: String = ""
    @AppStorage("mutualAuthenticationCertificatePassword") var mutualAuthenticationCertificatePassword: String = ""
    @AppStorage("organizationChartApiPath") var organizationChartApiPath: String = ""
    @AppStorage("searchBar") var searchBar: Bool = false
    @AppStorage("vehicleReservationReportsApiPath") var vehicleReservationReportsApiPath: String = ""
    
    var serverEnvironment: ServerEnvironment {
        get { ServerEnvironment(rawValue: environmentRaw) ?? .uat }
        set {
            environmentRaw = newValue.rawValue
            // When environment changes, reload values from the plist for that environment
            loadEnvironmentSpecificConfig(for: newValue)
        }
    }
    
    init() {
        // On first launch or when values are empty, load defaults from Config.plist
        loadInitialConfigIfNeeded()
    }
        
    private func loadInitialConfigIfNeeded() {
        // Only load from plist if no values have been saved yet (e.g., first launch)
        guard baseApiUrl.isEmpty && mutualAuthenticationCertificateFile.isEmpty else { return }
        
        let defaultEnv = serverEnvironment
        loadEnvironmentSpecificConfig(for: defaultEnv)
        loadGlobalConfig()
        saveRootPlist()
    }
    
    private func saveRootPlist() {
        let deviceIdentifier = UIDevice.current.identifierForVendor?.uuidString
        UserDefaults.standard.set(deviceIdentifier ?? "Unknown", forKey: "device_identifier")
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        UserDefaults.standard.set(appVersion ?? "Unknown", forKey: "app_version")

        UserDefaults.standard.set(serverEnvironment == .production ? "Production" : serverEnvironment == .uat ? "Uat" : "Development", forKey: "server_environment")
        
        let appBuildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        UserDefaults.standard.set(appBuildNumber ?? "N/A", forKey: "app_build_number")
        
        let minimumiOSVersion = Bundle.main.minimumOSVersion
        UserDefaults.standard.set(minimumiOSVersion, forKey: "minimum_ios_version")
        
        let appleDeveloperRSSFeedParser = RSSParser()
        
        if let appleDeveloperRSSFeedURL = URL(string: appleDeveloperRss) {
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
    
    private func loadGlobalConfig() {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let config = NSDictionary(contentsOfFile: path) as? [String: Any],
              let globalConfig = config["Global"] as? [String: Any] else {
            print("[AppConfig] Failed to load global configuration.")
            return
        }
        
        appleDeveloperRss = globalConfig["appleDeveloperRss"] as? String ?? appleDeveloperRss
        contrast = globalConfig["contrast"] as? Double ?? contrast
        debugMode = globalConfig["debugMode"] as? Bool ?? debugMode
        developmentMode = globalConfig["developmentMode"] as? Bool ?? developmentMode
        developerView = globalConfig["developerView"] as? Bool ?? developerView
        documentViewer = globalConfig["documentViewer"] as? DocumentViewer ?? .pdfkit
        domainName = globalConfig["domainName"] as? String ?? domainName
        enableChinese = globalConfig["enableChinese"] as? Bool ?? enableChinese
        enableMutualAuthentication = globalConfig["enableMutualAuthentication"] as? Bool ?? enableMutualAuthentication
        enableSheetPresentation = globalConfig["enableSheetPresentation"] as? Bool ?? enableSheetPresentation
        organizationChartApiPath = globalConfig["organizationChartApiPath"] as? String ?? organizationChartApiPath
        searchBar = globalConfig["searchBar"] as? Bool ?? searchBar
        serverEnvironment = globalConfig["serverEnvironment"] as? String == "production" ? .production : globalConfig["serverEnvironment"] as? String == "uat" ? .uat : .development
        vehicleReservationReportsApiPath = globalConfig["vehicleReservationReportsApiPath"] as? String ?? vehicleReservationReportsApiPath
    }
    
    private func loadEnvironmentSpecificConfig(for serverEnvironment: ServerEnvironment) {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let config = NSDictionary(contentsOfFile: path) as? [String: Any],
              let envConfig = config[serverEnvironment.rawValue] as? [String: Any] else {
            print("[AppConfig] Failed to load configuration for \(serverEnvironment.rawValue).")
            return
        }
        
        baseApiUrl = envConfig["baseApiUrl"] as? String ?? baseApiUrl
        mutualAuthenticationCertificateFile = envConfig["mutualAuthenticationCertificateFile"] as? String ?? mutualAuthenticationCertificateFile
        mutualAuthenticationCertificateExtension = envConfig["mutualAuthenticationCertificateExtension"] as? String ?? mutualAuthenticationCertificateExtension
        mutualAuthenticationCertificatePassword = envConfig["mutualAuthenticationCertificatePassword"] as? String ?? mutualAuthenticationCertificatePassword
    }
    
    func switchToEnvironment(_ newServerEnvironment: ServerEnvironment) {
        guard newServerEnvironment != serverEnvironment else { return }
        serverEnvironment = newServerEnvironment
        UserDefaults.standard.set(serverEnvironment == .production ? "Production" : serverEnvironment == .uat ? "UAT" : "Development", forKey: "server_environment")
    }
    
    func reloadAllConfig() {
        loadGlobalConfig()
        loadEnvironmentSpecificConfig(for: serverEnvironment)
    }
}


