//
//  DSDInfo2App.swift
//  Shared
//
//  Created by Joe Chan on 16/9/2022.
//

import SwiftUI
import Foundation

@main
struct DSDInfo2App: App {
    @StateObject var serviceData = ServiceData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(serviceData)
        }
    }
}
