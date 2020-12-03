//
//  SendingView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 12/3/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI
import ContactsUI

struct ContactModel: Identifiable {
    var id = UUID()
    var names: String
    var phoneNumbers: [String]
}
struct SendingView: View {
    @State private var showContactPicker = false
    @State private var contact: Contact? = nil
    @State private var contactStore = CNContactStore()
    @State private var contacts: [String] = []
    @State private var allContacts: [ContactModel] = []
    var body: some View {
        ContainerView(showBackButton: true, title: "For Others") {
            VStack(spacing: 20) {
                TextField("Enter Amount", text: .constant("Enter Amount"))
                    .keyboardType(.numberPad)
                    .foregroundColor(.gray)
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 0.5))
                    .font(.footnote)
                
                
                Button(action: {
                    self.showContactPicker.toggle()
                    self.fetchContacts()
                    self.contacts = self.phoneNumberWithContryCode()
                }) {
                    HStack {
                        Image(systemName: "person.fill")
                        Text("Contact").bold().font(.footnote)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(Color(.systemBackground))
                    .cornerRadius(8)
                    .shadow(color: Color(.darkGray), radius: 1, x: 2, y: 2)
                    .foregroundColor(Color(red: 0.008, green: 0.087, blue: 0.254))
                }
                
                TextField("Enter Mobile Number", text: .constant("Enter Mobile Number"))
                    .keyboardType(.numberPad)
                    .textContentType(.telephoneNumber)
                    .foregroundColor(.gray)
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 0.5))
                    .font(.footnote)
                
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
        .sheet(isPresented: self.$showContactPicker) {
            VStack {
                List(self.allContacts) { contact in
                    VStack {
                        Text(contact.names)
                        ForEach(contact.phoneNumbers, id: \.self) { phoneNumber in
                            Text(phoneNumber)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    private func fetchContacts() {
        var contacts = [CNContact]()
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
        let request = CNContactFetchRequest(keysToFetch: keys)

        do {
            try self.contactStore.enumerateContacts(with: request) {
                (contact, stop) in
                print(contact, "Gotten")
                // Array containing all unified contacts from everywhere
                contacts.append(contact)
            }
        }
        catch {
            print("unable to fetch contacts")
        }
    }
    
    func phoneNumberWithContryCode() -> [String] {

        let contacts = PhoneContacts.getContacts() // here calling the getContacts methods
        for contact in contacts {
            if contact.phoneNumbers.count > 0  {
                let contactPhoneNumbers = contact.phoneNumbers
                let mtnNumbers = contactPhoneNumbers.filter { $0.label != ""
//                    $0.value.stringValue.hasPrefix("078") ||
//                    $0.value.stringValue.hasPrefix("+250") ||
//                    $0.value.stringValue.hasPrefix("250")
                }
                
                let numbers = mtnNumbers.map{ $0.value.stringValue }
                
                let newContact = ContactModel(names:contact.givenName + contact.familyName,phoneNumbers: numbers)
                
                self.allContacts.append(newContact)
                
            }
            
        }
        var arrPhoneNumbers = [String]()
        for contact in contacts {
            for ContctNumVar: CNLabeledValue in contact.phoneNumbers {
                let fulMobNumVar  = ContctNumVar.value
                    
                print("The full", fulMobNumVar.stringValue)
                    //let countryCode = fulMobNumVar.value(forKey: "countryCode") get country code
                       if let MccNamVar = fulMobNumVar.value(forKey: "digits") as? String {
                            arrPhoneNumbers.append(MccNamVar)
                    }
//                }
            }
        }
        return arrPhoneNumbers // here array has all contact numbers.
    }
}

struct SendingView_Previews: PreviewProvider {
    static var previews: some View {
        SendingView()
    }
}


enum ContactsFilter {
    case none
    case mail
    case message
}

class PhoneContacts {

    class func getContacts(filter: ContactsFilter = .none) -> [CNContact] { //  ContactsFilter is Enum find it below

        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactThumbnailImageDataKey] as [Any]

        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }

        var results: [CNContact] = []

        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)

            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch {
                print("Error fetching containers")
            }
        }
        return results
    }
}
