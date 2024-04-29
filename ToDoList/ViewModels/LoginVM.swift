//  LoginVM.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import Foundation // Importing the Foundation framework for basic functionalities.
import FirebaseAuth // Importing the FirebaseAuth framework for handling user authentication.

// Defining the LoginVM class which conforms to the ObservableObject protocol to allow UI to observe changes.
class LoginVM: ObservableObject {
    @Published var email = "" // A published property to store the user's email. Observable by the UI.
    @Published var password = "" // A published property to store the user's password. Observable by the UI.
    @Published var errorMessage = "" // A published property to store the error message. Observable by the UI.
    
    // Empty initializer for the class.
    init() {}
    
    // Function to attempt user login.
    func login() {
        // First, validate the input fields.
        guard validate() else {
            // If validation fails, exit the function.
            return
        }
        
        // If validation succeeds, try to log in with the provided email and password.
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    // Function to validate the email and password fields.
    func validate() -> Bool {
        // Clear any previous error messages.
        errorMessage = ""
        // Check if the email and password fields are not empty after trimming spaces.
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            // If any field is empty, set the error message and return false.
            errorMessage = "Please fill in all fields."
            return false
        }
        
        // Check if the email is in a valid format.
        guard email.contains("@") && email.contains(".") else {
            // If the email format is invalid, set the error message and return false.
            errorMessage = "Please enter valid email."
            return false
        }
        
        // If all validations pass, return true.
        return true
    }
}
