//
//  Constants.swift
//  KUHackerthon-ios
//
//  Created by 양유진 on 2022/08/20.
//

import SwiftUI

struct Screen {
  static let maxWidth = UIScreen.main.bounds.width
  static let maxHeight = UIScreen.main.bounds.height
  
  static var safeAreaTop: CGFloat {
    let keyWindow = UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    return keyWindow.top
  }
  
  static var safeAreaBottom: CGFloat {
    let keyWindow = UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    return keyWindow.bottom
  }
}
