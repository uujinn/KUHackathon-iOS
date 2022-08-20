//
//  Date.swift
//  KUHackerthon-ios
//
//  Created by 양유진 on 2022/08/20.
//

import Foundation

extension Date
{
  func toString(dateFormat format: String ) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
    
  }
  
}
