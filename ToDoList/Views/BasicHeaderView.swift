//
//  CustomFormHeader.swift
//  ToDoList
//
//  Created by Taze Balbosa on 5/1/24.
//

import SwiftUI

struct BasicHeaderView: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 22))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.all, 10)
                .background(Color(red: 0.25, green: 0.25, blue: 0.25))
                .foregroundStyle(.white)
                .bold()
        }
    }
}

#Preview {
    BasicHeaderView(title: "Example")
}
