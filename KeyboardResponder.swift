//
//  KeyboardResponder.swift
//  Memorage
//
//  Created by Lex on 2020/3/30.
//  Copyright © 2020 Lex. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

final class KeyboardResponder: ObservableObject {
    
    private var notificationCenter: NotificationCenter
    
    init(center: NotificationCenter = .default) {
        notificationCenter = center
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // Update layout
            currentHeight = keyboardSize.height
        }
    }
    @objc func keyBoardWillHide(notification: Notification) {
        // Update layout
        currentHeight = 0
    }
    
    @Published private(set) var currentHeight: CGFloat = 0
    
}


