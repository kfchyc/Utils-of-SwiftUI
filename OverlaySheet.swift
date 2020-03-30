//
//  OverlaySheet.swift
//  Memorage
//
//  Created by Lex on 2020/3/30.
//  Copyright © 2020 Lex. All rights reserved.
//

import SwiftUI

struct OverlaySheet<Content: View>: View {
    
    private let isPresented: Binding<Bool>
    private let justDark: Bool
    private let makeContent: () -> Content
    
    @GestureState private var translation = CGPoint.zero
    @Environment(\.colorScheme) var colorScheme
    
    init(isPresented: Binding<Bool>, justDark: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.isPresented = isPresented
        self.justDark = justDark
        self.makeContent = content
    }
    
    var body: some View {
        ZStack {
            if !justDark {
            BlurView(style: self.colorScheme == .light ? .extraLight : .dark)
                .opacity((isPresented.wrappedValue ? 1 : 0) - Double(max(0, translation.y) / UIScreen.main.bounds.size.height))
                .edgesIgnoringSafeArea(.vertical)
                .onTapGesture(perform: {
                    dismissKeyboard()
                    self.isPresented.wrappedValue.toggle()
                })
                .animation(.interactiveSpring())
            } else {
                Rectangle()
                    .opacity((isPresented.wrappedValue ? 0.5 : 0) - Double(max(0, translation.y) / UIScreen.main.bounds.size.height))
                    .edgesIgnoringSafeArea(.vertical)
                    .onTapGesture(perform: {
                        dismissKeyboard()
                        self.isPresented.wrappedValue.toggle()
                    })
                    .animation(.interactiveSpring())
            }
            VStack {
                Spacer()
                makeContent()
            }
            .offset(y: (isPresented.wrappedValue ? 0 : UIScreen.main.bounds.height) + max(0, translation.y))
            .animation(.interactiveSpring())
            .edgesIgnoringSafeArea(.vertical)
            .gesture(panelDraggingGesture)
        }
    }
    
    var panelDraggingGesture: some Gesture {
        DragGesture()
            .updating($translation) { current, state, _ in
                state.y = current.translation.height
        }
        .onEnded { state in
            if state.translation.height > 200 {
                self.isPresented.wrappedValue = false
            }
        }
    }
}

extension View {
    func overlaySheet<Content: View>(
        isPresented: Binding<Bool>,
        justDark: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View
    {
        overlay(
            OverlaySheet(isPresented: isPresented, justDark: justDark, content: content)
        )
    }
}
