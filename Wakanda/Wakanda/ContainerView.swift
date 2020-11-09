//
//  ContainerView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 11/6/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI

struct ContainerView<Content: View>: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var showBackButton = false
    let title: String
    var content: () -> Content
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if self.showBackButton {
                Image(systemName: "arrow.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: 30, height: 20)
                    .padding(.leading, 8)
                    .onTapGesture {
                        withAnimation {                            self.presentationMode.wrappedValue.dismiss()
                        }
                }
                }
                Spacer()
                Text("Wakanda")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .shadow(radius: 4)
                    
                    .overlay(
                        Text("Wakanda")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(radius: 10)
                )
                Spacer()
                
            }.overlay(
                NavigationLink(destination: MenuView()) {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                },
                alignment: .trailing)
                .padding()
                .foregroundColor(.white)
            
            VStack(spacing: -20) {
                Text(self.title)
                    .font(.callout)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                content()
            }
            
        }
        .frame(maxWidth: .infinity)
        .background(mainBgColor.edgesIgnoringSafeArea(.all))

    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView(title: "Pick a Service") {
            HomeView()
        }
    }
}
