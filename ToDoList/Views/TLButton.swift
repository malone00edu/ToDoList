//  TLButton.swift
//  ToDoList
//
//  Created by Taze Balbosa on 4/16/24.
//

import SwiftUI // Import the SwiftUI framework for UI elements.

// Define a struct named TLButton that conforms to the View protocol.
struct TLButton: View {
    let title: String // Constant to hold the button title text.
    let foreground: Color // Constant to hold the color of the button's foreground.
    let action: () -> Void // Closure that defines the action to be performed when the button is tapped.
    
    // The body property represents the view's content.
    var body: some View {
        // Define a Button view.
        Button {
            // Call the action closure when the button is tapped.
            action()
        } label: {
            // Use a ZStack to layer the button's background and text.
            ZStack {
                // Create a rounded rectangle as the button's background.
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(foreground) // Set the background color to the specified foreground color.
                // Display the title text on the button.
                Text(title)
                    .foregroundColor(Color.white) // Set the text color to white.
                    .bold() // Make the text bold.
            }
        }
    }
}

// Preview provider for the TLButton.
#Preview {
    TLButton(title: "Value",
             foreground: .pink) {
        // Define an empty action for the preview.
    }
}
