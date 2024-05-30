//
//  CountdownView.swift
//  SwiftUI_BubblePop
//
//  Created by Jaipreet  on 27/05/24.
//

import SwiftUI

struct CountdownView: View {
    @EnvironmentObject var session: Session
    let countdown: [String] = ["Ready", "Set", "Go!"]
    @State private var currentIndex = 0
    @State private var isAnimating = false
    @Binding var counterFinished: Bool

    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)

            Text(countdown[currentIndex])
                .font(.system(size: 100))
                .fontWeight(currentIndex == countdown.count - 1 ? .medium : .bold) // Adjusted font weight
                .foregroundColor(Color.red.opacity(0.8))
                .scaleEffect(isAnimating ? 1.2 : 1)
                .opacity(isAnimating ? 1 : 0)
                .onAppear {
                    animateCountdown()
                }
        }
    }

    func animateCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                self.isAnimating.toggle()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if self.currentIndex < self.countdown.count - 1 {
                    self.currentIndex += 1
                } else {
                    timer.invalidate()
                    self.counterFinished = true
                }

                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    self.isAnimating.toggle()
                }
            }
        }
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(counterFinished: .constant(false))
    }
}
