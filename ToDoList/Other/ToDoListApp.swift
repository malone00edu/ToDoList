//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/14/24.
//
import FirebaseCore
import SwiftUI

@main
struct ToDoListApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
