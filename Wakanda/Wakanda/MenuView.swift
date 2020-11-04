//
//  MenuView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 11/4/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            VStack {
                Text("Wakanda")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    
                .overlay(
                    Text("Wakanda")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                        .foregroundColor(.orange)
                    .shadow(radius: 2)
                )
            }
        }
        
        .frame(width: 200, height: 200)
        .background(Color.orange)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
