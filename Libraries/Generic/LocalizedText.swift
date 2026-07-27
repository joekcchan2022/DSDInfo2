//
//  LocalizedText.swift
//  DSDInfo
//
//  Created by Joe Chan on 22/1/2026.
//

import SwiftUI

struct LocalizedStringText: View {
    let displayText: String

    var body: some View {
        if #available(iOS 16.0, *) {
            Text(LocalizedStringResource(stringLiteral: displayText))
        } else {
            Text(displayText)
        }
    }
}
