//
//  ContentLengthPreference.swift
//  DSDInfo2 (iOS)
//
//  Created by Joe Chan on 19/9/2022.
//

import Foundation
import SwiftUI

struct ContentLengthPreference: PreferenceKey {
   static var defaultValue: CGFloat { 0 }
   
   static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
      value = nextValue()
   }
}
