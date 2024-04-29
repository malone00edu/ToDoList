//  ToDoListItem.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import Foundation // Import the Foundation framework for basic functionality.

// Define a struct named ToDoListItem that conforms to Codable and Identifiable protocols.
struct ToDoListItem: Codable, Identifiable {
    let id: String // A constant string to uniquely identify the to-do item.
    let title: String // A constant string for the title of the to-do item.
    let dueDate: TimeInterval // A constant TimeInterval for the due date, stored as a Unix timestamp.
    let createdDate: TimeInterval // A constant TimeInterval for the creation date, stored as a Unix timestamp.
    var isDone: Bool // A variable boolean to track whether the to-do item is done.
    
    // Define a mutating function to change the isDone status of the to-do item.
    mutating func setDone(_ state: Bool) {
        isDone = state // Set the isDone property to the new state passed in the function.
    }
}
