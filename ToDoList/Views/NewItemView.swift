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
    @FocusState private var isTitleFieldFocused: Bool
    @FocusState private var isLocationFieldFocused: Bool
    
    // The body property represents the view's content.
    var body: some View {
        // Use a VStack to arrange subviews vertically.
        VStack {
            // Form for the new item input fields.
            Form {
                // Text field for the new item's title.
                Section(header: CustomFormHeader(title: "Create a task")) {
                    TextField("Title", text: $viewModel.title)
                        .focused($isTitleFieldFocused)
                        .onChange(of: isTitleFieldFocused) { _, newValue in
                            if newValue { // This textfield is currently focused.
                                viewModel.clearLocationResults()
                            }
                        }
                        .textFieldStyle(DefaultTextFieldStyle()) // Apply the default text field style.
                    
                    // Text field for the new item's location (optional).
                    TextField("Location (Optional)", text: $viewModel.location)
                        .focused($isLocationFieldFocused)
                        .onChange(of: viewModel.location, initial: true) {_, newValue in
                            viewModel.onSearchTextChanged(newValue)
                            if viewModel.location.isEmpty {
                                viewModel.clearLocationResults()
                            }
                        }
                    
                    List {
                        if viewModel.locationResults.isEmpty {
                            EmptyView() // This will show nothing, effectively contracting the list.
                        } else {
                            // Code to show current search results.
                            ForEach(viewModel.locationResults.prefix(3), id: \.self) { result in
                                VStack(alignment: .leading) {
                                    Text(result.title)
                                    Text(result.subtitle).font(.subheadline).foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                
                Section {
                    // List of days. None is selected by default.
                    List {
                        DisclosureGroup("Repeat this task", isExpanded: $viewModel.isExpanded) { // List is collapsed by default.
                            ForEach(viewModel.options, id: \.self) { option in
                                Toggle(isOn: Binding(
                                    get: {viewModel.selectedOptions.contains(option)},
                                    set: {_ in viewModel.selectOption(option)})) {
                                        Text(option)
                                    }
                            }
                        }
                    }
                    .onAppear {
                        viewModel.isExpanded = false
                    }
                    .onChange(of: viewModel.isExpanded) {
                        viewModel.clearLocationResults()
                        hideKeyboard()
                    }
                }
                
                // If the list of options is empty, show the calendar and time options.
                if viewModel.selectedOptions.isEmpty {
                    // Date picker for selecting the due date of the new item.
                    DatePicker("Due Date", selection: $viewModel.dueDate)
                        .datePickerStyle(GraphicalDatePickerStyle()) // Apply the graphical date picker style.
                } else { // Else show the time option only.
                    DatePicker("Time", selection: $viewModel.dueDate, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section {
                    HStack {
                        Spacer()
                        // Custom button to save the new item.
                        Button(action: {
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
                        }) {
                            Text("Save")
                                .foregroundColor(.blue)
                                .bold()
                        }
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // Stretch the form to fill the VStack.
            .offset(y: -30)
            .edgesIgnoringSafeArea(.all)
            .simultaneousGesture(DragGesture().onChanged({_ in
                hideKeyboard()
            })) // Dectect when user starts scrolling.
            
            // Alert to be presented if there is an error.
            .alert(isPresented: $viewModel.showAlert, content: {
                Alert(
                    title: Text("Error"), // Title of the alert.
                    message: Text("Please fill in all mandatory fields and select a future due date.") 
                )
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .edgesIgnoringSafeArea(.all)
    }
    
    private func hideKeyboard() {
        isTitleFieldFocused = false
        isLocationFieldFocused = false
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}

// Preview provider for the NewItemView.
#Preview {
    NewItemView(newItemPresented: Binding(get: {return true}, set: {_ in}))
}

