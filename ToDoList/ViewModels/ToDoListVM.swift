//  ToDoListVM.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import FirebaseFirestore // Import FirebaseFirestore to interact with Firestore database.
import Foundation // Import Foundation for basic functionality.

// ViewModel for managing the to-do list within the app.
class ToDoListVM: ObservableObject {
    @Published var showingNewItemView = false // A boolean published property to control the visibility of the new item view.
    
    private let userId: String // A private property to store the user ID associated with this list.
    
    // Initializer that sets the user ID upon creating an instance of ToDoListVM.
    init(userId: String) {
        self.userId = userId
    }
    
    // Function to delete a to-do list item from Firestore.
    /// - Parameter id: The unique identifier of the item to be deleted.
    func delete(id: String) {
        // Reference to the Firestore database.
        let db = Firestore.firestore()
        
        // Navigate to the specific document in the Firestore database and delete it.
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
}
