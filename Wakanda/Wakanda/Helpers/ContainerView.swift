//
//  ContainerView.swift
//  Wakanda
//
//  Created by Cedric Bahirwe on 11/6/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI

struct ContainerView<Content: View>: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var showBackButton = false
    let title: String
    var content: () -> Content
    var height: CGFloat = size.height*0.8
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    if self.showBackButton {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 30, height: 20)
                            .onTapGesture {
                                withAnimation {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                        }
                    }
                    Spacer()
                    
                    Text("Wakanda")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .shadow(radius: 4)
                        
                        .overlay(
                            Text("Wakanda")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(radius: 10)
                    )
                    Spacer()
                    
                }.overlay(
                    NavigationLink(destination: MenuView()) {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                    },
                    alignment: .trailing)
                    .padding()
                    .foregroundColor(.white)
                Spacer()
            }
            
            ModalView(title: title, isShown: .constant(true)) {
                self.content()
            }
        }
        .frame(maxWidth: .infinity)
        .background(mainBgColor.ignoresSafeArea())
        
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView(title: "Pick a Service") {
            Text("This is the best scam")
        }
    }
}


struct ModalView<Content: View> : View {
    let title: String
    @GestureState private var dragState = DragState.inactive
    @Binding var isShown:Bool
    
    private func onDragEnded(drag: DragGesture.Value) {
        let dragThreshold = modalHeight * (2/3)
        if drag.predictedEndTranslation.height > dragThreshold || drag.translation.height > dragThreshold{
            isShown = false
        }
    }
    
    var modalHeight:CGFloat = size.height*0.8
    
    
    var content: () -> Content
    var body: some View {
        let drag = DragGesture()
            .updating($dragState) { drag, state, transaction in
                state = .dragging(translation: drag.translation)
        }
        .onEnded(onDragEnded)
        return Group {
            ZStack {
                //Background
                //                Spacer()
                //                    .ignoresSafeArea()
                //                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                //                    .background(isShown ? Color.black.opacity( 0.5 * fraction_progress(lowerLimit: 0, upperLimit: Double(modalHeight), current: Double(dragState.translation.height), inverted: true)) : Color.clear)
                //                    .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                //                    .gesture(
                //                        TapGesture()
                //                            .onEnded { _ in
                //                                self.isShown = false
                //                        }
                //                )
                //Foreground
                VStack{
                    Spacer()
                    VStack {
                        Text(title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        ZStack{
                            Color.secondaryBgColor.opacity(1.0)
                                .frame(width: size.width, height:modalHeight)
                                .cornerRadius(30, corners: [.topLeft, .topRight])
                                .onTapGesture {
                                    self.hideKeyboard()
                            }
                            self.content()
                                .padding()
                                .padding(.bottom, 65)
                                .frame(width: size.width, height:modalHeight)
                                .clipped()
                        }
                        
                    }
                    .offset(y: isShown ? ((self.dragState.isDragging && dragState.translation.height >= 1) ? dragState.translation.height : 0) : modalHeight)
                    .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                    .gesture(drag)
                    
                    
                }
            }.ignoresSafeArea()
        }
    }
}

enum DragState {
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}



func fraction_progress(lowerLimit: Double = 0, upperLimit:Double, current:Double, inverted:Bool = false) -> Double{
    var val:Double = 0
    if current >= upperLimit {
        val = 1
    } else if current <= lowerLimit {
        val = 0
    } else {
        val = (current - lowerLimit)/(upperLimit - lowerLimit)
    }
    
    if inverted {
        return (1 - val)
        
    } else {
        return val
    }
    
}

struct PickerModalView<Content: View> : View {
    @Binding var isShown:Bool
    
    
    var modalHeight:CGFloat = 400
    
    var content: () -> Content
    var body: some View {
        return Group {
            ZStack {
                //Background
                Spacer()
                    .ignoresSafeArea()
                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                    .background(isShown ? Color.black.opacity( 0.5 * fraction_progress(lowerLimit: 0, upperLimit: Double(modalHeight), current: Double(0), inverted: true)) : Color.clear)
                    .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                    .gesture(
                        TapGesture()
                            .onEnded { _ in
                                self.isShown = false
                        }
                )
                
                //Foreground
                VStack{
                    Spacer()
                    ZStack{
                        Color(.systemBackground).opacity(1.0)
                            .frame(width: UIScreen.main.bounds.size.width, height:modalHeight)
                            .cornerRadius(10)
                            .shadow(color: Color(.label), radius: 3.5)
                            .onTapGesture {
                                self.hideKeyboard()
                        }
                        self.content()
                            .padding(10)
                            .padding(.bottom, 65)
                            .frame(width: UIScreen.main.bounds.size.width, height:modalHeight)
                            .clipped()
                    }
                    .offset(y: isShown ? 0: modalHeight)
                    .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                    
                }
            }.ignoresSafeArea()
        }
    }
}
