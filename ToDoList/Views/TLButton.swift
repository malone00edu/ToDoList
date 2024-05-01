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
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .background(.foreground)
                .bold()
                .frame(maxWidth: .infinity)
                .cornerRadius(30)
                .padding()
        }
        .buttonStyle(.borderedProminent)
    }
}

// Preview provider for the TLButton.
#Preview {
    TLButton(title: "Value",
             foreground: .blue) {
        // Define an empty action for the preview.
    }
}
