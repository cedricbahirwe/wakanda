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
    @State private var goToShortcuts = false
    
    
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
        GeometryReader { _ in
            VStack(alignment: .leading, spacing: 80) {
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text("Welcome to")
                        Text("WAKANDA!")
                    }
                    .font(.system(size: 30, weight: .heavy, design: .rounded))
                    Spacer()
                    Image("black-panther")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 70)
                        .foregroundColor(.tryit)
                }
                .padding(.top)
                VStack(spacing: 30) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Email")
                            .opacity(didBeginEmailEditing ? 0.6 : 1)
                            .offset(x: 0, y: didBeginEmailEditing ? 0 : 20)
                        TextField("", text: $email, onEditingChanged: { editing in
                            if editing {
                                withAnimation {
                                    didBeginEmailEditing = editing
                                }
                            }
                        }, onCommit: {
                            if email.isEmpty {
                                withAnimation {
                                    didBeginEmailEditing = false
                                }
                            }
                        })
                        .disableAutocorrection(true)
                        .overlay(Rectangle().fill(validateEmail ? Color.mainFgColor : .red).frame(height: 1).offset(y: 5), alignment: .bottom)
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Password")
                            .opacity(isEditingPassword ? 0.6 : 1)
                            .offset(x: 0, y: isEditingPassword ? 0 : 20)
                        TextField("Password", text: $password ,onEditingChanged: { editing in
                            if editing {
                                withAnimation {
                                    isEditingPassword = editing
                                }
                            }
                        }, onCommit: {
                            if password.isEmpty {
                                withAnimation {
                                    isEditingPassword = false
                                }
                            }
                        })
                        .overlay(
                            Rectangle()
                                .fill(validatePassword ? Color.mainFgColor : .red)
                                
                                .frame(height: 1)
                                .offset(y: 5)
                            , alignment: .bottom)
                    }
                    
                    HStack {
                        Text("Sign in")
                            .font(.system(size: 24, weight: .heavy, design: .rounded))
                        Spacer()
                        NavigationLink(
                            destination:  HomeView(goToShortcuts: $goToShortcuts)) {
                            Image(systemName: "arrow.right")
                                .imageScale(.large)
                                .foregroundColor(Color(.systemBackground))
                                .padding(20)
                                .background(Color.tryit)
                                .clipShape(Circle())
                        }
                    }
                    
                }
                .font(.system(size: 18, weight: .light))
                
                
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
                Spacer()
                Spacer()
            }
            .foregroundColor(.tryit)
            .padding([.horizontal], 32)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .ignoresSafeArea(.all, edges: .bottom)        
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}

