//
//  ContactPicker.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 12/3/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI
import UIKit
import ContactsUI

struct ContactPicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var contact: Contact?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ContactPicker>) -> CNContactPickerViewController {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = context.coordinator
        // 2//        contactPicker
        contactPicker.predicateForEnablingContact = NSPredicate(format: "emailAddresses.@count > 0")
        print("Cool")
        return contactPicker
    }
    
    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: UIViewControllerRepresentableContext<ContactPicker>) {
        print("Hey man")
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, CNContactPickerDelegate {
        let parent: ContactPicker
        
        init(_ parent: ContactPicker) {
            self.parent = parent
        }
        
        func contactPicker(_ picker: CNContactPickerViewController,
                           didSelect contacts: [CNContact]) {
            let newFriends = contacts.compactMap { Contact(contact: $0) }
            
            parent.contact = newFriends.first
//            parent.presentationMode.wrappedValue.dismiss
            ()
        }
    }
}
