//
//  LandingScreen.swift
//  AccountsDemo
//
//  Created by SD on 06/12/23.
//

import SwiftUI

struct LandingScreen: View {
    @EnvironmentObject private var settings: Settings
    var body: some View {
        Button("Open") {
            settings.doLogin()
        }
        .buttonStyle(.borderedProminent)
    }
}

struct LandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LandingScreen()
    }
}

//Can use macros in Xcode15 instead of PreviewProvider
/*#Preview {
    LandingScreen()
}*/
