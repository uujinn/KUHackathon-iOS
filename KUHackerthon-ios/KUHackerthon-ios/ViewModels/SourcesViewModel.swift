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
  
  func postEdit(ids: [Int], filename: String) {
    AF.request(SourcesManager.postSources(ids: ids, filename: filename))
      .publishDecodable(type: UploadFilesAPIResponse.self)
      .value()
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: {completion in
          guard case .failure(let error) = completion else { return }
          NSLog("Error : " + error.localizedDescription)
          print("MESSAGE POST 성공")
          
        },
        receiveValue: {receivedValue in
          NSLog("받은 값 : \(receivedValue)")
        }
      )
      .store(in: &cancellables)
  }
  
}
