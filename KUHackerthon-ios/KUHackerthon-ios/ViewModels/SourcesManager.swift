//
//  SourcesManager.swift
//  KUHackerthon-ios
//
//  Created by 양유진 on 2022/08/20.
//

import Foundation
import Alamofire
import Combine

enum SourcesManager: URLRequestConvertible {
  
  case getSources
  
  var baseURL: URL {
    switch self {
    case .getSources:
      return URL(string: "http://34.238.235.31/sources")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getSources:
      return .get
    }
  }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    switch self {
    case .getSources:
      return headers

    }
  }
  
  var parameters: Parameters {
    var params = Parameters()
    
    switch self {
    case let .getSources:
      return params
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = baseURL
    
    var request = URLRequest(url: url)
    request.method = method
    request.headers = headers
    
    request = try URLEncoding.default.encode(request, with: parameters)
    
    return request
  }
}

