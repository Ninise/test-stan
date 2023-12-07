//
//  FloatingButton.swift
//  TestStan
//
//  Created by Nikita on 06.12.2023.
//

import SwiftUI

struct FloatingButton: View {
    
    let action: () -> Void
    
    let plusSize: CGFloat = 24
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: plusSize, height: plusSize)
                .padding()
        })
        .background(
            Circle()
                .fill(Color.mainPurple)
        )
        .padding()
        .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    FloatingButton() {
        
    }
}
