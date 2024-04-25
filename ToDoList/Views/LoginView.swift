//
//  LoginView.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import SwiftUI
 
struct LoginView: View {
    @StateObject var viewModel = LoginVM()
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(title: "To Do List", 
                           subtitle: "Get things done",
                           angle: 15,
                           foreground: .pink)
                
                // Login Form
                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    TLButton(title: "Log In",
                             foreground: .blue,
                             action: {
                        //Attempt log in
                        viewModel.login()
                    })
                    .padding()
                    
                    /*Button {
                        // Attept log in
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.blue)
                            Text("Log In")
                                .foregroundColor(Color.white)
                                .bold()
                        }
                    }
                    .padding(.horizontal, 0) */
                }
                .offset(y: -50)
                
                // Create Account
                VStack {
                    Text("New around here?")
                    NavigationLink("Create an account", destination: RegisterView())
                }
                .padding(.bottom, 50)
                
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
