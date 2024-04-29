//  ProfileView.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import SwiftUI // Import the SwiftUI framework for UI elements.

// Define a struct named ProfileView that conforms to the View protocol.
struct ProfileView: View {
    @StateObject var viewModel = ProfileVM() // Create a state object of the ProfileVM ViewModel.
    
    // The body property represents the view's content.
    var body: some View {
        // Use a NavigationView to enable navigation between views.
        NavigationView {
            // Use a VStack to arrange subviews vertically.
            VStack {
                // Check if the user object is available.
                if let user = viewModel.user {
                    // If the user object is available, display the profile view.
                    profile(user: user)
                } else {
                    // If the user object is not available, display a loading message.
                    Text("Loading Profile...")
                        .offset(y: -100) // Move the text upwards.
                }
            }
            .navigationTitle("Profile") // Set the navigation bar title.
        }
        .onAppear {
            // Fetch the user data when the view appears.
            viewModel.fetchUser()
        }
    }
    
    // A custom view builder to create the profile view.
    @ViewBuilder
    func profile(user: User) -> some View {
        // Display an avatar image.
        Image(systemName: "person.circle")
            .resizable() // Make the image resizable.
            .aspectRatio(contentMode: .fit) // Maintain the aspect ratio while fitting the content.
            .foregroundColor(Color.blue) // Set the image color to blue.
            .frame(width: 125, height: 125) // Set the frame size.
            .padding() // Add padding around the image.
        
        // Vertical stack for user information.
        VStack(alignment: .leading, content: {
            // Horizontal stack for the user's name.
            HStack {
                Text("Name: ")
                    .bold() // Make the label bold.
                Text(user.name) // Display the user's name.
            }
            .padding() // Add padding around the name stack.
            // Horizontal stack for the user's email.
            HStack {
                Text("Email: ")
                    .bold() // Make the label bold.
                Text(user.email) // Display the user's email.
            }
            .padding() // Add padding around the email stack.
            // Horizontal stack for the user's membership date.
            HStack {
                Text("Member Since: ")
                    .bold() // Make the label bold.
                // Display the formatted date of when the user joined.
                Text("\(Date(timeIntervalSince1970:user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
            .padding() // Add padding around the membership date stack.
        })
        
        // Button to log out the user.
        Button("Log Out") {
            // Call the logOut function in the ViewModel when tapped.
            viewModel.logOut()
        }
        .tint(.red) // Set the button tint color to red.
        .padding() // Add padding around the button.
        Spacer() // Use a spacer to push all content to the top.
    }
}

// Preview provider for the ProfileView.
#Preview {
    ProfileView()
}
