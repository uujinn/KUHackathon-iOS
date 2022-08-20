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
  @Published var sources: [Sources]
  
  init(){
    sources = []
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
          self.sources = receivedValue.sources ?? []
          print(self.sources)
          print(self.sources.count)
        })
      .store(in: &cancellables)
  }
  
}
