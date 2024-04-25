//
//  RegisterView.swift
//  ToDoList
//
//  Created by Taze Balbosa on 3/30/24.
//

import SwiftUI

struct RegisterView: View {

    @StateObject var viewModel = RegisterVM()
    
    var body: some View {
        // Header
        HeaderView(title: "Register", 
                   subtitle: "Start organizing todos",
                   angle: -15,
                   foreground: .orange)
        Form {
            TextField("Full Name", text: $viewModel.name)
                .textFieldStyle(DefaultTextFieldStyle())
            TextField("Email Address", text: $viewModel.email)
                .textFieldStyle(DefaultTextFieldStyle())
                .autocapitalization(.none)
                .autocorrectionDisabled()
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(DefaultTextFieldStyle())
            
            TLButton(title: "Create Account",
                     foreground: .green,
                     action: {
                //Attempt log in
                viewModel.register()
            })
            .padding()
        }
        .offset(y: -50)
        
        Spacer()
    }
}

#Preview {
    RegisterView()
}
