//
//  CustomPasswordField.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 11/5/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import Foundation
import SwiftUI


struct CustomPasswordField: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    @Binding var isEditingPassword: Bool
    var color: UIColor
    
    func makeUIView(context: UIViewRepresentableContext<CustomPasswordField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = true
        textField.textColor = color
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textContentType = .password
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomPasswordField>) {
        uiView.text = text
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    func makeCoordinator() -> CustomPasswordField.Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomPasswordField
        
        init(parent: CustomPasswordField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.isEditingPassword = true
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.text = textField.text ?? ""
            if textField.text?.isEmpty ?? false {
                UIView.animate(withDuration: 0.2) {
                    self.parent.isEditingPassword = false
                }
            }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if string == " " {
                return false
            } else {
                return true
            }
        }
    }
}
