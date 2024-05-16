//  NewItemVM.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import FirebaseAuth // Import FirebaseAuth for user authentication services.
import FirebaseFirestore // Import FirebaseFirestore to interact with Firestore database.
import Foundation // Import Foundation for basic functionality.
import MapKit // Import MapKit to use map-related features.

// Define NewItemVM class conforming to ObservableObject to allow UI updates.
class NewItemVM: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var title = "" // Observable property for the title of the new to-do item.
    @Published var location = "" // Observable property for the location of the to-do item.
    @Published var locationResults: [MKLocalSearchCompletion] = [] // Observable property for search results.
    @Published var selectedOptions: Set<String> = [] // Observable property for the current selection of days.
    @Published var dueDate = Date() // Observable property for the due date of the new to-do item.
    @Published var isExpanded: Bool = false // Observable property for the current status of a collapsible list.
    @Published var showAlert = false // Observable property to control the alert presentation.
    private var locationCompleter: MKLocalSearchCompleter // Search completer object for location search.
    let options = ["Every Sunday", "Every Monday", "Every Tuesday", "Every Wednesday", "Every Thursday", "Every Friday", "Every Saturday"] // Options for repeating tasks.
    let abbrOptions: [String: String] = ["Every Sunday": "Sun", "Every Monday": "Mon", "Every Tuesday": "Tue", "Every Wednesday": "Wed", "Every Thursday": "Thur", "Every Friday": "Fri", "Every Saturday": "Sat"] // Mapping of full day names to abbreviations.
    let dayOrder = ["Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"] // The desired order of days to be displayed.
    let weekdays = Set(["Mon", "Tue", "Wed", "Thur", "Fri"]) // Set containing weekdays.
    let weekend = Set(["Sat", "Sun"]) // Set containing weekend days.    
    
    // Empty initializer for the class.
    override init() {
        locationCompleter = MKLocalSearchCompleter() // Initialize the location completer.
        super.init()
        locationCompleter.delegate = self // Set the delegate for the location completer.
        locationCompleter.resultTypes = .address // Set the result type to return addresses.
    }
    
    // Delegate method called when the location completer updates results.
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            self.locationResults = completer.results // Update the location results.
        }
    }
    
    // Delegate method called when the location completer fails with an error.
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: any Error) {
        // Handle the error appropriately.
    }
    
    // Method to handle changes in the search text field.
    func onSearchTextChanged(_ query: String) {
        locationCompleter.queryFragment = query // Update the query fragment for the location completer.
    }
    
    // Function to clear the location search results.
    func clearLocationResults() {
        locationResults = [] // Clear the current location results.
    }
    
    // Function to handle day(s) selection for repeating tasks.
    func selectOption(_ option: String) {
        if selectedOptions.contains(option) {
            selectedOptions.remove(option) // Remove the option if it's already selected.
        } else {
            selectedOptions.insert(option) // Add the option if it's not selected.
        }
    }
    
    // Function to create a label with current selected options for repeating tasks.
    var selectedOptionsLabel: String {
        let everyday = Set(dayOrder) // Set containing all days for "Everyday" option.
        
        // Sort the current options based on the predefined day order.
        var sortedCurrentOptions = selectedOptions.compactMap { abbrOptions[$0] }.sorted {
            guard let firstIndex = dayOrder.firstIndex(of: $0),
                  let secondIndex = dayOrder.firstIndex(of: $1) else {
                return false
            }
            return firstIndex < secondIndex
        }
        
        // Determine the label based on the selected options.
        if selectedOptions.isEmpty {
            return "Never" // No days selected.
        } else if Set(sortedCurrentOptions) == everyday {
            return "Everyday" // All days selected.
        } else if Set(sortedCurrentOptions) == weekdays {
            return "Weekdays" // Only weekdays selected.
        } else if Set(sortedCurrentOptions) == weekend {
            return "Weekends" // Only weekend days selected.
        } else {
            // For custom selection of days, join them with commas.
            if sortedCurrentOptions.count > 1 {
                let lastOption = sortedCurrentOptions.removeLast()
                return sortedCurrentOptions.joined(separator: ", ") + ", and " + lastOption
            } else {
                return sortedCurrentOptions.first ?? ""
            }
        }
    }
    
    // Function to toggle the expansion state of the collapsible list.
    func toggleDisclosure() {
        isExpanded.toggle() // Toggle the boolean state of isExpanded.
    }
    
    // Function to save a new to-do item to the Firestore database.
    func save() {
        // Check if the new item can be saved based on certain conditions.
        guard canSave else {
            showAlert = true // Show an alert if conditions are not met.
            return
        }
        
        // Retrieve the current user's ID from FirebaseAuth.
        guard let uId = Auth.auth().currentUser?.uid else {
            showAlert = true // Show an alert if user ID is not available.
            return
        }
        
        // Create a unique identifier for the new to-do item.
        let newId = UUID().uuidString
        // Initialize a new to-do item with the given properties.
        let newItem = ToDoListItem(
            id: newId,
            title: title,
            dueDate: dueDate.timeIntervalSince1970, // Convert Date to TimeInterval for storage.
            createdDate: Date().timeIntervalSince1970, // Store the current time as the creation date.
            isDone: false // Initialize as not done.
        )
        
        // Reference to the Firestore database.
        let db = Firestore.firestore()
        // Save the new to-do item in the Firestore database under the current user's collection.
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(newId)
            .setData(newItem.asDictionary()) // Convert the to-do item to a dictionary for storage.
    }
    
    // Computed property to determine if the new to-do item can be saved.
    var canSave: Bool {
        // Ensure the title is not empty after trimming whitespace.
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        // Ensure the due date is not set in the past.
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        
        // If all conditions are met, return true.
        return true
    }
}
