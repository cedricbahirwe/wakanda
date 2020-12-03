//
//  AboutView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 12/2/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(alignment: .leading) {
            ColoredHeader("About Wakanda")
            Text("Wakanda app makes it easy to interact with Telco services and mobile money services through our fast and scure app. Wakanda is made by 'ABC Inc', A software development company founded in 2020. ABC Inc is one of the leaders in software development with a list of clients that include governement institutions, international organizations, and companies.")
                .font(.callout)
                .padding()
            Spacer()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
