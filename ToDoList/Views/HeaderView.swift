//  HeaderView.swift
//  ToDoList
//
//  Created by Taze Balbosa on 4/16/24.
//

import SwiftUI // Import the SwiftUI framework for UI elements.

// Define a struct named HeaderView that conforms to the View protocol.
struct HeaderView: View {
    let title: String // Constant to hold the title text.
    let subtitle: String // Constant to hold the subtitle text.
    let angle: Double // Constant to hold the rotation angle.
    let foreground: Color // Constant to hold the color of the foreground.

    // The body property represents the view's content.
    var body: some View {
        // Use a ZStack to layer the title and subtitle over the background.
        ZStack {
            // Create a rectangle with no corner radius.
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(foreground) // Set the foreground color of the rectangle.
                .rotationEffect(Angle(degrees: angle)) // Rotate the rectangle by the specified angle.
                
            // Use a VStack to arrange the title and subtitle vertically.
            VStack {
                // Display the title text.
                Text(title)
                    .font(.system(size: 50)) // Set the font size to 50.
                    .foregroundColor(Color.white) // Set the text color to white.
                    .bold() // Make the text bold.
                // Display the subtitle text.
                Text(subtitle)
                    .font(.system(size: 30)) // Set the font size to 30.
                    .foregroundColor(Color.white) // Set the text color to white.
            }
            .padding(.top, 80) // Add padding to the top of the VStack.
        }
        // Set the frame size to be three times the width of the screen and 350 points in height.
        .frame(width: UIScreen.main.bounds.width * 3, height:350)
        .offset(y: -150) // Offset the frame to move it upwards.
    }
}

// Preview provider for the HeaderView.
#Preview {
    HeaderView(title: "Title", subtitle: "Subtitle", angle: 15, foreground: .blue)
}
