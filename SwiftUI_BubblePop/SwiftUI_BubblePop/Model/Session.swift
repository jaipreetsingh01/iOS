//
//  Session.swift
//  SwiftUI_BubblePop
//
//  Created by Jaipreet  on 26/05/24.
//

import SwiftUI

class Session: ObservableObject {
    @Published var playerName: String = ""
    @Published var highScore: Int = 0
}
