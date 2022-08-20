//
//  convertSecToMinAndHour.swift
//  KUHackerthon-ios
//
//  Created by 양유진 on 2022/08/20.
//

import Foundation

extension VoiceViewModel {
  func covertSecToMinAndHour(seconds : Int) -> String{
    
    let (_,m,s) = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    let sec : String = s < 10 ? "0\(s)" : "\(s)"
    return "\(m):\(sec)"
    
  }
}
