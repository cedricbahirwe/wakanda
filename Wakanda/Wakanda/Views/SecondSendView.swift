//
//  SecondSendView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 12/7/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI

struct SecondSendView: View {
    @State private var showContactPicker = false
    @State private var allContacts: [Contact] = []
    @State private var selectedContact: Contact = .init(names: "", phoneNumbers: [])
    var body: some View {
        ContainerView(showBackButton: true, title: "Send Money") {
            VStack(spacing: 20) {
                TextField("Enter Amount", text: .constant("Enter Amount"))
                    .keyboardType(.numberPad)
                    .foregroundColor(.gray)
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 0.5))
                    .font(.footnote)
                
                TextField("Enter Receiver's Number", text: $selectedContact.phoneNumbers.firstElement)
                    .keyboardType(.numberPad)
                    .textContentType(.telephoneNumber)
                    .foregroundColor(.gray)
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 0.5))
                    .font(.footnote)
                
                HStack {
                    Button(action: {
                        allContacts = phoneNumberWithContryCode()
                        showContactPicker.toggle()
                    }) {
                        HStack {
                            Image(systemName: "person.fill")
                            Text("Pick a Contact").bold().font(.footnote)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color(.systemBackground))
                        .cornerRadius(8)
                        .shadow(color: Color(.darkGray), radius: 1, x: 2, y: 2)
                        .foregroundColor(Color(red: 0.008, green: 0.087, blue: 0.254))
                    }
                    
                    Button(action: {
                        allContacts = phoneNumberWithContryCode()
                        showContactPicker.toggle()
                    }) {
                        HStack {
                            Image(systemName: "qrcode")
                            Text("Scan code").bold().font(.footnote)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color(.systemBackground))
                        .cornerRadius(8)
                        .shadow(color: Color(.darkGray), radius: 1, x: 2, y: 2)
                        .foregroundColor(Color(red: 0.008, green: 0.087, blue: 0.254))
                    }
                }
                
                
                Button(action: {}) {
                    Text("Submit").bold().font(.footnote)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color(.systemBackground))
                        .cornerRadius(8)
                        .shadow(color: Color(.darkGray), radius: 1, x: 2, y: 2)
                        .foregroundColor(.black)
                }
                
                Spacer()
            }.padding(.top)
        }
        .poppableView()
        .sheet(isPresented: $showContactPicker) {
            ContactsList(allContacts: $allContacts, selectedContact: $selectedContact)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct SecondSendView_Previews: PreviewProvider {
    static var previews: some View {
        SecondSendView()
    }
}
