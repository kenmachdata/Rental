//
//  Buttons.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/2/22.
//

import SwiftUI

struct GrowingButton: ButtonStyle {
    var fColor = Color.white
    var bColor = Color.blue
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(bColor)
            .foregroundColor(fColor)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct RectangleCard: View {
    
    var color = Color.white
    
    var body: some View {
        
        Rectangle()
            .foregroundColor(color)
            .clipShape(Capsule())
            .shadow(radius: 5)
            .padding()
    }
}

