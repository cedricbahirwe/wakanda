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
    @State private var goToShortcuts = false
    var body: some View {
        NavigationView {
            LoginPageView()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
