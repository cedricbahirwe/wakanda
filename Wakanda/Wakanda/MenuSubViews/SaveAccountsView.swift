//
//  SaveAccountsView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 12/2/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI

struct SaveAccountsView: View {
    var body: some View {
        VStack(spacing: 0) {
            ColoredHeader("Save Accounts")
            VStack(alignment: .leading) {
                AccountRow(title: "Number", placeholder: "Enter number", value: .constant(""))
                AccountRow(title: "Label", placeholder: "Enter label e.g home", keyboardType: .namePhonePad, value: .constant(""))
                
                HStack(spacing: 30) {
                    Text("Category")
                        .frame(width: 60, alignment: .leading)
                    HStack(spacing: 16) {
                        Text("Select")
                        Image(systemName: "arrowtriangle.down.fill")
                    }
                }
                .padding(5)
                
                Button(action: {}) {
                    Text("Save")
                        .foregroundColor(.white)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Color(red: 0.008, green: 0.087, blue: 0.254))
                        .cornerRadius(8)
                }
                .padding(.vertical)
                 Spacer()
            }
            .padding()
            .background(Color.secondaryBgColor
            .onTapGesture {
                self.hideKeyboard()
            })
            
           
        }
        .font(.footnote)
    }
}

struct SaveAccountsView_Previews: PreviewProvider {
    static var previews: some View {
        SaveAccountsView()
    }
}

struct AccountRow: View {
    let title: String
    let placeholder: String
    var keyboardType: UIKeyboardType = .phonePad
    @Binding var value: String
    
    var body: some View {
        HStack(spacing: 30) {
            Text(title)
                .frame(width: 60, alignment: .leading)
            TextField(placeholder, text: $value)
                .foregroundColor(Color.gray)
                .keyboardType(keyboardType)
        }
        .padding(5)
        
    }
}
