//
//  ShortcutView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 11/9/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI

struct ShortcutView: View {
    var body: some View {
        ContainerView(showBackButton: true, title: "Shortcuts") {
            VStack {
                NavigationLink(destination: QRView()) {
                    MenuRow(image: "qrcode", title: "Show my qrcode", subTitle: "")
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(radius: 3)
                }
                
                NavigationLink(destination: SendingView()) {
                    MenuRow(image: "phone.circle.fill", title: "For Others", subTitle: "MTN MOBILE MONEY")
                        .background(Color.white)
                        .cornerRadius(5)
                        .overlay(
                            Image(systemName: "trash")
                                .imageScale(.small)
                                .foregroundColor(.red)
                                .padding()
                            , alignment: .trailing)
                }
                Spacer()
                
            }
            .padding()
            
        }
        .poppableView()
        .hasTabView("plus.circle.fill")
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
}

struct ShortcutView_Previews: PreviewProvider {
    static var previews: some View {
        ShortcutView()
        //            .environment(\.colorScheme, .dark)
    }
}
