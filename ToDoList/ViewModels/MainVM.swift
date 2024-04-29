//  MainViewVM.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import Foundation // Importing the Foundation framework for basic functionalities.
import FirebaseAuth // Importing the FirebaseAuth framework for authentication purposes.

// Defining the MainVM class which conforms to the ObservableObject protocol to allow UI to observe changes.
class MainVM: ObservableObject {
    @Published var currentUserId: String = "" // A published property to store the current user's ID. Changes to this will update the UI.
    private var handler: AuthStateDidChangeListenerHandle? // A private property to store the reference to the authentication listener.
    
    // Initializer for the class.
    init() {
        // Setting up the authentication state listener to update the currentUserId when the authentication state changes.
        let handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            // Executing the update on the main thread to ensure UI updates happen on the main thread.
            DispatchQueue.main.async {
                // Updating the currentUserId with the user's UID if available, otherwise setting it to an empty string.
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    // Computed property to check if a user is currently signed in.
    public var isSignedIn: Bool {
        // Returns true if there's a current user signed in, false otherwise.
        return Auth.auth().currentUser != nil
    }
}
