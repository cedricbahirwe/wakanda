//
//  QRView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 12/3/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    private let filter = CIFilter.qrCodeGenerator()
    private let context = CIContext()
    var body: some View {
        ContainerView(showBackButton: true, title: "Receive Momo") {
            VStack {
                VStack {
                    Text("Your QR code for receiving MoMo from another")
                        .bold()
                        .foregroundColor(.mainFgColor)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                    Text("Wakanda user on +2507826511")
                        .bold()
                        .foregroundColor(.mainFgColor)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                }
                .padding(.bottom)
                Image(uiImage: self.generateQRCodeImage(from: "+250782628511"))
                    .interpolation(.none)
                    .resizable()
                    .frame(width: size.width/2, height: size.width/2)
                    .background(Color(.label))
            }
            .font(.body)
        }
    }
    
    private func generateQRCodeImage(from number: String) -> UIImage {
        let data = Data(number.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                let image = UIImage(cgImage: qrCodeCGImage)
                return image.imageWithColor(tintColor: colorScheme == .dark ? UIColor(red: 0.108, green: 0.108, blue: 0.119, alpha: 1) : .secondarySystemBackground)
            }
        }
        
        return UIImage(systemName: "qrcode") ?? UIImage()
        
    }
}

struct QRView_Previews: PreviewProvider {
    static var previews: some View {
        QRView()
        //            .environment(\.colorScheme, .dark)
    }
}

