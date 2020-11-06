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
        ContainerView(title: parentTitle) {
            List(0..<5) { index in
                DetailRow(leftImage: "mappin.circle.fill", title: "Check Airtime Balance", rightImage: "chevron.right")
                    .padding()
                    .background(mainBgColor)
                    .cornerRadius(5)
                    .shadow(radius: 3)
            }
            .listSeparatorStyle(style: .none)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
