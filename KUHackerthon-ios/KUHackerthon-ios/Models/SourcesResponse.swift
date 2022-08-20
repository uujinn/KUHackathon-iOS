//
//  SourcesResponse.swift
//  KUHackerthon-ios
//
//  Created by 양유진 on 2022/08/20.
//

import Foundation

struct SourcesResponse: Hashable, Decodable{
  let link: String?
  let title: String?
  let created_at: String?
  let img_link: String?
  let likes: Int
  let remix: Int
}

struct Sources: Hashable, Decodable{
  
}
