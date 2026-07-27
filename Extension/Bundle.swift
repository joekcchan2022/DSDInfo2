//
//  Bundle.swift
//  DSDInfo
//
//  Created by Joe Chan on 31/12/2025.
//

import Foundation

extension Bundle {

    var shortVersion: String {
        if let result = infoDictionary?["CFBundleShortVersionString"] as? String {
            return result
        } else {
            assert(false)
            return ""
        }
    }

    var buildVersion: String {
        if let result = infoDictionary?["CFBundleVersion"] as? String {
            return result
        } else {
            assert(false)
            return ""
        }
    }

    var minimumOSVersion: String {
        if let result = infoDictionary?["MinimumOSVersion"] as? String {
            return result
        } else {
            assert(false)
            return ""
        }
    }

    var buildDate: Date {

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let infoPath = Bundle.main.path(forResource: "Info", ofType: "plist"),
            let infoAttr = try? FileManager.default.attributesOfItem(atPath: infoPath),
            let infoDate = infoAttr[.modificationDate] as? Date {
                return infoDate
        }
        return Date()
    }

    var currentEnvironment: ServerEnvironment {
        if let env = UserDefaults.standard.string(forKey: "server_environment") {
            return ServerEnvironment(rawValue: env.lowercased()) ?? ServerEnvironment.production
        }
        return ServerEnvironment.production
    }

}
