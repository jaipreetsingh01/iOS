//
//  LeaderboardModel.swift
//  SwiftUI_BubblePop
//
//  Created by Jaipreet  on 26/05/24.
//

import Foundation

struct LeaderboardModel: Codable, Identifiable {
    var id = UUID()
    var playerName: String
    var highScore: Int
}
