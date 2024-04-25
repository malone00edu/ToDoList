//
//  TLButton.swift
//  ToDoList
//
//  Created by Taze Balbosa on 4/16/24.
//

import SwiftUI

struct TLButton: View {
    let title: String
    let foreground: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            // Action
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(foreground)
                Text(title)
                    .foregroundColor(Color.white)
                    .bold()
            }
        }
    }
}

#Preview {
    TLButton(title: "Value",
             foreground: .pink) {
        // Action
    }
}
