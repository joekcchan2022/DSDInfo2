//
//  DSDInfoApp.swift
//  DSDInfo
//
//  Created by Joe Chan on 9/12/2025.
//

import SwiftUI

@main
struct DSDInfoApp: App {
    @State var showLaunchScreen = true
    @StateObject var appConfig = AppConfig()

    var body: some Scene {
        WindowGroup {
            ZStack {
                LaunchScreenView()
                    .opacity(showLaunchScreen ? 1 : 0)
                    .animation(.easeInOut(duration: 2))
                ContentView()
                    .opacity(showLaunchScreen ? 0 : 1)
                    .animation(.easeInOut(duration: 1))
                    .environmentObject(appConfig) 
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        showLaunchScreen = false
                    }
                }
            }
        }
    }
}

