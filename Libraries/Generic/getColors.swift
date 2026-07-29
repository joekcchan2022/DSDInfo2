//
//  getColors.swift
//  DSDInfo
//
//  Created by Joe Chan on 30/1/2026.
//

import SwiftUI

func getColors(for contrast: Double, theme: ColorTheme) -> (backgroundColor: Color, foregroundColor: Color) {
    switch theme {
    case .blue:
        switch Int(contrast) {
        case 100: return (Color("DSD Blue 100%"), Color(UIColor.systemGroupedBackground))
        case 75: return (Color("DSD Blue 87.5%"), Color(UIColor.systemGroupedBackground))
        case 50: return (Color("DSD Blue 75%"), Color(UIColor.systemGroupedBackground))
        case 25: return (Color("DSD Blue 62.5%"), Color(UIColor.systemGroupedBackground))
        case 0:  return (Color("DSD Blue 50%"), Color(UIColor.systemGroupedBackground))
        default: return (Color("DSD Blue 75%"), Color(UIColor.systemGroupedBackground))
        }
        
    case .normal:
        switch Int(contrast) {
        case 100: return (Color(.secondaryLabel), Color(UIColor.systemGroupedBackground))
        case 75: return (Color(.secondaryLabel), Color(UIColor.systemGroupedBackground))
        case 50: return (Color(.tertiaryLabel), Color(UIColor.systemGroupedBackground))
        case 25: return (Color(.tertiaryLabel), Color(UIColor.label))
        case 0:  return (Color(.quaternaryLabel), Color(UIColor.label))
        default: return (Color(.tertiaryLabel), Color(UIColor.systemGroupedBackground))
        }
    }
}
