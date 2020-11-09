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
                 MenuRow(image: "qrcode", title: "Show my qrcode", subTitle: "")
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color.black, radius: 3, x: 3, y: 2)
                
                MenuRow(image: "phone.circle.fill", title: "For Others", subTitle: "MTN MOBILE MONEY")
                    .background(Color.white)
                    .overlay(
                        Image(systemName: "trash")
                            .imageScale(.small)
                            .foregroundColor(.red)
                        .padding()
                        , alignment: .trailing)
                Spacer()
                
            }
            .padding()
            
        }
        
    }
}

struct ShortcutView_Previews: PreviewProvider {
    static var previews: some View {
        ShortcutView()
    }
}
