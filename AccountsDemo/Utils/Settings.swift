//
//  Settings.swift
//  AccountsDemo
//
//  Created by SD on 06/12/23.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class Settings: ObservableObject {
    @Published private(set) var appState: AppState = .closed
    @AppStorage("is_logged_in") private(set) var isLoggedIn = false
    
    init() {
        self.setAppState()
    }
    
    func setAppState() {
        appState = isLoggedIn ? .opened : .closed
    }
    
    func doLogin() {
        isLoggedIn = true
        setAppState()
    }
    
    func doLogout() {
        isLoggedIn = false
        setAppState()
    }
    
}
