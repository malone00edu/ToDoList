//  LoginView.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import SwiftUI // Import the SwiftUI framework to use its features for UI elements.

// Define a struct named LoginView that conforms to the View protocol.
struct LoginView: View {
    @StateObject var viewModel = LoginVM() // Create a state object of the LoginVM ViewModel.
    
    // The body property represents the view's content.
    var body: some View {
        // Use a NavigationView to enable navigation between views.
        NavigationView {
            // Use a VStack to arrange subviews vertically.
            VStack {
                // Header component of the login view.
                HeaderView(title: "To Do List",
                           subtitle: "Get things done",
                           angle: 15,
                           foreground: .pink)
                
                // Login form section.
                Form {
                    // Display an error message if it exists.
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red) // Set the text color to red for errors.
                    }
                    
                    // Text field for the user's email address.
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle()) // Apply the default text field style.
                        .autocapitalization(.none) // Disable auto-capitalization.
                        .autocorrectionDisabled() // Disable auto-correction.
                    // Secure field for the user's password.
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle()) // Apply the default text field style.
                    
                    // Custom button for the login action.
                    TLButton(title: "Log In",
                             foreground: .blue,
                             action: {
                        // Trigger the login function in the ViewModel when tapped.
                        viewModel.login()
                    })
                    .padding() // Add padding around the button.
                }
                .offset(y: -50) // Move the form upwards to offset the default spacing.
                
                // Section for creating a new account.
                VStack {
                    Text("New around here?")
                    // Navigation link to the registration view.
                    NavigationLink("Create an account", destination: RegisterView())
                }
                .padding(.bottom, 50) // Add padding at the bottom.
                
                Spacer() // Use a spacer to push all content to the top.
            }
        }
    }
}

// Preview provider for the LoginView.
#Preview {
    LoginView()
}
