//
//  AppDefaultButton.swift
//  TestStan
//
//  Created by Nikita on 06.12.2023.
//

import SwiftUI

struct AppDefaultButton: View {
    
    let title: String
    let textColor: Color
    let buttonColor: Color
    let callback: () -> Void
    
    var iconRight: String? = nil
    
    var body: some View {
        Button(action: {
            callback()
        }, label: {
            HStack {
                Spacer()
                Text(title)
                    .font(.custom(FontUtils.FONT_SEMIBOLD, size: 14))
                    .foregroundColor(textColor)
                    .padding(.vertical)
                Spacer()
            }
            .frame(width: .infinity)
        })
        .background(buttonColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
