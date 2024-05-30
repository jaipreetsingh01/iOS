//
//  GameView.swift
//  SwiftUI_BubblePop
//
//  Created by Jaipreet  on 26/05/24.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var session: Session
    @ObservedObject var gameModel: GameModel
    @State private var counterFinished : Bool = false
    @State private var isGameFinished: Bool = false // CHECKER AT TIME ZERO
   

    var body: some View {
        NavigationView {
            VStack {
                // Countdown View
                if !counterFinished {
                    CountdownView(counterFinished: $counterFinished)
                        .padding(.vertical, 50)
                } else {
                    VStack {
                        HStack {
                            Text("Time Left: \(gameModel.timeLeft)")
                                .font(.headline)
                                .foregroundColor(Color.red.opacity(0.8))
                                .padding(.leading)
                            
                            Spacer()
                            
                            Text("Score: \(gameModel.score)")
                                .font(.headline)
                                .foregroundColor(Color.red.opacity(0.8))
                                .padding(.trailing)
                            
                            Text("High Score: \(gameModel.highScore)")
                                .font(.headline)
                                .padding(.trailing)
                                .foregroundColor(Color.red.opacity(0.8))
                        }
                        .padding(.top, 60)
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        // Display bubbles using BubbleModel objects from gameViewModel
                        ForEach(gameModel.bubbles) { bubble in
                            Circle()
                                .fill(bubble.color)
                                .frame(width: 70, height: 70)
                                .position(bubble.position)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3) // Adding shadow effect
                                .onTapGesture {
                                    gameModel.popBubble(bubble)
                                }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                gameModel.startGame() // Start the game when view appears
            }
            .onReceive(gameModel.$timeLeft) { timeLeft in
                if timeLeft == 0 && !isGameFinished {
                    end()
                }
            }
            .background(
                NavigationLink(destination: LeaderboardView(), isActive: $isGameFinished) { 
                    EmptyView()
                }
                .hidden() // Hide the navigation link button
            )
            .navigationBarBackButtonHidden(true)
            .onReceive(session.$highScore) { newHighScore in
                if newHighScore > gameModel.highScore {
                    gameModel.highScore = newHighScore
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func end() {
        isGameFinished = true // Set isGameFinished to true once
        gameModel.endGame(playerName: session.playerName)
        if gameModel.score > session.highScore {
            session.highScore = gameModel.score
            LeaderboardController().saveLeaderboard(LeaderboardModel(playerName: session.playerName, highScore: session.highScore))
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameModel: GameModel(maxBubbles: 10, timeLeft: 10, playerName: "Jp"))
            .environmentObject(Session()) // Provide a sample GameViewModel with timeLeft = 0 for testing
    }
}
