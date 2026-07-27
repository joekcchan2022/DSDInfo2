//
//  systemImageWithFallback.swift
//  DSDInfo
//
//  Created by Joe Chan on 29/1/2026.
//

import Foundation
import SwiftUI

func systemImageWithFallback(for name: String, fallbackIcon: String? = nil) -> String {
    if let _ = UIImage(systemName: name) {
        return name
    } else if let fallbackIcon = fallbackIcon, let _ = UIImage(systemName: fallbackIcon) {
        return fallbackIcon
    } else {
        return "circle.dotted" 
    }
}
