//
//  CustomFormHeader.swift
//  ToDoList
//
//  Created by Taze Balbosa on 5/1/24.
//

import SwiftUI

struct CustomFormHeader: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .textCase(nil)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .bold()
                .padding(.top, 25)
                .padding(.bottom, 5)
                .offset(x: 15)
        }
        .offset(x: -35)
    }
}

#Preview {
    CustomFormHeader(title: "Example")
}
