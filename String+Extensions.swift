//
//  String+Extensions.swift
//  Memorage
//
//  Created by Lex on 2020/3/30.
//  Copyright © 2020 Lex. All rights reserved.
//

import Foundation
import SwiftUI

extension String {
    func getText() -> Text {
        return Text(self)
    }
    func localized() -> String {
        return NSLocalizedString(self, comment: self)
    }
    func size(with font: UIFont) -> CGSize {
        return self.size(withAttributes: [NSAttributedString.Key.font: font])
    }
}

extension String {
    
    public func size(withFont font: UIFont) -> CGSize {
        return self.size(withAttributes: [NSAttributedString.Key.font: font])
    }
    
    public func size(withFontStyle fontStyle: UIFont.TextStyle) -> CGSize {
        return self.size(withAttributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: fontStyle)])
    }
}
