//
//  ContentView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 11/4/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI

let mainBgColor: some View = Color.green.colorMultiply(Color.blue)

struct ContentView: View {
    
    private var labels = ["MTN Mobile Money", "MTN Airtime & Internet", "Airtel Money", "Rwanda Useful Codes"]
    private var images = ["momo", "mtn", "airtel", "rwanda"]
    
    @State var row = 2
    @State var column = 2
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack(spacing: 0) {
                    HStack {
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
                        Text("Pick a service")
                            .font(.callout)
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .padding(.bottom, 40)
                        VStack {
                            
                            GridStack(rows: 2, columns: 2) { row, column in
                                ExtractedView(image: self.images[self.index(at: row, and: column)],
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
                                .foregroundColor(mainFgColor)
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
                                .foregroundColor(mainFgColor)
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
                .frame(maxWidth: .infinity)
                .background(mainBgColor.edgesIgnoringSafeArea(.all))
            .navigationBarTitle("")
            .navigationBarHidden(true)
            }
        }
    }
    
    private func index(at row: Int, and column: Int) -> Int {
        return (((self.column * (row + 1)) + column + 1) - self.row)-1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0 ..< self.rows) { row in
                HStack(spacing: 0) {
                    ForEach(0 ..<  self.columns) { column in
                        self.content(row, column)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 5)
                    }
                }
            }
        }
    }
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content ) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

struct ExtractedView: View {
    let image: String
    let label: String
    var body: some View {
        VStack  {
            Image(image)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(5)
            Text(label)
                .font(.system(size: 14, weight: .regular))
                .lineLimit(2)
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 8)
    }
}
