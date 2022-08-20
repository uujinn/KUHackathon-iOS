//
//  Recording.swift
//  KUhackerthon-Sandbox
//
//  Created by 양유진 on 2022/08/20.
//

import Foundation

struct Recording: Equatable{
  let fileURL: URL
  let createdAt: Date
  var isPlaying: Bool
}
