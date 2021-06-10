//
//  HomeView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 11/6/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Binding var goToShortcuts: Bool
    var labels = ["MTN Mobile Money", "MTN Airtime & Internet", "Airtel Money", "Rwanda Useful Codes"]
    var images = ["money", "5g", "air", "earth"]
    
    var body: some View {
        GeometryReader { geo in
            ContainerView(title: "Pick a service") {
                VStack {
                    GridStack(rows: 2, columns: 2) { row, column in
                        NavigationLink(destination: DetailView()) {
                            HomeMenuItem(image: images[indexFor(row,column)],
                                         label: labels[indexFor(row,column)])
                                
                                .frame(width: geo.size.width/2.2,
                                       height: geo.size.width/2.2)
                                .background(Color(.tertiarySystemBackground).opacity(01))
                                .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding()
                    Spacer()
                }
            }
            .hasTabView()
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
        }
        
    }
    private func indexFor(_ row: Int, _ column: Int) -> Int {
        return  row * 2 + column
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(goToShortcuts: .constant(false))
        //            .environment(\.colorScheme, .dark)
    }
}



struct HasTab: ViewModifier {
    let image: String
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
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
                    Image(systemName: image)
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
    }
}

extension View {
    func hasTabView(_ image: String = "suit.heart.fill" ) -> some View {
        modifier(HasTab(image: image))
    }
}
