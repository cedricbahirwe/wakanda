//
//  Extensions.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 11/6/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import Foundation
import SwiftUI


struct PopView: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture(minimumDistance: 50)
                    .onEnded { _ in
                        withAnimation {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
            )
    }
}

extension View {
    func poppableView() -> some View {
        ModifiedContent(content: self, modifier: PopView())
    }
}

extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
}


extension String {
    var isMtnNumber: Bool {
        return
            trimmingCharacters(in: .whitespaces).hasPrefix("+25078") ||
            trimmingCharacters(in: .whitespaces).hasPrefix("25078") ||
            trimmingCharacters(in: .whitespaces).hasPrefix("078") ||
            hasPrefix("")
    }
}


extension Array where Element == String  {
    var firstElement: String {
        get { return first ?? "" }
        set(value) { self[0] = value }
    }
}

