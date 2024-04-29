//  ToDoListItemView.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import SwiftUI // Import the SwiftUI framework for UI elements.

// Define a struct named ToDoListItemView that conforms to the View protocol.
struct ToDoListItemView: View {
    @StateObject var viewModel = ToDoListItemVM() // Create a state object of the ToDoListItemVM ViewModel.
    let item: ToDoListItem // Constant to hold the to-do list item passed to this view.
    
    // The body property represents the view's content.
    var body: some View {
        // Use an HStack to arrange subviews horizontally.
        HStack {
            // Use a VStack to arrange title and due date vertically and aligned to the leading edge.
            VStack(alignment: .leading, content: {
                // Display the title of the to-do item.
                Text(item.title)
                    .font(.body) // Set the font for the body text.
                // Display the formatted due date of the to-do item.
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote) // Set the font for the footnote text.
                    .foregroundColor(Color(.secondaryLabel)) // Set the color to the secondary label color.
            })
            Spacer() // Push the content to the leading edge and the button to the trailing edge.
            
            // Button to toggle the 'isDone' status of the to-do item.
            Button {
                // Call the toggleIsDone function in the ViewModel when tapped.
                viewModel.toggleIsDone(item: item)
            } label: {
                // Display a checkmark or circle image based on the 'isDone' status.
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle" )
                    .foregroundColor(Color.blue) // Set the image color to blue.
            }
        }
    }
}

// Preview provider for the ToDoListItemView.
#Preview {
    ToDoListItemView(item: .init(
        id: "123", // Example item ID.
        title: "Get milk", // Example item title.
        dueDate: Date().timeIntervalSince1970, // Example due date set to the current time.
        createdDate: Date().timeIntervalSince1970, // Example creation date set to the current time.
        isDone: true // Example 'isDone' status set to true.
    ))
}
