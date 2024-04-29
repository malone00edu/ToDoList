//  ToDoListItemVM.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import FirebaseFirestore // Import FirebaseFirestore to interact with Firestore database.
import FirebaseAuth // Import FirebaseAuth for user authentication services.
import Foundation // Import Foundation for basic functionality.

// Define ToDoListItemVM class conforming to ObservableObject to allow UI updates.
class ToDoListItemVM: ObservableObject {
    // Empty initializer for the class.
    init() {}
    
    // Function to toggle the 'isDone' status of a to-do item.
    func toggleIsDone(item: ToDoListItem) {
        // Create a mutable copy of the item to modify.
        var itemCopy = item
        // Toggle the 'isDone' status of the item.
        itemCopy.setDone(!item.isDone)
        
        // Retrieve the current user's ID from FirebaseAuth.
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Reference to the Firestore database.
        let db = Firestore.firestore()
        // Update the to-do item in the Firestore database with the new 'isDone' status.
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary()) // Convert the to-do item to a dictionary for storage.
    }
}
