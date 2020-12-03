//
//  FAQView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 12/2/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI

public let size = UIScreen.main.bounds.size
struct FAQView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Color.mainFgColor.edgesIgnoringSafeArea(.all)
            VStack(alignment :. leading) {
                HStack {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(3)
                        .frame(width: 25, height: 25)
                        .onTapGesture {
                            withAnimation {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                    }
                    Spacer()
                    Text("FAQ")
                        .font(.headline)
                        .bold()
                    Spacer()
                    
                }.padding(.bottom)
                
               
                    VStack(alignment: .leading) {
                    QAView(question: "Do I need internet to use Wakanda ?", answer: "No, Wakanda only reuires internet ot login/register, after which can be used offline")
                    QAView(question: "Is Wakanda a digital wallet ?", answer: "No, Wakanda helps you use your existing wallet")
                    }
                Spacer()
            }
            .padding()
            Spacer()
        }
        .foregroundColor(.white)
        .poppableView()
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}

struct QAView: View {
    let question: String
    let answer: String
    @State private var showAnswer = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                Image(systemName: showAnswer ? "chevron.up" : "chevron.down")
                    .onTapGesture {
                        withAnimation(.spring()) {
                            self.showAnswer.toggle()
                        }
                }
                Text(question)
            }
            if self.showAnswer {
                HStack {
                    Spacer()
                    Text(answer)
                        .font(.footnote)
                        .frame(maxWidth: size.width/1.5)
                        .padding(10)
                        .background(Color.white.opacity(0.75))
                        .foregroundColor(.mainFgColor)
                        .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                }
            }
        }
    }
}
