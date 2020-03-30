//
//  TextView.swift
//  Memorage
//
//  Created by Lex on 2020/3/30.
//  Copyright © 2020 Lex. All rights reserved.
//

import SwiftUI
import UIKit

struct TextView: UIViewRepresentable {
    
    typealias UIViewType = UITextView
    
    internal init(
        _ placeholderText: String = "Placeholder",
        text: Binding<String>
    ) {
        _text = text
        self.placeholderText = placeholderText
    }
    
    @Binding var text: String
    var placeholderText: String = "Placeholder"
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if text != "" || uiView.textColor == UIColor(named: "primaryLabel") {
            uiView.text = text
            uiView.textColor = UIColor(named: "primaryLabel")
        }
        
        uiView.delegate = context.coordinator
    }
    
    func frame(numLines: CGFloat) -> some View {
        let height = UIFont.systemFont(ofSize: 17, weight: .semibold).lineHeight * numLines
        return self.frame(height: height)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView(frame: .zero)
        //    textView.textContainer.lineFragmentPadding = 0
        //    textView.textContainerInset = .zero
        textView.textAlignment = .natural
        //    textView.font = .systemFont(ofSize: 17, weight: .semibold)
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.textColor = UIColor(named: "primaryLabel")
        textView.backgroundColor = UIColor(named: "secondaryBackground")
        //    textView.keyboardDismissMode = .interactive
        textView.returnKeyType = .done
        
        textView.text = placeholderText
        textView.textColor = .placeholderText
        return textView
    }
    
    func makeCoordinator() -> TextView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        
        init(_ parent: TextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            let language = UITextInputMode.activeInputModes.first?.primaryLanguage
            if language == "zh-Hans" {
                if textView.markedTextRange == nil {
                    parent.text = textView.text
                }
            } else { // 非中文不处理
                parent.text = textView.text
            }
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == .placeholderText {
                textView.text = ""
                textView.textColor = UIColor(named: "primaryLabel")
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = parent.placeholderText
                textView.textColor = .placeholderText
            }
            dismissKeyboard()
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                return false
            }
            return true
        }
    }
}
