//
//  ServerEnvironment.swift
//  DSDInfo
//
//  Created by Joe Chan on 2/1/2026.
//

import Foundation

enum ServerEnvironment: String, CaseIterable {
    case uat = "UAT"
    case production = "Production"
    case development = "Development"
    
    var displayName: String {
        switch self {
        case .uat: return "UAT"
        case .production: return "Production"
        case .development: return "Development"
        }
    }
}
