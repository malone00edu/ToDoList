//  RegisterView.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import SwiftUI // Import the SwiftUI framework for UI elements.

// Define a struct named RegisterView that conforms to the View protocol.
struct RegisterView: View {
    @StateObject var viewModel = RegisterVM() // Create a state object of the RegisterVM ViewModel.
    
    // The body property represents the view's content.
    var body: some View {
        // Header component of the register view.
        HeaderView(title: "Register",
                   subtitle: "Start organizing todos",
                   angle: -15, // Set the angle for the header view's appearance.
                   foreground: .orange) // Set the foreground color to orange.
        
        // Form for the registration input fields.
        Form {
            // Text field for the user's full name.
            TextField("Full Name", text: $viewModel.name)
                .textFieldStyle(DefaultTextFieldStyle()) // Apply the default text field style.
            
            // Text field for the user's email address.
            TextField("Email Address", text: $viewModel.email)
                .textFieldStyle(DefaultTextFieldStyle()) // Apply the default text field style.
                .autocapitalization(.none) // Disable auto-capitalization.
                .autocorrectionDisabled() // Disable auto-correction.
            
            // Secure field for the user's password.
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(DefaultTextFieldStyle()) // Apply the default text field style.
            
            // Custom button for the create account action.
            TLButton(title: "Create Account",
                     foreground: .green, // Set the button text color to green.
                     action: {
                // Trigger the register function in the ViewModel when tapped.
                viewModel.register()
            })
            .padding() // Add padding around the button.
        }
        .offset(y: -50) // Move the form upwards to offset the default spacing.
        
        Spacer() // Use a spacer to push all content to the top.
    }
}

// Preview provider for the RegisterView.
#Preview {
    RegisterView()
}
