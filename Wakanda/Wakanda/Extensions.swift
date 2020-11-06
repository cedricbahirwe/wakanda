//
//  Extensions.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 11/6/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import Foundation
import SwiftUI


struct ListSeparatorStyle: ViewModifier {
    
    let style : UITableViewCell.SeparatorStyle
    func body(content: Content) -> some View {
        content
            .onAppear {
                UITableView.appearance().separatorStyle = self.style
        }
    }
}

extension View {
    func listSeparatorStyle(style:UITableViewCell.SeparatorStyle) -> some View {
        ModifiedContent(content: self, modifier: ListSeparatorStyle(style: style))
    }
}
