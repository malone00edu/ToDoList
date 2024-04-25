//
//  ToDoListItemVM.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import FirebaseFirestore
import FirebaseAuth
import Foundation

class ToDoListItemVM: ObservableObject {
    init() {}
    
    func toggleIsDone(item: ToDoListItem) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
}
