//
//  ProfileView.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileVM()
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    Text("Loading Profile...")
                        .offset(y: -100)
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
    
    @ViewBuilder
    func profile(user: User) -> some View {
        // Avatar
        Image(systemName: "person.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color.blue)
            .frame(width: 125, height: 125)
            .padding()
        
        // Info: Name, Email, Member since
        VStack(alignment: .leading, content: {
            HStack {
                Text("Name: ")
                    .bold()
                Text(user.name)
            }
            .padding()
            HStack {
                Text("Email: ")
                    .bold()
                Text(user.email)
            }
            .padding()
            HStack {
                Text("Member Since: ")
                    .bold()
                Text("\(Date(timeIntervalSince1970:user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
            .padding()
        })
        
        // Log out
        Button("Log Out") {
            viewModel.logOut()
        }
        .tint(.red)
        .padding()
        Spacer()
    }
}

#Preview {
    ProfileView()
}
