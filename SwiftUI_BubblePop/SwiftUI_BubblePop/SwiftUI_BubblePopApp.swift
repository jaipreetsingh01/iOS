//
//  SwiftUI_BubblePopApp.swift
//  SwiftUI_BubblePop
//
//  Created by Jaipreet  on 26/05/24.
//

import SwiftUI

@main
struct SwiftUI_BubblePopApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Session()).environmentObject(GameSettings())
                .navigationViewStyle(StackNavigationViewStyle())

        }
    }
}

// SETTING MAIN CONTENT , INJECT THE SETTINGS & SESSION ENV OBJ HERE
