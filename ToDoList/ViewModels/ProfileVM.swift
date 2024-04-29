//  ProfileViewVM.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import FirebaseAuth // Import FirebaseAuth for user authentication services.
import FirebaseFirestore // Import FirebaseFirestore to interact with Firestore database.
import Foundation // Import Foundation for basic functionality.

// Define ProfileVM class conforming to ObservableObject to allow UI updates.
class ProfileVM: ObservableObject {
    // Empty initializer for the class.
    init() {}
    
    @Published var user: User? = nil // Observable property for the current user's information.
    
    // Function to fetch the current user's information from Firestore.
    func fetchUser() {
        // Retrieve the current user's ID from FirebaseAuth.
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        // Reference to the Firestore database.
        let db = Firestore.firestore()
        // Fetch the document for the current user from the Firestore database.
        db.collection("users").document(userId).getDocument {
            [weak self] snapshot, error in
            // Check for a valid snapshot and no errors.
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            // Update the user property on the main thread.
            DispatchQueue.main.async {
                // Create a User instance with the data retrieved from Firestore.
                self?.user = User(
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: data["joined"] as? TimeInterval ?? 0 // Convert TimeInterval to Date if needed.
                )
            }
        }
    }
    
    // Function to log out the current user.
    func logOut() {
        do {
            // Attempt to sign out the current user.
            try Auth.auth().signOut()
        } catch {
            // If an error occurs, print it to the console.
            print(error)
        }
    }
    
}
