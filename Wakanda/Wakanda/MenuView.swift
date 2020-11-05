//
//  MenuView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 11/4/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI

let mainFgColor = Color(red: 0.011, green: 0.37, blue: 0.351)

struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "arrow.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        withAnimation {                            self.presentationMode.wrappedValue.dismiss()
                        }
                }
                Spacer().frame(width: 50)
                Text("Main Menu")
                    .font(.system(size: 20))
                    .bold()
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: UIScreen.main.bounds.size.height/4)
            .background(mainBgColor.edgesIgnoringSafeArea(.top))
            
            
            ScrollView {
                MenuRow(image: "plus.circle.fill", title: "Save your accounts", subTitle: "Save your meter numbers etc")
                MenuRow(image: "square.and.arrow.up.fill", title: "Share Wakanda", subTitle: "Share app with friends")
                MenuRow(image: "person.3.fill", title: "Change Language", subTitle: "")
                MenuRow(image: "exclamationmark.circle.fill", title: "About Wakanda", subTitle: "")
                MenuRow(image: "bubble.left.and.bubble.right.fill", title: "FAQ", subTitle: "")
                MenuRow(image: "envelope.fill", title: "Email Support", subTitle: "")
                MenuRow(image: "lock.shield.fill", title: "Logout", subTitle: "")
                
                Text("Version: 3.0.0 Build: 30")
                    .foregroundColor(Color(.lightGray))
                .font(.system(size: 14, weight: .semibold))
                
            }
            .padding(.leading)
            .padding(.trailing, 5)
        }.transition(.slide)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct MenuRow: View {
    let image: String
    let title: String
    let subTitle:String
    var body: some View {
        HStack(spacing: 30) {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 22, height: 22)
                .foregroundColor(mainFgColor)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 14, weight: .regular))
                
                if !self.subTitle.isEmpty {
                    Text(subTitle)
                        .foregroundColor(.gray)
                        .font(.system(size: 12, weight: .regular))
                }
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
