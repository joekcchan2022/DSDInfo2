//
//  SetUserDefaultsAtRootPlist.swift
//  DSDInfo
//
//  Created by Joe Chan on 02/01/2026.
//

import Foundation

func SetUserDefaultsAtRootPlist() {
    /* Deprecated */
    let deviceIdentifier = UIDevice.current.identifierForVendor?.uuidString
    setStringToSettings(forKey: "device_identifier", keyValue: deviceIdentifier ?? "Unknown")
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    setStringToSettings(forKey: "app_version", keyValue: appVersion ?? "Unknown")
    
    let server_environment = Bundle.main.currentEnvironment.rawValue
    setStringToSettings(forKey: "server_environment", keyValue: server_environment)
    
    let appBuildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    setStringToSettings(forKey: "app_build_number", keyValue: appBuildNumber ?? "Unknown")
    
    let minimumiOSVersion = Bundle.main.minimumOSVersion
    setStringToSettings(forKey: "minimum_ios_version", keyValue: minimumiOSVersion)

}

