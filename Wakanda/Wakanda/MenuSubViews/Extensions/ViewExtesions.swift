//
//  ViewExtesions.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 12/2/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

extension View {
    /// Use this for sharinf an event which is passed by its Id
    func actionShareSheet() {
        let link = "Download this great app called Wakanda.  It gives your existing mobile money wallet super powers. Say goodbye to copy and pasting phone numbers and meter numbers. Click below to download it for free. \n https://www.linkedin.com/in/cedricbahirwe/"
        let av = UIActivityViewController(activityItems: [link], applicationActivities: nil)
        av.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("Completed")
            } else {
                print("Canceled")
            }
        }
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

// Dismiss keyboard
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
