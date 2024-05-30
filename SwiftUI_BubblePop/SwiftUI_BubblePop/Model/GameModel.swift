
//  gameModel.swift
//  SwiftUI_BubblePop
//
//  Created by Jaipreet  on 26/05/24.


import Foundation
import SwiftUI

class GameModel: ObservableObject {
    @Published var bubbles: [BubbleModel] = [] // this will be array of circles() - bubbles
    @Published var timeLeft: Int
    @Published var score: Int = 0 // current score of player
    @Published var highScore: Int = UserDefaults.standard.integer(forKey: "leaderboardkey") //
    @StateObject private var session = Session() // Game session information
    
    private var maxBubbles: Int // from game setiings
    private var timer: Timer?
    private var playerName: String // player name
    
    // Track the color of the last popped bubble

    private var lastPoppedColor: Color?
    
    // Initialize the game with specified parameters
    init(maxBubbles: Int, timeLeft: Int, playerName: String) {
        self.maxBubbles = maxBubbles
        self.timeLeft = timeLeft + 3 // Add extra time to compensate for countdown
        self.playerName = playerName
        generateBubbles(count: maxBubbles) // Generate bubbles for the game
    }
    
    // Start the game
    func startGame() {
        // making time slower for testing
        timer = Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeLeft > 0 {
                self.timeLeft -= 1 // Decrease time
                self.refreshBubbles() // Refresh bubbles every game second
            } else {
                self.endGame(playerName: self.playerName) // End the game if time runs out
            }
        }
    }
    
    // End the game and update high scores
    func endGame(playerName: String) {
        timer?.invalidate() // Stop the timer
        if score > highScore {
            highScore = score // Update high score
            UserDefaults.standard.set(highScore, forKey: "leaderboardkey") // Save high score to UserDefaults
            // Save high score entry
            LeaderboardController().saveLeaderboard(LeaderboardModel(playerName: playerName, highScore: highScore))
        }
    }
    
    // Pop a bubble and update score
    func popBubble(_ bubble: BubbleModel) {
        if let index = bubbles.firstIndex(where: { $0.id == bubble.id }) {
            let basePoints: Int
            
            // Determine the base points based on the color of the bubble
            switch bubble.color {
            case .red:
                basePoints = 1
            case .purple:
                basePoints = 2
            case .green:
                basePoints = 5
            case .blue:
                basePoints = 8
            case .black:
                basePoints = 10
            default:
                basePoints = 1
            }
            
            // Check if the last popped bubble's color is the same as the current one
            let pointsEarned: Int
            if let lastColor = lastPoppedColor, lastColor == bubble.color {
                pointsEarned = Int(ceil(Double(basePoints) * 1.5)) // Apply 1.5x multiplier
            } else {
                pointsEarned = basePoints
            }
            
            score += pointsEarned // Increase score
            bubbles.remove(at: index) // Remove popped bubble from the array
            lastPoppedColor = bubble.color // Update the last popped color
        }
    }
    
    // Generate bubbles with random colors and positions
    private func generateBubbles(count: Int) {
        // Define the colors and their probabilities
        let colorProbabilities: [(color: Color, probability: Int)] = [
            (.red, 40),
            (.purple, 30),
            (.green, 15),
            (.blue, 10),
            (.black, 5)
        ]

        let bubbleSize: CGFloat = 80.0 // Bubble size
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        for _ in 0..<count {
            // Select a color based on the defined probabilities
            let randomColor = selectColor(basedOn: colorProbabilities)
            
            var bubble = BubbleModel()
            
            // Generate random positions across the entire screen
            var isIntersecting: Bool
            var randomX: CGFloat
            var randomY: CGFloat
            
            // Ensure bubbles do not intersect with each other
            
            // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            // NOT WORKING - UPDATE LATER
            // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            
            repeat {
                randomX = CGFloat.random(in: 0...(screenWidth - bubbleSize))
                randomY = CGFloat.random(in: 0...(screenHeight - bubbleSize))
                
                let newBubbleCenter = CGPoint(x: randomX + bubbleSize / 2, y: randomY + bubbleSize / 2)
                
                // Check for intersection with existing bubbles
                isIntersecting = bubbles.contains { existingBubble in
                    let existingBubbleCenter = CGPoint(x: existingBubble.position.x + bubbleSize / 2, y: existingBubble.position.y + bubbleSize / 2)
                    let distance = hypot(existingBubbleCenter.x - newBubbleCenter.x, existingBubbleCenter.y - newBubbleCenter.y)
                    return distance < bubbleSize // Check if the distance between centers is less than the diameter of the bubbles
                }
            } while isIntersecting
            
            bubble.position = CGPoint(x: randomX, y: randomY) // Set bubble position
            bubble.color = randomColor // Set bubble color
            bubbles.append(bubble) // Add bubble to the array
        }
    }
    
    
//    private func generateBubbles(count: Int) {
//        let bubbleColors: [Color] = [.red, .pink, .green, .blue, .black]
//        
//        let bubbleSize: CGFloat = 100.0 // Bubble size
//        let screenWidth = UIScreen.main.bounds.width
//        let screenHeight = UIScreen.main.bounds.height
//        
//        for _ in 0..<count {
//            let randomColor = bubbleColors.randomElement() ?? .red // Default to red if no color is selected
//            var bubble = BubbleModel()
//            
//            var isIntersecting: Bool
//            var randomX: CGFloat
//            var randomY: CGFloat
//            
//            // Ensure bubbles do not intersect with each other
//            repeat {
//                randomX = CGFloat.random(in: 0...(screenWidth - bubbleSize))
//                randomY = CGFloat.random(in: 0...(screenHeight - bubbleSize))
//                
//                let newBubbleCenter = CGPoint(x: randomX + bubbleSize / 2, y: randomY + bubbleSize / 2)
//                
//                // Check for intersection with existing bubbles
//                isIntersecting = bubbles.contains { existingBubble in
//                    let existingBubbleCenter = CGPoint(x: existingBubble.position.x + bubbleSize / 2, y: existingBubble.position.y + bubbleSize / 2)
//                    let distance = hypot(existingBubbleCenter.x - newBubbleCenter.x, existingBubbleCenter.y - newBubbleCenter.y)
//                    return distance < bubbleSize // Check if the distance between centers is less than the diameter of the bubbles
//                }
//            } while isIntersecting
//            
//            bubble.position = CGPoint(x: randomX, y: randomY) // Set bubble position
//            bubble.color = randomColor // Set bubble color
//            bubbles.append(bubble) // Add bubble to the array
//        }
//    }

    // Helper function to select a color based on probabilities 
    private func selectColor(basedOn probabilities: [(color: Color, probability: Int)]) -> Color {
        // Create an array where each color appears according to its probability
        let weightedColors = probabilities.flatMap { color, probability in
            Array(repeating: color, count: probability)
        }
        // Select a random color from the  array
        return weightedColors.randomElement() ?? .red // Default to red if no color is selected
    }
    
    // Refresh bubbles by removing some and adding new ones
    private func refreshBubbles() {
        // Determine the number of bubbles to remove
        let bubblesToRemove = Int.random(in: 1...(bubbles.count / 2))
        
        // Remove the specified number of bubbles
        bubbles.shuffle()
        bubbles.removeLast(bubblesToRemove)
        
        // Add new bubbles to maintain the maxBubbles count
        generateBubbles(count: maxBubbles - bubbles.count)
    }
    
    // Model representing a bubble on the screen
    class BubbleModel: Identifiable, ObservableObject {
        let id = UUID() // Unique identifier for the bubble
        var color: Color // Color of the bubble
        let value: Int // Value of the bubble
        @Published var position: CGPoint // Position of the bubble
        
        // Initialize bubble with random color and position
        init() {
            // Determine the color and value of the bubble based on a random number
            let Prob = Int.random(in: 1...100)
            
            switch Prob {
            case 1...40:
                (color, value) = (.red, 1)
            case 41...70:
                (color, value) = (Color(red: 0.99, green: 0.7, blue: 0.9), 2)
            case 71...85:
                (color, value) = (.green, 5)
            case 86...95:
                (color, value) = (.blue, 8)
            case 96...100:
                (color, value) = (.black, 10)
            default:
                (color, value) = (.red, 1)
            }
            
            // Initialize position with zero point initially
            self.position = .zero
        }
    }
}






