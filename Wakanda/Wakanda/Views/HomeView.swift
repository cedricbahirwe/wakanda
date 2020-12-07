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
                ZStack(alignment: .bottom) {
                    ContainerView(title: "Pick a service") {
                        VStack(spacing: -20) {
                            VStack {
                                GridStack(rows: 2, columns: 2) { row, column in
                                    HomeMenuItem(image: self.images[self.indexFor(row,column)],
                                                 label: self.labels[self.indexFor(row,column)])
                                        
                                        .frame(width: geo.size.width/2.2,
                                               height: geo.size.width/2.2)
                                        .background(Color(.tertiarySystemBackground).opacity(01))
                                        .cornerRadius(10)
                                }
                                .padding()
                                Spacer()
                            }
                            
                            
                        }
                    }
                    .hidden()
                    HStack {
                        Image(systemName: "house.fill")
                            .foregroundColor(.mainFgColor)
                        Spacer()
                        Image("logo")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.mainFgColor)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 38, alignment: .bottom)
                        Spacer()
                    }
                    .padding(6)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemBackground).shadow(color: Color.gray, radius: 2).edgesIgnoringSafeArea(.bottom))
                        
                    .overlay(
                        
                        NavigationLink(destination: ShortcutView()) {
                            Image(systemName: "suit.heart.fill")
                                .foregroundColor(.mainFgColor)
                                .frame(width: 50,height: 50)
                                .background(Color(.systemBackground))
                                .clipShape(Circle())
                                .shadow(radius: 0.5)
                                .padding(4)
                                .background(Color.secondaryBgColor)
                                .clipShape(Circle())
                                
                                .offset(x: -25, y: -25)
                        }
                        , alignment: .topTrailing
                    )
                    
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                
            }
        }
        
        
    }
    private func indexFor(_ row: Int, _ column: Int) -> Int {
        return  row * 2 + column
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        .environment(\.colorScheme, .dark)
    }
}

