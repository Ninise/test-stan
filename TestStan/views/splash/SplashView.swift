//
//  SplashView.swift
//  TestStan
//
//  Created by Nikita on 06.12.2023.
//

import SwiftUI

struct SplashView: View {
    
    let logo: String = "ic_logo"
    let imgSize: CGFloat = 400
    
    
    
    var body: some View {
        ZStack (alignment: .center) {
        
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color.mainPurple, location: 1),
                    Gradient.Stop(color: Color.mainBlue, location: 1)
                ],
                startPoint: UnitPoint(x: 0.24, y: 0),
                endPoint: UnitPoint(x: 0.79, y: 1)
            )
            .edgesIgnoringSafeArea(.all)
            
        
            Image(logo)
                .resizable()
                .scaledToFit()
                .frame(width: imgSize, height: imgSize)
            
        }
        .background(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color.mainPurple, location: 1),
                    Gradient.Stop(color: Color.mainBlue, location: 1)
                ],
                startPoint: UnitPoint(x: 0.24, y: 0),
                endPoint: UnitPoint(x: 0.79, y: 1)
            )
        )
        
        
    }
}

#Preview {
    SplashView()
}
