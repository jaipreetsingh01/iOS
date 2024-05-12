//
//  ContentView.swift
//  Ass3_ExpensePlanner
//
//  Created by Jaipreet  on 10/05/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var rootVM: RootViewModel
    var body: some View {
        RootView()
            .environmentObject(rootVM)
            .preferredColorScheme(.light)
            .fullScreenCover(isPresented: $rootVM.showCreateAccoutView) {
                NavigationStack{
                    CreateAccountView(rootVM: rootVM, hiddenClose: true)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RootViewModel(context: dev.viewContext))
    }
}

#Preview {
    ContentView()
}
