//
//  SettingsController.swift
//  SwiftUI_BubblePop
//
//  Created by Jaipreet  on 28/05/24.
//

import SwiftUI
import Combine

class GameSettings: ObservableObject {
    @Published var gameTime: Double
    @Published var numberOfBubbles: Double

    init(gameTime: Double = 60.0, numberOfBubbles: Double = 15) {
        self.gameTime = gameTime
        self.numberOfBubbles = numberOfBubbles
    }
}
