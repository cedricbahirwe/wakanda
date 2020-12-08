//
//  LanguageView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 12/2/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI

struct LanguageView: View {
    
    @Binding var showLanguageView: Bool
    @State private var languages: [String] = ["Select", "French", "English", "Swahili"]
    @State private var language = "Select"
    
    var body: some View {
        VStack {
            Picker(selection: $language, label: Text("")) {
                ForEach(self.languages, id: \.self) { language in
                    Text(language)
                        .font(.title)
                    
                }
            }
            .labelsHidden()
            .frame(width: size.width/2)
            .clipped()
            .padding()
            
            Divider()
            Button(action: {
                withAnimation {
                    self.showLanguageView = false
                }
            }) {
                Text("Close")
                    .fontWeight(.light)
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
                    .padding(.bottom, 5)
            }
        }
        .frame(width: size.width/1.5)
        .background(Color(.systemBackground).opacity(0.8).blur(radius: 0.7, opaque: true))
        .cornerRadius(10)
        
    }
}

struct LanguageView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageView(showLanguageView: .constant(true))
            .environment(\.colorScheme, .dark)
    }
}
