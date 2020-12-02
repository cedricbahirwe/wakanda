//
//  HomeView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 11/6/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    private var labels = ["MTN Mobile Money", "MTN Airtime & Internet", "Airtel Money", "Rwanda Useful Codes"]
    private var images = ["momo", "mtn", "airtel", "rwanda"]
    
    @State var row = 2
    @State var column = 2
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                ContainerView(title: "Pick a service") {
                    VStack(spacing: -20) {
                        VStack {
                            
                            GridStack(rows: 2, columns: 2) { row, column in
                                HomeMenuItem(image: self.images[self.index(at: row, and: column)],
                                              label: self.labels[self.index(at: row, and: column)])
                                    
                                    .frame(width: geo.size.width/2.2,
                                           height: geo.size.width/2.2)
                                    .background(Color(red: 0.964, green: 0.97, blue: 0.976))
                                    .cornerRadius(10)
                            }
                            .padding()
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .padding(.bottom, 20)
                        .cornerRadius(30)
                        
                        HStack {
                            Image(systemName: "house.fill")
                                .foregroundColor(.mainFgColor)
                            Spacer()
                            Image("hexa")
                                .resizable()
                                .frame(width: 60, height: 38, alignment: .bottom)
                            Spacer()
                        }
                        .padding(6)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .background(Color.white.shadow(color: Color.black, radius: 2).edgesIgnoringSafeArea(.bottom))
                            
                        .overlay(
                            
                            Image(systemName: "suit.heart.fill")
                                .foregroundColor(.mainFgColor)
                                .frame(width: 50,height: 50)
                                .background(Color.white)
                                .clipShape(Circle())
                                .padding(4)
                                .background(Color.black)
                                .clipShape(Circle())
                                
                                .offset(x: -25, y: -25)
                            , alignment: .topTrailing
                        )
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }
        
        
    }
    private func index(at row: Int, and column: Int) -> Int {
        return (((self.column * (row + 1)) + column + 1) - self.row)-1
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

