//  Extensions.swift
//  ToDoList
//
//  Created by Taze Balbosa on 4/16/24.
//

import Foundation // Import the Foundation framework for basic functionality.

// Extend the Encodable protocol to add new functionality to all Encodable types.
extension Encodable {
    // Define a function that converts an Encodable object into a dictionary representation.
    func asDictionary() -> [String: Any] {
        // Attempt to encode the object into JSON data.
        guard let data = try? JSONEncoder().encode(self) else {
            // If encoding fails, return an empty dictionary.
            return [:]
        }
        do {
            // Attempt to convert the JSON data into a dictionary.
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            // Return the dictionary if successful, or an empty dictionary if not.
            return json ?? [:]
        } catch {
            // If conversion to a dictionary fails, return an empty dictionary.
            return [:]
        }
    }
}
