//
//  MenuView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 11/4/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI


extension Color {
    static let mainFgColor = Color(red: 0.011, green: 0.37, blue: 0.351)
    static let secondaryBgColor = Color(.secondarySystemBackground)
    static let btnColor = Color(red: 0.201, green: 0.238, blue: 0.58)
    static let tryit = Color(red: 1/255, green: 50/255, blue: 32/255)
}

struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showLanguageView = false
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ColoredHeader("Main Menu")
                
                ScrollView {
                    NavigationLink(destination: SaveAccountsView()) {
                        MenuRow(image: "plus.circle.fill", title: "Save your accounts", subTitle: "Save your meter numbers etc")
                    }
                    MenuRow(image: "square.and.arrow.up.fill", title: "Share Wakanda", subTitle: "Share app with friends")
                        .onTapGesture { actionShareSheet()}
                    MenuRow(image: "person.3.fill", title: "Change Language", subTitle: "")
                        .onTapGesture { showLanguageView.toggle() }
                    NavigationLink(destination: AboutView()) {
                        MenuRow(image: "exclamationmark.circle.fill", title: "About Wakanda", subTitle: "")
                    }
                    NavigationLink(destination: FAQView()) {
                        MenuRow(image: "bubble.left.and.bubble.right.fill", title: "FAQ", subTitle: "")
                    }
                    MenuRow(image: "envelope.fill", title: "Email Support", subTitle: "")
                    MenuRow(image: "lock.shield.fill", title: "Logout", subTitle: "")
                    
                    Text("Version: 3.0.0 Build: 30")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                }
                .padding(.leading)
                .padding(.trailing, 5)
            }
            .background(Color.secondaryBgColor.ignoresSafeArea())
            .transition(.slide)
            if showLanguageView { LanguageView(showLanguageView: $showLanguageView) }
            
        }
        .poppableView()
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MenuView()
        }
        //            .environment(\.colorScheme, .dark)
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
                .foregroundColor(.mainFgColor)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(.label))
                
                if !subTitle.isEmpty {
                    Text(subTitle)
                        .foregroundColor(.gray)
                        .font(.system(size: 12, weight: .regular))
                }
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


struct ColoredHeader: View {
    @Environment(\.presentationMode) var presentationMode
    let title: String
    init(_ title: String) {
        self.title = title
    }
    var body: some View {
        HStack {
            Image(systemName: "arrow.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .onTapGesture {
                    withAnimation {
                        presentationMode.wrappedValue.dismiss()
                    }
            }
            Spacer().frame(width: 50)
            Text(title)
                .font(.system(size: 20))
                .bold()
        }
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: UIScreen.main.bounds.size.height/4)
        .background(mainBgColor.edgesIgnoringSafeArea(.top))
    }
}
