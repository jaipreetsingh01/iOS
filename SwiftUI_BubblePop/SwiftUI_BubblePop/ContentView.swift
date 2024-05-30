//
//  ContentView.swift
//  SwiftUI_BubblePop
//
//  Created by Jaipreet  on 26/05/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var session = Session()
    
    
    // just a view stach with 3 buttons
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
//                Image("Background")
//                    .aspectRatio(contentMode: .fill)
                VStack {
                    Spacer()
                    
                    // basic ease in out animation
                    Text("BUBBLE POP")
                        .foregroundColor(Color.red.opacity(0.8))
                        .font(.largeTitle)
                        .padding(.bottom, 100)
                        .scaleEffect(1.2) // Initial scale
                        .animation(Animation.easeInOut(duration: 1).repeatForever()) // Continuous animation
                    
                    // New Game Button
                    NavigationLink(destination: StarterView().environmentObject(session)) {
                        Text("New Game")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.7) // 0.7 for making 70% of the screen width
                            .background(Color.red.opacity(0.8))
                            .cornerRadius(15) //  corner radius
                            .padding(.horizontal)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // High Score Button
                    NavigationLink(destination: LeaderboardView()) {
                        Text("High Score")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.7)
                            .background(Color.red.opacity(0.8))
                            .cornerRadius(15)
                            .padding(.horizontal)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // Settings Button
                    NavigationLink(destination: SettingsView()) {
                        Text("Settings")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.7)
                            .background(Color.red.opacity(0.8))
                            .cornerRadius(15)
                            .padding(.horizontal)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationBarTitle("", displayMode: .large)
        .navigationBarBackButtonHidden(true) // hide the back button not needed
        .onAppear {
            UITableView.appearance().separatorStyle = .none 
        }
        .environmentObject(session)
    }
}


#Preview {
    ContentView()
}
