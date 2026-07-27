//
//  URLSessionClientCertificateHandling.swift
//  DSDInfo
//
//  Created by Joe Chan on 8/1/2026.
//

import Foundation
import SwiftUI

/* See https://github.com/MarcoEidinger/ClientCertificateSwiftDemo */
public class URLSessionClientCertificateHandling: NSObject, URLSessionDelegate {
    private let appConfig: AppConfig

    init(appConfig: AppConfig) {
        self.appConfig = appConfig
    }

    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodClientCertificate else {
            completionHandler(.performDefaultHandling, nil)
            return
        }

        // Get the userCertificate using the appConfig
        guard let credential = urlCredential(for: Bundle.main.userCertificate(using: appConfig)) else {
            completionHandler(.performDefaultHandling, nil)
            return
        }

        challenge.sender?.use(credential, for: challenge)
        completionHandler(.useCredential, credential)
    }

    func urlCredential(for userCertificate: UserCertificate?) -> URLCredential? {
        guard let userCertificate = userCertificate else { return nil }

        let p12Contents = PKCS12(pkcs12Data: userCertificate.data, password: userCertificate.password)

        guard let identity = p12Contents.identity else {
            return nil
        }

        return URLCredential(identity: identity,
                             certificates: nil,
                             persistence: .none)
    }
}
