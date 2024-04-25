//
//  NewItemView.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import SwiftUI

struct NewItemView: View {
    @StateObject var viewModel = NewItemVM()
    @Binding var newItemPresented: Bool
    
    var body: some View {
        VStack {
            Text("New Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 50)
            
            Form {
                // Title
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                // Due Date
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                // Button
                TLButton(title: "Save", 
                         foreground: .pink,
                         action: {
                    if viewModel.canSave {
                        viewModel.save()
                        newItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                })
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert, content: {
                Alert(
                    title: Text("Error"),
                    message: Text("Please fill in all fields and select due date that is today or newer.")
                )
            })
        }
    }
}

#Preview {
    NewItemView(newItemPresented: Binding(get: {return true}, set: {_ in}))

}
