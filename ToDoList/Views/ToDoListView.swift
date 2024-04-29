//  ToDoListView.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import FirebaseFirestoreSwift // Import FirebaseFirestoreSwift to use Firestore features with Swift.
import SwiftUI // Import the SwiftUI framework for UI elements.

// Define a struct named ToDoListView that conforms to the View protocol.
struct ToDoListView: View {
    @StateObject var viewModel: ToDoListVM // Create a state object of the ToDoListVM ViewModel.
    @FirestoreQuery var items: [ToDoListItem] // Use FirestoreQuery to fetch to-do list items.
    
    // Initialize the view with a specific user ID.
    init(userId: String) {
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos" // Set the Firestore collection path for the user's to-do items.
        )
        
        self._viewModel = StateObject(wrappedValue: ToDoListVM(userId: userId)) // Initialize the ViewModel with the user ID.
    }
    
    // The body property represents the view's content.
    var body: some View {
        // Use a NavigationView to enable navigation between views.
        NavigationView {
            // Use a VStack to arrange subviews vertically.
            VStack {
                // Create a list of to-do items.
                List(items) { item in
                    // For each item, create a view to display it.
                    ToDoListItemView(item: item)
                        .swipeActions {
                            // Add swipe actions to each item.
                            Button("Delete") {
                                // Define the action to delete the item when the button is tapped.
                                viewModel.delete(id: item.id)
                            }
                            .tint(.red) // Set the tint color of the delete button to red.
                        }
                }
                .listStyle(PlainListStyle()) // Apply the plain list style.
            }
            .navigationTitle("To Do List") // Set the navigation bar title.
            .toolbar {
                // Add a button to the toolbar.
                Button {
                    // Define the action to show the new item view when the button is tapped.
                    viewModel.showingNewItemView = true
                } label: {
                    // Set the label of the button to a plus image.
                    Image(systemName: "plus")
                }
                // Present the NewItemView as a sheet when the button is tapped.
                .sheet(isPresented: $viewModel.showingNewItemView, content: {
                    NewItemView(newItemPresented: $viewModel.showingNewItemView)
                })
            }
        }
    }
}

// Preview provider for the ToDoListView.
#Preview {
    ToDoListView(userId: "VwM1Gz57zjT6t6UAXNHUP6MnUtB3") // Example user ID for preview.
}
