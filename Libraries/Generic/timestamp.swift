//
//  timestamp.swift
//  DSDInfo
//
//  Created by Joe Chan on 2/1/2026.
//

import Foundation

/* See https://developer.apple.com/documentation/foundation/dateformatter */
func timestamp() -> String {
    let dateFormat = DateFormatter()
    dateFormat.locale = Locale(identifier: "en_US_POSIX")
    dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
    return String(format: "%@", dateFormat.string(from: Date()))
}
