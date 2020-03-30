//
//  GenericFunctions.swift
//  Memorage
//
//  Created by Lex on 2020/3/30.
//  Copyright © 2020 Lex. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import AVFoundation

public func dismissKeyboard() {
  UIApplication.shared.windows.forEach { $0.endEditing(true)}
}

public enum SoundType: CaseIterable {
  case expand, collapse, complete, tab, cancel, alert, success, error, button, changeCategory
}
extension SoundType {
  
  var name: String {
    switch self {
    case .expand:
      return "expand"
    case .collapse:
      return "collapse"
    case .complete:
      return "complete"
    case .tab:
      return "tab"
    case .cancel:
      return "cancel"
    case .alert:
      return "alert"
    case .success:
      return "success"
    case .error:
      return "error"
    case .button:
      return "button"
    case .changeCategory:
      return "changeCategory"
    }
  }
  
  var url: URL? {
    if let path = Bundle.main.path(forResource: self.name, ofType: "m4a") {
      return URL(fileURLWithPath: path)
    } else {
      return nil
    }
  }
  
  var sound: AVAudioPlayer? {
    if let url = self.url {
      do {
        return try AVAudioPlayer(contentsOf: url)
      } catch {
        print("[ERROR]: sound file cannot found!")
        return nil
      }
    } else {
      return nil
    }
  }
}
