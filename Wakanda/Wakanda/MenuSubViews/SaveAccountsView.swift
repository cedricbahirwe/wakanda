//
//  SaveAccountsView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 12/2/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI

struct SaveAccountsView: View {
    
    @State private var accountCategories: [String] = ["Select", "Electricity", "Water", "Bank", "TV", "Momo Pay", "Tap&Go"]
    @State private var showDropDown = false
    var body: some View {
        VStack(spacing: 0) {
            ColoredHeader("Save Accounts")
            VStack(alignment: .leading) {
                AccountRow(title: "Number", placeholder: "Enter number", keyboardType: .numberPad,contentType: .telephoneNumber, value: .constant(""))
                AccountRow(title: "Label", placeholder: "Enter label e.g home", value: .constant(""))
                
                ZStack(alignment: .top) {
                    HStack(alignment: .top, spacing: 30) {
                        Text("Category").frame(width: 60, alignment: .leading)
                        CategoriesDropDown(categories: $accountCategories, showDropDown: $showDropDown)
                    }
                    .padding(5)
                    .zIndex(1)
                    
                    Button(action: {}) {
                        Text("Save")
                            .foregroundColor(.white)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color(red: 0.008, green: 0.087, blue: 0.254))
                            .cornerRadius(8)
                    }
                    .offset(y: 65)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.secondaryBgColor.edgesIgnoringSafeArea(.bottom)
            .onTapGesture {
                self.hideKeyboard()
            })
            
            
        }
        .font(.footnote)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct SaveAccountsView_Previews: PreviewProvider {
    static var previews: some View {
        SaveAccountsView()
//            .environment(\.colorScheme, .dark)
    }
}
struct CategoriesDropDown: View {
    @Binding var categories: [String]
    @State var selectedCategory: [String] = ["Select"]
    @Binding var showDropDown: Bool
    
    init(categories: Binding<[String]>, showDropDown: Binding<Bool>) {
        _categories = categories
        _showDropDown = showDropDown
        self.selectedCategory =  [_categories.wrappedValue.first!]
    }
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(showDropDown ? categories : selectedCategory, id: \.self)  { category in
                Text(category).padding(self.showDropDown ? 10 : 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.selectedCategory = [category]
                        withAnimation(.spring()) {
                            self.showDropDown.toggle()
                        }
                }
            }
        }
        .frame(maxWidth: size.width/1.5, alignment: .leading)
        .background(showDropDown ? Color(.systemBackground) : .secondaryBgColor)
        .shadow(radius: showDropDown ? 3 : 0)
        
    }
}

struct AccountRow: View {
    let title: String
    let placeholder: String
    var keyboardType: UIKeyboardType = .default
    var contentType: UITextContentType = .name
    @Binding var value: String
    
    var body: some View {
        HStack(spacing: 30) {
            Text(title)
                .frame(width: 60, alignment: .leading)
            TextField(placeholder, text: $value)
                .foregroundColor(Color.gray)
                .keyboardType(keyboardType)
                .textContentType(contentType)
        }
        .padding(5)
    }
}

