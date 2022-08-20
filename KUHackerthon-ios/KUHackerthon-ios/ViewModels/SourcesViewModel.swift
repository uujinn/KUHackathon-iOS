//
//  SourcesViewModel.swift
//  KUHackerthon-ios
//
//  Created by 양유진 on 2022/08/20.
//

import Foundation
import Alamofire
import Combine

class SourcesViewModel: ObservableObject {
  @Published var audio_link: String
  
  init(){
    audio_link = "inital"
    getSources()
  }
  
  private var cancellables = Set<AnyCancellable>()    // disposeBag

  
  func getSources() { // '메인'뷰의 정보 불러오기
    AF.request(SourcesManager.getSources)
      .publishDecodable(type: SourcesResponse.self)
      .value()
      .sink(
        receiveCompletion: { completion in
        },
        receiveValue: { receivedValue in
          self.audio_link = receivedValue.link ?? "no"
          print(self.audio_link)
        })
      .store(in: &cancellables)
  }
  
}
