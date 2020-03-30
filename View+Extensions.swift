//
//  View+Extensions.swift
//  Memorage
//
//  Created by Lex on 2020/3/30.
//  Copyright © 2020 Lex. All rights reserved.
//

import SwiftUI

extension View {
    func endEditing(_ force: Bool) {
        UIApplication.shared.windows.forEach { $0.endEditing(force)}
    }
}
