//
//  AccountsDemoApp.swift
//  AccountsDemo
//
//  Created by SD on 06/12/23.
//

import SwiftUI

@main
struct AccountsDemoApp: App {
    @StateObject private var settings = Settings()
    var body: some Scene {
        WindowGroup {
            ApplicationSwitcher()
                .environmentObject(settings)
                .animation(.default, value: settings.appState)
                .onAppear {
                    let array = MockJson.getTransactionHistory(accountId: "10")
                    print(array)
                }
        }
    }
}

struct ApplicationSwitcher: View {
    
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        switch settings.appState {
        case .closed:
            LandingScreen().eraseToAnyView().switchAnimation()
        case .opened:
            AccountsScreen().eraseToAnyView().switchAnimation()
        }
    }
    
}

extension View {
    func switchAnimation() -> some View {
        self.transition(.opacity.animation(.easeInOut(duration: 0.5)))
    }
}
