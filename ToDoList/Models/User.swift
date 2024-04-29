//  User.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import Foundation // Import the Foundation framework for basic functionality.

// Define a struct named User that conforms to the Codable protocol.
struct User: Codable {
    let id: String // A constant string to uniquely identify the user.
    let name: String // A constant string for the user's name.
    let email: String // A constant string for the user's email address.
    let joined: TimeInterval // A constant TimeInterval for when the user joined, stored as a Unix timestamp.
}
