//
//  InitializeDeviceProfile.swift
//  DSDInfo
//
//  Created by Joe Chan on 02/01/2026.
//

import Foundation
import SwiftUI

func InitializeDeviceProfile() {
//    /* @EnvironmentObject Property Wrapper */
//    @EnvironmentObject var appSettings    : AppSettings    /* System Variables */
//    
//    /* Device */
//    @AppStorage("deviceUUID")        var deviceUUID        = AppSettings.shared.deviceUUID
//    @AppStorage("appVersion")        var appVersion        = AppSettings.shared.appVersion
//    @AppStorage("appBuildNumber")    var appBuildNumber    = AppSettings.shared.appBuildNumber
//    @AppStorage("minimumiOSVersion") var minimumiOSVersion = AppSettings.shared.minimumiOSVersion
//    
//    /* Configurations */
//    @AppStorage("serverEnvironment") var serverEnvironment = AppSettings.shared.serverEnvironment

    if let deviceIdentifier : String = UIDevice.current.identifierForVendor?.uuidString {
        deviceUUID = deviceIdentifier
    } else {
        deviceUUID = "Unknown"
    }
    setStringToSettings(forKey: "device_identifier", keyValue: deviceUUID)

    if let applicationVersion : String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
        appVersion = applicationVersion
    } else {
        appVersion = "Unknown"
    }
    setStringToSettings(forKey: "app_version", keyValue: appVersion)

    if let applicationBuildNumber : String = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
        appBuildNumber = applicationBuildNumber
    } else {
        appBuildNumber = "Unknown"
    }
    setStringToSettings(forKey: "app_build_number", keyValue: appBuildNumber)

    minimumiOSVersion = Bundle.main.minimumOSVersion
    setStringToSettings(forKey: "minimum_ios_version", keyValue: minimumiOSVersion)

    switch Bundle.main.currentEnvironment.rawValue {
        case ServerEnvironmentIdentifier.uat.baseServerEnvironment:
            serverEnvironment = ServerEnvironmentIdentifier.uat
        case ServerEnvironmentIdentifier.development.baseServerEnvironment:
            serverEnvironment = ServerEnvironmentIdentifier.development
        case ServerEnvironmentIdentifier.production.baseServerEnvironment:
            serverEnvironment = ServerEnvironmentIdentifier.production
        default:
            serverEnvironment = ServerEnvironmentIdentifier.production
    }
    setStringToSettings(forKey: "server_environment", keyValue: serverEnvironment.baseServerEnvironment)
    
}
