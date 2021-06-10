//
//  DetailView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 11/6/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let parentTitle: String = ""
    var body: some View {
        ContainerView(showBackButton: true, title: parentTitle) {
            ScrollView {
                VStack {
                    ForEach(0..<5) { index in
                        DetailRow(leftImage: "mappin.circle.fill", title: "Check Airtime Balance", rightImage: "chevron.right")
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(8)
                            .padding(2)
                    }
                }
            }
            .padding(.top)
        }
        .poppableView()
    .hasTabView()
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
