//
//  calculateTopPadding.swift
//  DSDInfo
//
//  Created by Joe Chan on 30/1/2026.
//

import SwiftUI

func calculateTopPadding() -> CGFloat {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.sizeCategory) var sizeCategory

    if (horizontalSizeClass == .compact && verticalSizeClass == .compact) || // iPhone
        (horizontalSizeClass == .regular && verticalSizeClass == .compact) || // iPhone Max
        (horizontalSizeClass == .regular && verticalSizeClass == .regular) { // iPad
        // For landscape orientation
        switch sizeCategory {
        case .extraExtraLarge:
            return 20
        case .extraLarge:
            return 15
        case .large:
            return 10
        case .medium:
            return 5
        default:
            return 0
        }
    } else {
        return 0
    }
}
