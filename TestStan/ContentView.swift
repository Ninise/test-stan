//
//  ContentView.swift
//  TestStan
//
//  Created by Nikita on 06.12.2023.
//

import SwiftUI

struct ContentView: View {

    // last thing what I do today, in a real project we usuall do requests etc... and use NavigationLink
    @State var isDashboardTime: Bool = false
    
    var body: some View {
        NavigationStack {
            if isDashboardTime {
                DashboardView()
            } else {
                SplashView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.isDashboardTime = true
            })
        }
    }
}

#Preview {
    ContentView()
}
