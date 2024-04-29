//  RegisterVM.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import Foundation // Import Foundation for basic functionality.
import FirebaseAuth // Import FirebaseAuth for user authentication services.
import FirebaseFirestore // Import FirebaseFirestore to interact with Firestore database.

// Define RegisterVM class conforming to ObservableObject to allow UI updates.
class RegisterVM: ObservableObject {
    @Published var name = "" // Observable property for the user's name.
    @Published var email = "" // Observable property for the user's email.
    @Published var password = "" // Observable property for the user's password.
    
    // Empty initializer for the class.
    init() {}
    
    // Function to handle user registration.
    func register() {
        // Validate the input fields before proceeding with registration.
        guard validate() else {
            return
        }
        
        // Attempt to create a new user with the provided email and password.
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            // Check if the user was created successfully and retrieve the user ID.
            guard let userId = result?.user.uid else {
                return
            }
            
            // Insert the new user's record into the Firestore database.
            self?.insertUserRecord(id: userId)
        }
    }
    
    // Private function to insert the new user's record into Firestore.
    private func insertUserRecord(id: String) {
        // Create a new User instance with the provided information.
        let newUser = User(id: id,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970) // Store the current time as the joined date.
        
        // Reference to the Firestore database.
        let db = Firestore.firestore()
        
        // Add the new user's data to the Firestore database.
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary()) // Convert the User instance to a dictionary for storage.
    }
    
    // Private function to validate the input fields.
    private func validate() -> Bool{
        // Ensure the name, email, and password fields are not empty after trimming whitespace.
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        // Ensure the email contains an "@" symbol and a ".".
        guard email.contains("@") && email.contains(".") else {
            return false
        }
        
        // Ensure the password is at least 6 characters long.
        guard password.count >= 6 else {
            return false
        }
        
        // If all validations pass, return true.
        return true
    }
}
