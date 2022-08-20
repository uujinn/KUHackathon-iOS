//
//  AudioUploadViewModel.swift
//  KUHackerthon-ios
//
//  Created by 양유진 on 2022/08/20.
//

import Foundation
import Alamofire
import Combine

class AudioUploadViewModel: ObservableObject {
  private var subscription = Set<AnyCancellable>()    // disposeBag
  
  // 서버에 파일 업로드 후, Link 받아오기
  func uploadfiles(audio: URL?, filename: String?) {
//    print(#fileID, #function, #line, "")
    
    AF.upload(multipartFormData: { multipartFormData in
      if let audio = audio { // 오디오
        let fileName = audio.lastPathComponent
        guard let audioFile: Data = try? Data(contentsOf: audio) else { return }
        multipartFormData.append(audioFile, withName: "upload_file", fileName: fileName, mimeType: "audio/m4a")
      }
    }, with: UploadManager.postFiles)
    .publishDecodable(type: UploadFilesAPIResponse.self)
    .value()
    .receive(on: DispatchQueue.main)
    .sink(
      receiveCompletion: { complete in
        guard case .failure(let error) = complete else { return }
        NSLog("Error : " + error.localizedDescription)
      },
      receiveValue: {[weak self] receivedValue in
//        NSLog("받은 값 : \(receivedValue)")
//        guard let links = receivedValue.links else {
//          NSLog("links를 받아오지 못했습니다")
//          return
//        }
//
//        if audio != nil { // 오디오
//          self?.postUploadRecording(date: date, title: title!, links: links)
//        }
      }
    )
    .store(in: &subscription)   // disposed(by: disposeBag)
  }
  
}

