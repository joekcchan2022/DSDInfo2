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
    @State var showLaunchScreen = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                LaunchScreenView()
                    .opacity(showLaunchScreen ? 1 : 0)
                    .animation(.easeInOut(duration: 0.5))
                
                ContentView()
                    .environmentObject(serviceData)
                    .opacity(showLaunchScreen ? 0 : 1)
                    .animation(.easeInOut(duration: 0.5))
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    withAnimation {
                        showLaunchScreen = false
                    }
                }
            }
        }
    }
}
