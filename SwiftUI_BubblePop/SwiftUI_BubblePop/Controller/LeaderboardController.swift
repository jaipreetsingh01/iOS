//
//  LeaderboardController.swift
//  SwiftUI_BubblePop
//
//  Created by Jaipreet  on 26/05/24.
//

import Foundation

class LeaderboardController {
    private let leaderboardkey = "leaderboard"

    // Save new high score
    func saveLeaderboard(_ highScore: LeaderboardModel) {
        var leaderboard = loadLeaderboard()
        leaderboard.append(highScore)
        save(leaderboard)
    }

    // Load
    func loadLeaderboard() -> [LeaderboardModel] {
        guard let data = UserDefaults.standard.data(forKey: leaderboardkey) else {
            return []
        }
        if let decoded = try? JSONDecoder().decode([LeaderboardModel].self, from: data) {
            return decoded
        }
        return []
    }
    
    func resetLeaderboard() {
        // Reset
        UserDefaults.standard.removeObject(forKey: leaderboardkey)
    }
    
    // Save
     private func save(_ leaderboard: [LeaderboardModel]) {
        if let encoded = try? JSONEncoder().encode(leaderboard) {
            UserDefaults.standard.set(encoded, forKey: leaderboardkey)
        }
    }
}
