//  ToDoListApp.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/14/24.
//

import FirebaseCore // Import FirebaseCore to use Firebase services within the app.
import SwiftUI // Import the SwiftUI framework for UI elements.

@main // Define the entry point of the SwiftUI app.
struct ToDoListApp: App { // Declare the main app structure that conforms to the App protocol.
    // Initializer for the app structure.
    init() {
        FirebaseApp.configure() // Configure Firebase when the app is initialized.
    }
    
    // The body property represents the scene's content.
    var body: some Scene {
        WindowGroup { // Define a window group for the app's user interface.
            MainView() // Set the MainView as the root view of the app.
        }
    }
}
