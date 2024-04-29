//  NewItemView.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import SwiftUI // Import the SwiftUI framework for UI elements.

// Define a struct named NewItemView that conforms to the View protocol.
struct NewItemView: View {
    @StateObject var viewModel = NewItemVM() // Create a state object of the NewItemVM ViewModel.
    @Binding var newItemPresented: Bool // A binding to control the presentation of the new item view.
    
    // The body property represents the view's content.
    var body: some View {
        // Use a VStack to arrange subviews vertically.
        VStack {
            // Text header for the new item view.
            Text("New Item")
                .font(.system(size: 32)) // Set the font size to 32.
                .bold() // Make the text bold.
                .padding(.top, 50) // Add padding to the top.
            
            // Form for the new item input fields.
            Form {
                // Text field for the new item's title.
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle()) // Apply the default text field style.
                
                // Date picker for selecting the due date of the new item.
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle()) // Apply the graphical date picker style.
                
                // Custom button to save the new item.
                TLButton(title: "Save",
                         foreground: .pink, // Set the button text color to pink.
                         action: {
                    // Check if the new item can be saved.
                    if viewModel.canSave {
                        // Call the save function in the ViewModel.
                        viewModel.save()
                        // Dismiss the new item view.
                        newItemPresented = false
                    } else {
                        // Show an alert if the item cannot be saved.
                        viewModel.showAlert = true
                    }
                })
                .padding() // Add padding around the button.
            }
            // Alert to be presented if there is an error.
            .alert(isPresented: $viewModel.showAlert, content: {
                Alert(
                    title: Text("Error"), // Title of the alert.
                    message: Text("Please fill in all fields and select due date that is today or newer.") // Alert message.
                )
            })
        }
    }
}

// Preview provider for the NewItemView.
#Preview {
    NewItemView(newItemPresented: Binding(get: {return true}, set: {_ in}))
}

