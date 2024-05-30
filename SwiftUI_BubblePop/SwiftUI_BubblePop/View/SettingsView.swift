//
//  SettingsView.swift
//  SwiftUI_BubblePop
//
//  Created by Jaipreet  on 26/05/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var session: Session
//    @EnvironmentObject var session: Session
    @EnvironmentObject var gameSettings: GameSettings
    
    var body: some View{
        
        VStack {
            Label("Settings", systemImage: "")
                .foregroundColor(Color.red.opacity(0.8))
                .font(.largeTitle)
//                .padding(.top, 20)
            
            Text("Game Time: \(Int(gameSettings.gameTime))s")
                .foregroundColor(Color.red.opacity(0.9))
                .padding()
            Slider(value: $gameSettings.gameTime, in: 1...60, step: 1)
                .accentColor(Color.red.opacity(0.8)) // Set slider color
                .padding(.horizontal, 20) // Add horizontal padding
                .padding(.vertical, 5) // Add vertical padding
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.red.opacity(0.2))) // Apply background color
                .padding(.horizontal)
            
            // Number of Bubbles Slider
            VStack {
                Text("Number of Bubbles: \(Int(gameSettings.numberOfBubbles))")
                    .foregroundColor(Color.red.opacity(0.9))
                Slider(value: $gameSettings.numberOfBubbles, in: 1...15, step: 1)
                    .accentColor(Color.red.opacity(0.8)) // Set slider color
                    .padding(.horizontal, 20) // Add horizontal padding
                    .padding(.vertical, 5) // Add vertical padding
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.red.opacity(0.2))) // Apply background color
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(GameSettings())
    }
}
