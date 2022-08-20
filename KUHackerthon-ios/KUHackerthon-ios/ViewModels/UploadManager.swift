//
//  UploadManager.swift
//  KUHackerthon-ios
//
//  Created by 양유진 on 2022/08/20.
//

import Foundation
import Alamofire
import Combine

enum UploadManager: URLRequestConvertible {
  
  case postFiles

  var baseURL: URL {
    switch self {
    case .postFiles:
//      return URL(string: "\(APIConstants.url)/files")!
      return URL(string: "http://13.209.69.54/source")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .postFiles:
      return .post
    }
  }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
//    headers["Authorization"] = "Bearer \(Constant.accessToken ?? "")"

    switch self {
    case .postFiles:
      headers["Content-Type"] = "multipart/form-data"
      headers["accept"] = "application/json"
    }
    return headers
  }
  
  var parameters: Parameters {
    var params = Parameters()
    
    switch self {
    case .postFiles:
      break
    }
    return params

  }
  
  func asURLRequest() throws -> URLRequest {
    let url = baseURL
    
    var request = URLRequest(url: url)
    request.method = method
    request.headers = headers
    
    switch self {
    case .postFiles:
      request = try URLEncoding.default.encode(request, with: nil)
    }
    
    return request
  }
}

