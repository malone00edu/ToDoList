//  NewItemVM.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import FirebaseAuth // Import FirebaseAuth for user authentication services.
import FirebaseFirestore // Import FirebaseFirestore to interact with Firestore database.
import Foundation // Import Foundation for basic functionality.
import MapKit

// Define NewItemVM class conforming to ObservableObject to allow UI updates.
class NewItemVM: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var title = "" // Observable property for the title of the new to-do item.
    @Published var location = "" // Observable property for the location of the to-do item.
    @Published var locationResults: [MKLocalSearchCompletion] = []
    private var locationCompleter: MKLocalSearchCompleter
    @Published var selectedOptions: Set<String> = [] // Observable property for the current selection of days.
    @Published var isExpanded: Bool = false // Obervable property for the current status of a collapsible list.
    let options = ["Every Sunday", "Every Monday", "Every Tuesday", "Every Wednesday", "Every Thursday", "Every Friday", "Every Saturday"]
    @Published var dueDate = Date() // Observable property for the due date of the new to-do item.
    @Published var showAlert = false // Observable property to control the alert presentation.
    
    // Empty initializer for the class.
    override init() {
        locationCompleter = MKLocalSearchCompleter()
        super.init()
        locationCompleter.delegate = self
        locationCompleter.resultTypes = .address
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            self.locationResults = completer.results
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: any Error) {
        // Handle the error
    }
    
    func onSearchTextChanged(_ query: String) {
        locationCompleter.queryFragment = query
    }
    
    // Function to clear the location search results
    func clearLocationResults() {
        locationResults = []
    }
    
    // Function to handle day(s) selection
    func selectOption(_ option: String) {
        if selectedOptions.contains(option) {
            selectedOptions.remove(option)
        } else {
            selectedOptions.insert(option)
        }
    }
    
    // Function to handle collapse selection
    func toggleDisclosure() {
        isExpanded.toggle()
    }
    
    // Function to save a new to-do item.
    func save() {
        // Check if the new item can be saved based on certain conditions.
        guard canSave else {
            return
        }
        
        // Retrieve the current user's ID from FirebaseAuth.
        guard let uId = Auth.auth().currentUser?.uid else {
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
