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
    @State private var selectedContact: ContactModel = .init(names: "", phoneNumbers: [])
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
                
                TextField("Enter Mobile Number", text: self.$selectedContact.phoneNumbers.firstElement)
                    .keyboardType(.numberPad)
                    .textContentType(.telephoneNumber)
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
                    print(self.allContacts)
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
            ContactsList(allContacts: self.$allContacts, selectedContact: self.$selectedContact)
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
        
        let contacts = PhoneContacts.getContacts()
        for contact in contacts {
            if contact.phoneNumbers.count > 0  {
                let contactPhoneNumbers = contact.phoneNumbers
                let mtnNumbers = contactPhoneNumbers.filter { $0.label != ""
                    //                    $0.value.stringValue.hasPrefix("078") ||
                    //                    $0.value.stringValue.hasPrefix("+250") ||
                    //                    $0.value.stringValue.hasPrefix("250")
                }
                
                let numbers = mtnNumbers.map{ $0.value.stringValue }
                
                let newContact = ContactModel(names:contact.givenName + " " +  contact.familyName,phoneNumbers: numbers)
                
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


struct ContactsList: View {
    @Binding var allContacts: [ContactModel]
    @Binding var selectedContact: ContactModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Text("Contacts").font(.largeTitle).bold()
            List(self.allContacts.sorted(by: { $0.names < $1.names })) { contact in
                VStack(alignment: .leading) {
                    Text(contact.names).font(.system(size: 18)).fontWeight(.semibold)
                    ForEach(contact.phoneNumbers, id: \.self) { phoneNumber in
                        Text(phoneNumber).foregroundColor(.mainFgColor)
                    }.padding(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    self.selectedContact = contact
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}
#if DEBUG
struct SendingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SendingView()
            ContactsList(allContacts: .constant([Wakanda.ContactModel(names: "Kate Bell", phoneNumbers: ["(555) 564-8583", "(415) 555-3695"]), Wakanda.ContactModel(names: "Daniel Higgins", phoneNumbers: ["555-478-7672", "(408) 555-5270", "(408) 555-3514"]), Wakanda.ContactModel(names: "John Appleseed", phoneNumbers: ["888-555-5512", "888-555-1212"]), Wakanda.ContactModel(names: "Anna Haro", phoneNumbers: ["555-522-8243"]), Wakanda.ContactModel(names: "Hank Zakroff", phoneNumbers: ["(555) 766-4823", "(707) 555-1854"]), Wakanda.ContactModel(names: "David Taylor", phoneNumbers: ["555-610-6679"])]), selectedContact: .constant(ContactModel(names: "Kate Bell", phoneNumbers: ["(555) 564-8583", "(415) 555-3695"])))
        }
    }
}
#endif


enum ContactsFilter {
    case none
    case mail
    case message
}

class PhoneContacts {
    
    class func getContacts(filter: ContactsFilter = .none) -> [CNContact] {
        
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

extension String {
    var isMtnNumber: Bool {
        return
            self.trimmingCharacters(in: .whitespaces).hasPrefix("+25078") ||
                self.trimmingCharacters(in: .whitespaces).hasPrefix("25078") ||
                self.trimmingCharacters(in: .whitespaces).hasPrefix("078") ||
                self.hasPrefix("")
    }
}


extension Array where Element == String  {
    var firstElement: String {
        get { return self.first ?? "" }
        set(value) { self[0] = value }
    }
}
