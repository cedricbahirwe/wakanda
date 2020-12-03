//
//  LoginPageView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 11/5/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI

struct LoginPageView: View {
    @State var didBeginEmailEditing = false
    @State var isEditingPassword = false
    @State var email = ""
    @State var password : String = ""
    
    @State var bashGradient = LinearGradient(gradient: Gradient(colors: [.yellow, .green, .purple, Color.red.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    private var validateEmail: Bool{
        if email == ""{
            return true
        } else{
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }
    }
    
    private var validatePassword: Bool{
        if password == "" {
            return true
        } else{
            return password.count >= 8
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 80) {
            VStack(alignment: .leading) {
                Text("Welcome to")
                Text("WAKANDA!")
                }
            .font(.system(size: 30, weight: .heavy, design: .rounded))
            VStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Email")
                        .opacity(self.didBeginEmailEditing ? 0.6 : 1)
                        .offset(x: 0, y: self.didBeginEmailEditing ? 0 : 20)
                    TextField("", text: self.$email, onEditingChanged: { editing in
                        if editing {
                            withAnimation {
                                self.didBeginEmailEditing = editing
                            }
                        }
                    }, onCommit: {
                        print("Commi")
                        if self.email.isEmpty {
                            withAnimation {
                                self.didBeginEmailEditing = false
                            }
                        }
                    }).disableAutocorrection(true)
                        .overlay(Rectangle().fill(self.validateEmail ? Color.mainFgColor : .red).frame(height: 1).offset(y: 5), alignment: .bottom)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Password")
                        .opacity(self.isEditingPassword ? 0.6 : 1)
                        .offset(x: 0, y: self.isEditingPassword ? 0 : 20)
                    CustomPasswordField(text: self.$password, placeholder: "", isEditingPassword: $isEditingPassword, color: UIColor(red: 0.201, green: 0.238, blue: 0.58, alpha: 1))
                        .overlay(Rectangle()
                            .fill(self.validatePassword ? Color.mainFgColor : .red)
                            
                            .frame(height: 1)
                            .offset(y: 5)
                            , alignment: .bottom)
                }
                
                HStack {
                    Text("Sign in")
                        .font(.system(size: 24, weight: .heavy, design: .rounded))
                    Spacer()
                    Button(action: {
                        print("Clicked")
                    }) {
                        Image(systemName: "arrow.right")
                            .imageScale(.large)
                            .foregroundColor(Color.white)
                    }
                    .padding(20)
                    .background(Color.tryit)
                    .clipShape(Circle())
                }
                
            }.font(.system(size: 18, weight: .light))
            
            
            VStack {
                HStack {
                    Button(action: {
                        print("Sign Up")
                    }) {
                        Text("Sign up")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .overlay(Rectangle().fill(Color.mainFgColor).frame(height: 2).offset(y: 2), alignment: .bottom)
                    }
                    Spacer()
                    Button(action: {
                        print("Forgot Password")
                    }) {
                        Text("Forgot Password")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .overlay(Rectangle().fill(Color.mainFgColor).frame(height: 2).offset(y: 2), alignment: .bottom)
                    }
                }
            }
        }
        .foregroundColor(.tryit)
        .padding()
        .padding()
    }
    
    func toStars() -> String {
        let str = self.password
        
        let stars = [String](repeating: "*", count: str.count)
        
        let newPass = str.replacingOccurrences(of: str, with: stars.joined(), options: .caseInsensitive, range: .none)
        return newPass
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}

