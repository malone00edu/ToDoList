//  MainView.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import SwiftUI // Import the SwiftUI framework for UI elements.

// Define a struct named MainView that conforms to the View protocol.
struct MainView: View {
    @StateObject var viewModel = MainVM() // Create a state object of the MainVM ViewModel.
    
    // The body property represents the view's content.
    var body: some View {
        // Check if the user is signed in and the currentUserId is not empty.
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            // If signed in, show the account view.
            accountView
        } else {
            // If not signed in, show the LoginView.
            LoginView()
        }
    }
    
    // A custom view builder to create the account view.
    @ViewBuilder
    var accountView: some View {
        // Use a TabView to allow for tab-based navigation.
        TabView {
            // First tab containing the to-do list view.
            ToDoListView(userId: viewModel.currentUserId)
                .tabItem {
                    // Label for the home tab with a house icon.
                    Label("Home", systemImage: "house")
                }
            // Second tab containing the profile view.
            ProfileView()
                .tabItem {
                    // Label for the profile tab with a person circle icon.
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

// Preview provider for the MainView.
#Preview {
    MainView()
}
