//
//  ToDoListItemsView.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import FirebaseFirestoreSwift
import SwiftUI

struct ToDoListView: View {
    @StateObject var viewModel: ToDoListVM
    @FirestoreQuery var items: [ToDoListItem]
    
    init(userId: String) {
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos"
        )
        
        self._viewModel = StateObject(wrappedValue: ToDoListVM(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    ToDoListItemView(item: item)
                        .swipeActions {
                            Button("Delete") {
                                // Action
                                viewModel.delete(id: item.id)
                            }
                            .tint(.red)
                        }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("To Do List")
            .toolbar {
                Button {
                    // Action
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $viewModel.showingNewItemView, content: {
                    NewItemView(newItemPresented: $viewModel.showingNewItemView)
                })
            }
        }
    }
}

#Preview {
    ToDoListView(userId: "VwM1Gz57zjT6t6UAXNHUP6MnUtB3")
}

