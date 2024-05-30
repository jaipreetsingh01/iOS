//
//  StarterView.swift
//  SwiftUI_BubblePop
//
//  Created by Jaipreet  on 26/05/24.
//

import SwiftUI

struct StarterView: View {
    @EnvironmentObject var session: Session
    @EnvironmentObject var gameSettings: GameSettings

    var body: some View {
        VStack(spacing: 20) {
            Label("Confirm Player Name ", systemImage: "")
                .foregroundColor(Color.red.opacity(0.8))
                .font(.largeTitle)
                .padding(.top, 25)
            
            // Player Name Input
           
            // common input styling we see in many apps with some shadows
            VStack {
                TextField("Enter Your Name", text: $session.playerName)
                    .padding()
                    .padding(.horizontal) // Add horizontal padding
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Apply shadow
                    )
            }

            if session.playerName.isEmpty {
                Text("Name is required") // Display an error message if the field is empty
                    .foregroundColor(.red)
            }
            
            // Game Time Slider

           
            
          // STARTO!!!!
            ZStack {
                NavigationLink(destination: GameView(gameModel: GameModel(maxBubbles: Int(gameSettings.numberOfBubbles), timeLeft: Int(gameSettings.gameTime), playerName: session.playerName))) {
                    Text("Start Game")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .cornerRadius(25)
                        .padding(.horizontal)
                        .padding(.top, 50)
                }
                .disabled(session.playerName.isEmpty) // Disable the NavigationLink if playerName is empty
                
                // Transparent overlay to capture taps when the link is disabled
                if session.playerName.isEmpty {
                    Color.clear // Transparent color
                        .contentShape(Rectangle()) // Make the overlay tappable
                        .onTapGesture {}
                        .padding(.top, 50)// Consume tap gestures
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer() // push content up
        }
        .padding()
//        .navigationBarBackButtonHidden(true) // FOR TESTING , UNCOMMENT LATER!!!!!!!!!!!
    }
        
    
}

struct StarterView_Previews: PreviewProvider {
    static var previews: some View {
        StarterView()
            .environmentObject(Session()).environmentObject(GameSettings())
    }
}
