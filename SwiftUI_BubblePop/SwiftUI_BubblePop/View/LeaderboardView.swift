//
//  LeaderboardView.swift
//  SwiftUI_BubblePop
//
//  Created by Jaipreet  on 26/05/24.
//

import SwiftUI

struct LeaderboardView: View {
    @EnvironmentObject var session: Session
    @State private var leaderboard: [LeaderboardModel] = []
    @State private var isConfirmingReset = false
    @State private var navigateToStarterView = false // State variable to control navigation

    var body: some View {
        NavigationView {
            VStack {
                Text("Leaderoard")
                    .font(.title)
                    .foregroundColor(.red.opacity(0.9))
                
                Button(action: {
                    isConfirmingReset = true
                }) {
                    Text("Reset Leaderboard")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 1.0, green: 0.4, blue: 0.4)) // Light red background color
                        .cornerRadius(10).padding()
                }
                .alert(isPresented: $isConfirmingReset) {
                    Alert(
                        title: Text("Reset"),
                        message: Text("Reset Leaderboard? This action cannot be undone."),
                        primaryButton: .default(Text("Reset")) {
                            resetHighScores()
                        },
                        secondaryButton: .cancel()
                    )
                }
                
                List(leaderboard.sorted(by: { $0.highScore > $1.highScore })) { score in
                    HStack {
                        Text(score.playerName)
                        Spacer()
                        Text("\(score.highScore)")
                    }
                }
            }
            .onAppear {
                // Load high scores from UserDefaults using HighScoreManager
                leaderboard = LeaderboardController().loadLeaderboard()
            }
            
            .navigationBarItems(leading: leadingBarButton) // Set custom back button
            .background(
                NavigationLink(destination: ContentView(), isActive: $navigateToStarterView) {
                    EmptyView()
                }
                .hidden()
            )
        }
        .navigationBarBackButtonHidden(true) // Hide default back button
    }

    private func resetHighScores() {
        LeaderboardController().resetLeaderboard()
        leaderboard.removeAll()
    }
    
    private var leadingBarButton: some View {
        Button(action: {
            navigateToStarterView = true // Set navigateToStarterView to true to trigger navigation
        }) {
            Image(systemName: "arrow.backward")
                .foregroundColor(.blue) // Customize the color of the back button
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
