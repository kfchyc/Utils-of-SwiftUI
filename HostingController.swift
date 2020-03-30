//
//  HostingController.swift
//  Check It
//
//  Created by Lex on 2020/1/25.
//  Copyright © 2020 lex. All rights reserved.
//

import Foundation
import SwiftUI

class HostingController<Content>: UIHostingController<Content> where Content: View {
  override var prefersHomeIndicatorAutoHidden: Bool {
    true
  }
}
