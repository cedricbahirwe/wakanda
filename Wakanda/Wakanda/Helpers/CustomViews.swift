//
//  CustomViews.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 11/6/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import Foundation
import SwiftUI

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

struct HomeMenuItem: View {
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


struct DetailRow: View {
    let leftImage: String
    let title: String
    let rightImage: String
    var body: some View {
        HStack {
            Image(systemName: leftImage)
                .resizable()
                .frame(width: 25, height: 25)
                .padding(.trailing)
            Text(title)
            Spacer()
            Image(systemName: rightImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
        }
    }
}
