//
//  UserCertificate.swift
//  DSDInfo
//
//  Created by Joe Chan on 8/1/2026.
//

import Foundation
import SwiftUI

typealias UserCertificate = (data: Data, password: String)

extension Bundle {
    func userCertificate(using appConfig: AppConfig) -> UserCertificate? {
        guard let path = Bundle.main.path(forResource: appConfig.mutualAuthenticationCertificateFile, ofType: "pfx"),
              let p12Data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            if appConfig.debugMode {
                let _ = print("\(timestamp()) [Error] \(#function) Certificate \(appConfig.mutualAuthenticationCertificateFile).\(appConfig.mutualAuthenticationCertificateExtension) not loaded. Please make sure the certificate is found in Copy Bundle Resource.")
            }
            return nil
        }
        if appConfig.debugMode {
            let _ = print("\(timestamp()) [Debug] \(#function) Certificate \(appConfig.mutualAuthenticationCertificateFile).\(appConfig.mutualAuthenticationCertificateExtension) is loaded as \(p12Data) with password of \(appConfig.mutualAuthenticationCertificatePassword)")
        }
        return (p12Data, appConfig.mutualAuthenticationCertificatePassword)
    }
}
