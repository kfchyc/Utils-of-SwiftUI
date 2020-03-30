//
//  LRTextField.swift
//  Memorage
//
//  Created by Lex on 2020/3/30.
//  Copyright © 2020 Lex. All rights reserved.
//

import SwiftUI

import SwiftUI
import UIKit

struct LRTextField: UIViewRepresentable {
    
    typealias UIViewType = UITextField
    
    internal init(
        _ placeholder: String = "",
        text: Binding<String>
    ) {
        self._text = text
        self.placeholder = placeholder
    }
    
    @Binding var text: String
    var placeholder: String
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<LRTextField>) {
        if text != "" || uiView.textColor == UIColor(named: "primaryLabel") {
            uiView.text = text
            uiView.textColor = UIColor(named: "primaryLabel")
        }
        
        uiView.delegate = context.coordinator
    }
    
    func makeUIView(context: UIViewRepresentableContext<LRTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.textAlignment = .natural
//        textField.font = .systemFont(ofSize: 17, weight: .semibold)
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.textColor = UIColor(named: "primaryLabel")
        textField.backgroundColor = .clear
        textField.returnKeyType = .done
        
        textField.text = placeholder
        textField.textColor = .placeholderText
        
        return textField
    }
    
    func makeCoordinator() -> LRTextField.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: LRTextField
        
        init(_ parent: LRTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            let language = UITextInputMode.activeInputModes.first?.primaryLanguage
            if language == "zh-Hans" {
                if textField.markedTextRange == nil {
                    parent.text = textField.text ?? ""
                }
            } else {
                parent.text = textField.text ?? ""
            }
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            if textField.textColor == .placeholderText {
                textField.text = ""
                textField.textColor = UIColor(named: "primaryLabel")
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            if textField.text == "" {
                textField.text = parent.placeholder
                textField.textColor = .placeholderText
            }
        }
        
    }
}
